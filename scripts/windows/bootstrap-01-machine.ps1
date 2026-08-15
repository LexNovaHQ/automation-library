#Requires -Version 5.1
#Requires -RunAsAdministrator
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
        Write-Warning "WinGet returned exit code $LASTEXITCODE for $Id. If the app is already installed, run: winget upgrade --id $Id -e"
    }
}

Write-Step 'Checking Windows Package Manager'
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    throw 'WinGet is not available. Update/install Microsoft App Installer from the Microsoft Store, then rerun this script.'
}

Write-Step 'Checking hardware virtualization state'
try {
    $cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
    Write-Host "CPU virtualization firmware enabled: $($cpu.VirtualizationFirmwareEnabled)"
    if ($cpu.VirtualizationFirmwareEnabled -eq $false) {
        Write-Warning 'Hardware virtualization appears disabled. Enable Intel VT-x/AMD-V in BIOS/UEFI before expecting Docker Desktop/WSL2 to work.'
    }
} catch {
    Write-Warning 'Could not read virtualization firmware state; continuing.'
}

Write-Step 'Checking WSL'
$wslReady = $false
if (Get-Command wsl.exe -ErrorAction SilentlyContinue) {
    & wsl.exe --status 2>$null | Out-Host
    $wslReady = ($LASTEXITCODE -eq 0)
}

$rebootRecommended = $false
if (-not $wslReady) {
    Write-Step 'Installing WSL2 + Ubuntu'
    & wsl.exe --install -d Ubuntu --no-launch
    if ($LASTEXITCODE -ne 0) {
        throw 'WSL installation failed. Review the Windows output above, restart if Windows requests it, and rerun this script.'
    }
    $rebootRecommended = $true
} else {
    Write-Step 'Updating WSL'
    & wsl.exe --update
}

Write-Step 'Setting WSL2 as the default'
& wsl.exe --set-default-version 2

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
if ($rebootRecommended) {
    Write-Warning 'WSL was installed in this run. Restart Windows before project bootstrap.'
}

Write-Host @'
Next actions:
1. Restart Windows if WSL/Docker requests it (required when WSL was newly enabled).
2. Launch Ubuntu once and create the Linux username/password.
3. Launch Docker Desktop and confirm it uses the WSL2 engine.
4. Open a NEW PowerShell 7 window.
5. Authenticate GitHub CLI when needed: gh auth login
6. Run scripts/windows/bootstrap-02-project.ps1 after the repo is cloned, or use the project bootstrap command supplied with this sprint.
'@
