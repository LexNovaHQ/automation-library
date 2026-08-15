#Requires -Version 5.1
[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

function Write-Step([string]$Message) {
    Write-Host "`n==> $Message" -ForegroundColor Cyan
}

function Install-WingetPackage([string]$Id) {
    Write-Step "Installing/upgrading $Id"
    winget install --id $Id -e --source winget --accept-package-agreements --accept-source-agreements --silent
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "winget returned exit code $LASTEXITCODE for $Id. If the app is already installed, run: winget upgrade --id $Id -e"
    }
}

Write-Step 'Checking Windows Package Manager'
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    throw 'WinGet is not available. Update/install Microsoft App Installer from the Microsoft Store, then rerun this script.'
}

Write-Step 'Checking WSL'
$wslPresent = $false
try {
    wsl --status | Out-Host
    $wslPresent = $true
} catch {
    $wslPresent = $false
}

if (-not $wslPresent) {
    Write-Step 'Installing WSL2 + Ubuntu (a reboot may be required)'
    wsl --install -d Ubuntu --no-launch
} else {
    Write-Step 'Updating WSL'
    wsl --update
}

Write-Step 'Setting WSL2 as the default'
wsl --set-default-version 2

$packages = @(
    'Git.Git',
    'GitHub.cli',
    'Microsoft.VisualStudioCode',
    'Docker.DockerDesktop',
    'Microsoft.PowerShell',
    'OpenJS.NodeJS.LTS',
    'Python.Python.3.14',
    'Microsoft.WindowsTerminal'
)

foreach ($package in $packages) {
    Install-WingetPackage $package
}

Write-Step 'Machine bootstrap complete'
Write-Host @'
Next actions:
1. Restart Windows if WSL/Docker requests it.
2. Launch Ubuntu once and create the Linux username/password.
3. Launch Docker Desktop and confirm it uses the WSL2 engine.
4. Open a NEW PowerShell 7 window.
5. Run scripts/windows/bootstrap-02-project.ps1 from the repo (or download it separately before cloning).
'@
