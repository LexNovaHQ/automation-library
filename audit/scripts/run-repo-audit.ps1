param(
  [string]$RepoRoot = (Get-Location).Path
)

$ErrorActionPreference = "Stop"

$AuditRoot = Join-Path $RepoRoot "audit"
$ScriptsDir = Join-Path $AuditRoot "scripts"
$ReportsDir = Join-Path $AuditRoot "reports"
$ComponentsDir = Join-Path $RepoRoot "components"
$CatalogPath = Join-Path $RepoRoot "docs\component-catalog.md"

New-Item -ItemType Directory -Force $ScriptsDir | Out-Null
New-Item -ItemType Directory -Force $ReportsDir | Out-Null

$Now = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

$InventoryCsv = Join-Path $ReportsDir "component-inventory.csv"
$InventoryMd = Join-Path $ReportsDir "component-inventory.md"
$CompletenessCsv = Join-Path $ReportsDir "build-completeness.csv"
$CompletenessMd = Join-Path $ReportsDir "build-completeness.md"
$JsonValidationCsv = Join-Path $ReportsDir "json-validation.csv"
$CatalogConsistencyMd = Join-Path $ReportsDir "catalog-consistency.md"
$GitStatusTxt = Join-Path $ReportsDir "git-status.txt"
$SummaryMd = Join-Path $ReportsDir "audit-summary.md"
$DuplicateReportMd = Join-Path $ReportsDir "duplicate-component-ids.md"

function Get-ComponentIdFromFolderName {
  param([string]$FolderName)

  if ($FolderName -match "^(c\d+-[a-z0-9]+)-") {
    return $Matches[1].ToUpper()
  }

  if ($FolderName -match "^(c\d+-[a-z0-9]+)$") {
    return $Matches[1].ToUpper()
  }

  return ""
}

function Get-CategoryFromPath {
  param([string]$FullName)

  if ($FullName -match "\\components\\(cat-\d+)\\") {
    return $Matches[1]
  }

  return ""
}

function Test-JsonFile {
  param([string]$Path)

  try {
    $null = Get-Content $Path -Raw | ConvertFrom-Json
    return @{
      IsValid = $true
      Error = ""
    }
  } catch {
    return @{
      IsValid = $false
      Error = $_.Exception.Message
    }
  }
}

function Escape-Md {
  param([string]$Value)

  if ($null -eq $Value) {
    return ""
  }

  return ($Value -replace "\|", "\|") -replace "`r?`n", " "
}

if (!(Test-Path $ComponentsDir)) {
  throw "components folder not found at $ComponentsDir"
}

$CatalogText = ""
if (Test-Path $CatalogPath) {
  $CatalogText = Get-Content $CatalogPath -Raw
}

$ComponentDirs = Get-ChildItem $ComponentsDir -Directory -Recurse |
  Where-Object {
    (Test-Path (Join-Path $_.FullName "workflows")) -or
    (Test-Path (Join-Path $_.FullName "test-payloads")) -or
    (Test-Path (Join-Path $_.FullName "output-samples")) -or
    (Test-Path (Join-Path $_.FullName "README.md"))
  } |
  Where-Object {
    $_.FullName -match "\\components\\cat-\d+\\[^\\]+$"
  } |
  Sort-Object FullName

$Inventory = foreach ($Dir in $ComponentDirs) {
  $ComponentId = Get-ComponentIdFromFolderName -FolderName $Dir.Name
  $Category = Get-CategoryFromPath -FullName $Dir.FullName
  $RelativePath = Resolve-Path -Path $Dir.FullName -Relative

  $ReadmePath = Join-Path $Dir.FullName "README.md"
  $WorkflowsPath = Join-Path $Dir.FullName "workflows"
  $PayloadsPath = Join-Path $Dir.FullName "test-payloads"
  $SamplesPath = Join-Path $Dir.FullName "output-samples"

  $WorkflowJsonFiles = @()
  if (Test-Path $WorkflowsPath) {
    $WorkflowJsonFiles = @(Get-ChildItem $WorkflowsPath -Filter "*.json" -File -ErrorAction SilentlyContinue)
  }

  $PayloadFiles = @()
  if (Test-Path $PayloadsPath) {
    $PayloadFiles = @(Get-ChildItem $PayloadsPath -Filter "*.json" -File -ErrorAction SilentlyContinue)
  }

  $SampleFiles = @()
  if (Test-Path $SamplesPath) {
    $SampleFiles = @(Get-ChildItem $SamplesPath -Filter "*.json" -File -ErrorAction SilentlyContinue)
  }

  $CatalogRecordPresent = $false
  if ($CatalogText -and $ComponentId) {
    $CatalogRecordPresent = $CatalogText -match [regex]::Escape("$ComponentId Build Record")
  }

  [pscustomobject]@{
    component_id = $ComponentId
    component_name = $Dir.Name
    category = $Category
    folder_path = $RelativePath
    readme_present = Test-Path $ReadmePath
    workflow_json_count = $WorkflowJsonFiles.Count
    test_payload_count = $PayloadFiles.Count
    output_sample_count = $SampleFiles.Count
    catalog_record_present = $CatalogRecordPresent
    last_write_time = $Dir.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss")
  }
}

$Completeness = foreach ($Item in $Inventory) {
  $Issues = New-Object System.Collections.Generic.List[string]

  $WorkflowCount = [int]$Item.workflow_json_count
  $PayloadCount = [int]$Item.test_payload_count
  $SampleCount = [int]$Item.output_sample_count

  $HasBuiltFiles = ($WorkflowCount -ge 1 -or $PayloadCount -ge 1 -or $SampleCount -ge 1)
  $IsFullyBuilt = ($WorkflowCount -ge 1 -and $PayloadCount -ge 1 -and $SampleCount -ge 1)
  $IsScaffoldOnly = ($Item.readme_present -eq $true -and -not $HasBuiltFiles)

  if (-not $Item.readme_present) {
    $Issues.Add("README missing")
  }

  if ($IsScaffoldOnly) {
    $Status = "SCAFFOLD_ONLY"
    $Issues.Add("README-only scaffold; not counted as broken build")
  }
  elseif ($IsFullyBuilt) {
    $Status = "BUILT"

    if (-not $Item.catalog_record_present) {
      $Status = "CATALOG_MISMATCH"
      $Issues.Add("catalog build record missing")
    }
  }
  else {
    $Status = "BROKEN_BUILD"

    if ($WorkflowCount -lt 1) {
      $Issues.Add("workflow JSON missing")
    }

    if ($PayloadCount -lt 1) {
      $Issues.Add("test payloads missing")
    }

    if ($SampleCount -lt 1) {
      $Issues.Add("output samples missing")
    }

    if (-not $Item.catalog_record_present) {
      $Issues.Add("catalog build record missing")
    }
  }

  [pscustomobject]@{
    component_id = $Item.component_id
    component_name = $Item.component_name
    category = $Item.category
    status = $Status
    issues = ($Issues -join "; ")
    readme_present = $Item.readme_present
    workflow_json_count = $Item.workflow_json_count
    test_payload_count = $Item.test_payload_count
    output_sample_count = $Item.output_sample_count
    catalog_record_present = $Item.catalog_record_present
  }
}

$JsonFiles = @()
if (Test-Path $ComponentsDir) {
  $JsonFiles = @(Get-ChildItem $ComponentsDir -Recurse -Filter "*.json" -File)
}

$JsonValidation = foreach ($File in $JsonFiles) {
  $Result = Test-JsonFile -Path $File.FullName

  [pscustomobject]@{
    relative_path = Resolve-Path -Path $File.FullName -Relative
    valid_json = $Result.IsValid
    error = $Result.Error
    length = $File.Length
  }
}

$CatalogIds = @()
if ($CatalogText) {
  $CatalogMatches = [regex]::Matches($CatalogText, "##\s+(C\d+-[A-Z0-9]+)\s+Build Record")
  $CatalogIds = @($CatalogMatches | ForEach-Object { $_.Groups[1].Value } | Sort-Object)
}

$RepoIds = @($Inventory | Where-Object { $_.component_id } | ForEach-Object { $_.component_id } | Sort-Object)

$FoldersMissingCatalog = @($RepoIds | Where-Object { $CatalogIds -notcontains $_ })
$CatalogMissingFolders = @($CatalogIds | Where-Object { $RepoIds -notcontains $_ })
$DuplicateCatalogRecords = @(
  $CatalogIds |
    Group-Object |
    Where-Object { $_.Count -gt 1 } |
    ForEach-Object { "$($_.Name) x$($_.Count)" }
)

$DuplicateComponentGroups = @(
  $Inventory |
    Group-Object component_id |
    Where-Object { $_.Count -gt 1 }
)

$Inventory | Export-Csv -NoTypeInformation -Encoding UTF8 $InventoryCsv
$Completeness | Export-Csv -NoTypeInformation -Encoding UTF8 $CompletenessCsv
$JsonValidation | Export-Csv -NoTypeInformation -Encoding UTF8 $JsonValidationCsv

try {
  git status --short | Set-Content -Encoding UTF8 $GitStatusTxt
} catch {
  "git status failed: $($_.Exception.Message)" | Set-Content -Encoding UTF8 $GitStatusTxt
}

$InventoryLines = New-Object System.Collections.Generic.List[string]
$InventoryLines.Add("# Component Inventory")
$InventoryLines.Add("")
$InventoryLines.Add("Generated: $Now")
$InventoryLines.Add("")
$InventoryLines.Add("| Component | Category | README | Workflows | Payloads | Samples | Catalog | Path |")
$InventoryLines.Add("|---|---:|---:|---:|---:|---:|---:|---|")

foreach ($Item in $Inventory) {
  $InventoryLines.Add("| $($Item.component_id) | $($Item.category) | $($Item.readme_present) | $($Item.workflow_json_count) | $($Item.test_payload_count) | $($Item.output_sample_count) | $($Item.catalog_record_present) | $(Escape-Md $Item.folder_path) |")
}

$InventoryLines | Set-Content -Encoding UTF8 $InventoryMd

$CompletenessLines = New-Object System.Collections.Generic.List[string]
$CompletenessLines.Add("# Build Completeness")
$CompletenessLines.Add("")
$CompletenessLines.Add("Generated: $Now")
$CompletenessLines.Add("")
$CompletenessLines.Add("| Component | Status | Issues | Workflows | Payloads | Samples | Catalog |")
$CompletenessLines.Add("|---|---:|---|---:|---:|---:|---:|")

foreach ($Item in $Completeness) {
  $CompletenessLines.Add("| $($Item.component_id) | $($Item.status) | $(Escape-Md $Item.issues) | $($Item.workflow_json_count) | $($Item.test_payload_count) | $($Item.output_sample_count) | $($Item.catalog_record_present) |")
}

$CompletenessLines | Set-Content -Encoding UTF8 $CompletenessMd

$CatalogLines = New-Object System.Collections.Generic.List[string]
$CatalogLines.Add("# Catalog Consistency")
$CatalogLines.Add("")
$CatalogLines.Add("Generated: $Now")
$CatalogLines.Add("")
$CatalogLines.Add("## Folder components missing catalog record")
$CatalogLines.Add("")

if ($FoldersMissingCatalog.Count -eq 0) {
  $CatalogLines.Add("None.")
} else {
  foreach ($Id in $FoldersMissingCatalog) {
    $CatalogLines.Add("- $Id")
  }
}

$CatalogLines.Add("")
$CatalogLines.Add("## Catalog records missing folder")
$CatalogLines.Add("")

if ($CatalogMissingFolders.Count -eq 0) {
  $CatalogLines.Add("None.")
} else {
  foreach ($Id in $CatalogMissingFolders) {
    $CatalogLines.Add("- $Id")
  }
}

$CatalogLines.Add("")
$CatalogLines.Add("## Duplicate catalog records")
$CatalogLines.Add("")

if ($DuplicateCatalogRecords.Count -eq 0) {
  $CatalogLines.Add("None.")
} else {
  foreach ($Item in $DuplicateCatalogRecords) {
    $CatalogLines.Add("- $Item")
  }
}

$CatalogLines | Set-Content -Encoding UTF8 $CatalogConsistencyMd

$DuplicateLines = New-Object System.Collections.Generic.List[string]
$DuplicateLines.Add("# Duplicate Component IDs")
$DuplicateLines.Add("")
$DuplicateLines.Add("Generated: $Now")
$DuplicateLines.Add("")

if ($DuplicateComponentGroups.Count -eq 0) {
  $DuplicateLines.Add("None.")
} else {
  foreach ($Group in $DuplicateComponentGroups) {
    $DuplicateLines.Add("## $($Group.Name)")
    $DuplicateLines.Add("")
    $DuplicateLines.Add("| Folder | Workflows | Payloads | Samples | Catalog | Suggested Status |")
    $DuplicateLines.Add("|---|---:|---:|---:|---:|---|")

    foreach ($Item in ($Group.Group | Sort-Object component_name)) {
      $IsBuilt = ([int]$Item.workflow_json_count -ge 1 -and [int]$Item.test_payload_count -ge 1 -and [int]$Item.output_sample_count -ge 1)
      $Suggested = if ($IsBuilt) { "KEEP_BUILT" } else { "REMOVE_OR_DEFER_SCAFFOLD" }
      $DuplicateLines.Add("| $($Item.component_name) | $($Item.workflow_json_count) | $($Item.test_payload_count) | $($Item.output_sample_count) | $($Item.catalog_record_present) | $Suggested |")
    }

    $DuplicateLines.Add("")
  }
}

$DuplicateLines | Set-Content -Encoding UTF8 $DuplicateReportMd

$TotalComponents = $Inventory.Count
$BuiltCount = @($Completeness | Where-Object { $_.status -eq "BUILT" }).Count
$ScaffoldOnlyCount = @($Completeness | Where-Object { $_.status -eq "SCAFFOLD_ONLY" }).Count
$BrokenBuildCount = @($Completeness | Where-Object { $_.status -eq "BROKEN_BUILD" }).Count
$CatalogMismatchCount = @($Completeness | Where-Object { $_.status -eq "CATALOG_MISMATCH" }).Count
$InvalidJsonCount = @($JsonValidation | Where-Object { -not $_.valid_json }).Count
$WorkflowCount = ($Inventory | Measure-Object workflow_json_count -Sum).Sum
$PayloadCount = ($Inventory | Measure-Object test_payload_count -Sum).Sum
$SampleCount = ($Inventory | Measure-Object output_sample_count -Sum).Sum

$SummaryLines = New-Object System.Collections.Generic.List[string]
$SummaryLines.Add("# Repo Audit Summary")
$SummaryLines.Add("")
$SummaryLines.Add("Generated: $Now")
$SummaryLines.Add("")
$SummaryLines.Add("## Counts")
$SummaryLines.Add("")
$SummaryLines.Add("| Metric | Count |")
$SummaryLines.Add("|---|---:|")
$SummaryLines.Add("| Components found | $TotalComponents |")
$SummaryLines.Add("| BUILT | $BuiltCount |")
$SummaryLines.Add("| SCAFFOLD_ONLY | $ScaffoldOnlyCount |")
$SummaryLines.Add("| BROKEN_BUILD | $BrokenBuildCount |")
$SummaryLines.Add("| CATALOG_MISMATCH | $CatalogMismatchCount |")
$SummaryLines.Add("| Workflow JSON files | $WorkflowCount |")
$SummaryLines.Add("| Test payload JSON files | $PayloadCount |")
$SummaryLines.Add("| Output sample JSON files | $SampleCount |")
$SummaryLines.Add("| Invalid JSON files | $InvalidJsonCount |")
$SummaryLines.Add("| Folder components missing catalog record | $($FoldersMissingCatalog.Count) |")
$SummaryLines.Add("| Catalog records missing folder | $($CatalogMissingFolders.Count) |")
$SummaryLines.Add("| Duplicate catalog records | $($DuplicateCatalogRecords.Count) |")
$SummaryLines.Add("| Duplicate component IDs | $($DuplicateComponentGroups.Count) |")
$SummaryLines.Add("")
$SummaryLines.Add("## Problem Components")
$SummaryLines.Add("")

$ProblemComponents = @($Completeness | Where-Object { $_.status -in @("BROKEN_BUILD", "CATALOG_MISMATCH") })

if ($ProblemComponents.Count -eq 0) {
  $SummaryLines.Add("None.")
} else {
  $SummaryLines.Add("| Component | Status | Issues |")
  $SummaryLines.Add("|---|---:|---|")

  foreach ($Item in $ProblemComponents) {
    $SummaryLines.Add("| $($Item.component_id) | $($Item.status) | $(Escape-Md $Item.issues) |")
  }
}

$SummaryLines.Add("")
$SummaryLines.Add("## Invalid JSON Files")
$SummaryLines.Add("")

$InvalidJsonFiles = @($JsonValidation | Where-Object { -not $_.valid_json })

if ($InvalidJsonFiles.Count -eq 0) {
  $SummaryLines.Add("None.")
} else {
  $SummaryLines.Add("| File | Error |")
  $SummaryLines.Add("|---|---|")

  foreach ($Item in $InvalidJsonFiles) {
    $SummaryLines.Add("| $(Escape-Md $Item.relative_path) | $(Escape-Md $Item.error) |")
  }
}

$SummaryLines.Add("")
$SummaryLines.Add("## Report Files")
$SummaryLines.Add("")
$SummaryLines.Add("- audit/reports/component-inventory.csv")
$SummaryLines.Add("- audit/reports/component-inventory.md")
$SummaryLines.Add("- audit/reports/build-completeness.csv")
$SummaryLines.Add("- audit/reports/build-completeness.md")
$SummaryLines.Add("- audit/reports/json-validation.csv")
$SummaryLines.Add("- audit/reports/catalog-consistency.md")
$SummaryLines.Add("- audit/reports/duplicate-component-ids.md")
$SummaryLines.Add("- audit/reports/classification-summary.md")
$SummaryLines.Add("- audit/reports/classification-consistency.md")
$SummaryLines.Add("- audit/reports/git-status.txt")

$SummaryLines | Set-Content -Encoding UTF8 $SummaryMd


# Generate classification summary if classification config exists
$ClassificationScript = Join-Path $ScriptsDir "generate-classification-summary.ps1"
$ClassificationCsv = Join-Path $AuditRoot "config\component-classification.csv"

if ((Test-Path $ClassificationScript) -and (Test-Path $ClassificationCsv)) {
  & $ClassificationScript | Out-Null
}

# Generate classification consistency report if checker exists
$ClassificationConsistencyScript = Join-Path $ScriptsDir "check-classification-consistency.ps1"

if (Test-Path $ClassificationConsistencyScript) {
  & $ClassificationConsistencyScript | Out-Null
}
Write-Host "Audit complete."
Write-Host "Summary: $SummaryMd"
Write-Host "Inventory: $InventoryCsv"
Write-Host "Completeness: $CompletenessCsv"
Write-Host "JSON validation: $JsonValidationCsv"







