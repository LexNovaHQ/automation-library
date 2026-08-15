[CmdletBinding()]
param(
    [string]$RepoUrl = 'https://github.com/LexNovaHQ/automation-library.git',
    [string]$Branch = 'sept-launch-full-build'
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

function Write-Step([string]$Message) {
    Write-Host "`n==> $Message" -ForegroundColor Cyan
}

function Require-Command([string]$Name) {
    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        throw "Required command '$Name' is not available in this shell. Open a new PowerShell 7 window after installing the machine prerequisites."
    }
}

Require-Command git
Require-Command gh
Require-Command docker
Require-Command code

$codeRoot = if (Test-Path 'D:\') { 'D:\Code' } else { Join-Path $HOME 'Code' }
$repoPath = Join-Path $codeRoot 'automation-library'
New-Item -ItemType Directory -Force -Path $codeRoot | Out-Null

Write-Step "Using project root $repoPath"
if (-not (Test-Path (Join-Path $repoPath '.git'))) {
    git clone $RepoUrl $repoPath
}

Set-Location $repoPath

git fetch --all --prune
git checkout $Branch
git pull --ff-only origin $Branch

Write-Step 'Creating local .env with a fresh n8n encryption key'
if (-not (Test-Path '.env')) {
    Copy-Item '.env.example' '.env'
    $secretBytes = New-Object byte[] 48
    [Security.Cryptography.RandomNumberGenerator]::Fill($secretBytes)
    $freshKey = [Convert]::ToBase64String($secretBytes)
    $envText = Get-Content '.env' -Raw
    $envText = $envText.Replace('REPLACE_WITH_FRESH_RANDOM_SECRET', $freshKey)
    Set-Content '.env' $envText -Encoding utf8
    Write-Host 'Created .env with a fresh local-only N8N_ENCRYPTION_KEY.' -ForegroundColor Green
} else {
    Write-Host '.env already exists; leaving it unchanged.' -ForegroundColor Yellow
}

Write-Step 'Installing recommended VS Code extensions'
$extensions = @(
    'ms-vscode-remote.remote-wsl',
    'ms-azuretools.vscode-docker',
    'redhat.vscode-yaml',
    'esbenp.prettier-vscode'
)
foreach ($extension in $extensions) {
    code --install-extension $extension --force | Out-Host
}

Write-Step 'Checking GitHub CLI authentication'
& gh auth status
if ($LASTEXITCODE -ne 0) {
    Write-Host 'GitHub CLI is not authenticated. Run: gh auth login' -ForegroundColor Yellow
}

Write-Step 'Checking Docker Desktop / WSL2 engine'
try {
    docker version | Out-Host
} catch {
    throw 'Docker is installed but the daemon is not reachable. Start Docker Desktop, wait until it reports Running, then rerun this script.'
}

Write-Step 'Pulling and starting n8n'
docker compose pull
docker compose up -d

Write-Step 'Waiting for local n8n health endpoint'
$ready = $false
for ($i = 0; $i -lt 30; $i++) {
    try {
        $response = Invoke-WebRequest -Uri 'http://localhost:5678' -UseBasicParsing -TimeoutSec 2
        if ($response.StatusCode -ge 200 -and $response.StatusCode -lt 500) {
            $ready = $true
            break
        }
    } catch {
        Start-Sleep -Seconds 2
    }
}

if (-not $ready) {
    docker compose logs --tail 100 n8n | Out-Host
    throw 'n8n did not become reachable at http://localhost:5678. Review the logs above.'
}

Write-Step 'Environment verification'
git --version | Out-Host
gh --version | Select-Object -First 1 | Out-Host
docker --version | Out-Host
docker compose version | Out-Host
node --version | Out-Host
npm --version | Out-Host
python --version | Out-Host
wsl -l -v | Out-Host
docker compose exec -T n8n n8n --version | Out-Host

Write-Host @'

PROJECT READY
- Repo checked out on sept-launch-full-build
- .env generated locally and ignored by Git
- n8n reachable at http://localhost:5678
- Docker/WSL/Git/VS Code toolchain checked

Manual checkpoints still required:
1. In n8n, create the owner account if this is a fresh volume.
2. Add only sandbox/test credentials first (Google, Slack, HubSpot, etc.).
3. Never paste secrets into workflow JSON, screenshots, README files, or Git commits.
4. Configure Git name/email if this laptop has not been configured yet.
'@ -ForegroundColor Green
