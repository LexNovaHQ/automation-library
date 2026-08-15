[CmdletBinding()]
param(
    [switch]$SkipComponentImport,
    [switch]$SkipTemplateImport
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

function Write-Step([string]$Message) {
    Write-Host "`n==> $Message" -ForegroundColor Cyan
}

function Invoke-DockerN8n([string[]]$Arguments) {
    & docker compose run --rm n8n n8n @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "n8n CLI command failed: n8n $($Arguments -join ' ')"
    }
}

$repo = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
Set-Location $repo

$build = Join-Path $repo '.build'
$componentImport = Join-Path $build 'import-components'
$templateCompiled = Join-Path $build 'compiled-templates'
$exportPath = Join-Path $build 'exported-workflows.json'

Write-Step 'Preparing local build directories'
Remove-Item $componentImport -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item $templateCompiled -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $componentImport, $templateCompiled | Out-Null

if (-not $SkipComponentImport) {
    Write-Step 'Collecting component and adapter workflow JSON files'
    $roots = @(
        (Join-Path $repo 'components'),
        (Join-Path $repo 'adapters')
    )

    $workflowFiles = foreach ($root in $roots) {
        if (Test-Path $root) {
            Get-ChildItem $root -Recurse -File -Filter '*.json' |
                Where-Object { $_.DirectoryName -match '[\\/]workflows$' }
        }
    }

    foreach ($file in $workflowFiles) {
        try {
            $null = Get-Content $file.FullName -Raw | ConvertFrom-Json
        } catch {
            throw "Invalid workflow JSON: $($file.FullName)"
        }

        $relative = [IO.Path]::GetRelativePath($repo, $file.FullName)
        $safeName = ($relative -replace '[\\/:*?"<>|]', '__')
        Copy-Item $file.FullName (Join-Path $componentImport $safeName)
    }

    Write-Host "Collected $($workflowFiles.Count) reusable workflow files." -ForegroundColor Green
}

Write-Step 'Stopping the long-running n8n service during CLI import/export'
docker compose stop n8n | Out-Host

try {
    if (-not $SkipComponentImport) {
        Write-Step 'Importing reusable components/adapters into the local n8n database'
        Invoke-DockerN8n @('import:workflow','--separate','--input=/workspace/build/import-components')
    }

    Write-Step 'Exporting local workflow database so runtime workflow IDs can be resolved'
    Invoke-DockerN8n @('export:workflow','--all','--output=/workspace/build/exported-workflows.json')

    if (-not (Test-Path $exportPath)) {
        throw "Expected n8n export was not created at $exportPath"
    }

    $parsed = Get-Content $exportPath -Raw | ConvertFrom-Json
    $workflows = if ($parsed -is [System.Collections.IEnumerable] -and -not ($parsed -is [string]) -and $parsed.PSObject.Properties.Name -notcontains 'name') {
        @($parsed)
    } else {
        @($parsed)
    }

    $workflowIdByName = @{}
    foreach ($workflow in $workflows) {
        if ($workflow.name -and $workflow.id) {
            $workflowIdByName[[string]$workflow.name] = [string]$workflow.id
        }
    }

    Write-Host "Resolved $($workflowIdByName.Count) workflow names to runtime IDs." -ForegroundColor Green

    Write-Step 'Compiling P0 template source workflows against runtime component IDs'
    $sourceTemplates = Get-ChildItem (Join-Path $repo 'templates\p0') -Recurse -File -Filter '*source*.json'
    $pattern = '__WF::(?<path>.+?)__'

    foreach ($source in $sourceTemplates) {
        $raw = Get-Content $source.FullName -Raw
        $compiled = [regex]::Replace($raw, $pattern, {
            param($match)
            $relativeSourcePath = $match.Groups['path'].Value.Replace('/', [IO.Path]::DirectorySeparatorChar)
            $workflowSourcePath = Join-Path $repo $relativeSourcePath
            if (-not (Test-Path $workflowSourcePath)) {
                throw "Template $($source.FullName) references missing workflow source: $relativeSourcePath"
            }

            $workflowSource = Get-Content $workflowSourcePath -Raw | ConvertFrom-Json
            $workflowName = [string]$workflowSource.name
            if (-not $workflowIdByName.ContainsKey($workflowName)) {
                throw "Runtime ID not found for workflow '$workflowName' referenced by $($source.Name). Import the reusable workflows first."
            }
            return $workflowIdByName[$workflowName]
        })

        try {
            $null = $compiled | ConvertFrom-Json
        } catch {
            throw "Compiled template is not valid JSON: $($source.FullName)"
        }

        $relative = [IO.Path]::GetRelativePath((Join-Path $repo 'templates\p0'), $source.FullName)
        $compiledName = ($relative -replace '[\\/:*?"<>|]', '__') -replace '-source','-compiled'
        Set-Content (Join-Path $templateCompiled $compiledName) $compiled -Encoding utf8
    }

    Write-Host "Compiled $($sourceTemplates.Count) template workflow files." -ForegroundColor Green

    if (-not $SkipTemplateImport -and $sourceTemplates.Count -gt 0) {
        Write-Step 'Importing compiled P0 templates into local n8n'
        Invoke-DockerN8n @('import:workflow','--separate','--input=/workspace/build/compiled-templates')
    }
}
finally {
    Write-Step 'Starting n8n service'
    docker compose up -d n8n | Out-Host
}

Write-Host @'

COMPILE / IMPORT COMPLETE
- Reusable component workflows are imported locally.
- Template source placeholders were resolved by workflow name to local runtime IDs.
- Compiled templates are in .build/compiled-templates (ignored by Git).
- Source templates in Git remain portable and contain no machine-specific workflow IDs.

Next: open http://localhost:5678 and perform the verification checklist before changing classification rows to BUILT.
'@ -ForegroundColor Green
