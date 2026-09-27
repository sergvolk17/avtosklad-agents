$ErrorActionPreference = "Stop"

Write-Host "=== AutoSklad Hermes bootstrap (Windows) ===" -ForegroundColor Cyan

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
  Write-Host "Git is missing. Install Git for Windows first." -ForegroundColor Yellow
  Write-Host "Suggested: winget install --id Git.Git -e"
  exit 2
}

$repo = Join-Path $HOME "avtosklad-agents"
if (-not (Test-Path $repo)) {
  git clone https://github.com/sergvolk17/avtosklad-agents.git $repo
} else {
  Push-Location $repo
  git pull --ff-only
  Pop-Location
}

if (-not (Get-Command hermes -ErrorAction SilentlyContinue)) {
  Write-Host "Hermes is not installed." -ForegroundColor Yellow
  Write-Host "Run the official installer in PowerShell:"
  Write-Host '  iex (irm https://hermes-agent.nousresearch.com/install.ps1)' -ForegroundColor Green
  Write-Host "Then reopen PowerShell and run this script again."
  exit 3
}

Write-Host "Hermes found:" -ForegroundColor Green
hermes --version

$skills = Join-Path $repo "skills"
hermes config set skills.write_approval true
hermes config set memory.write_approval true
hermes config set security.allow_lazy_installs false
hermes config set --force skills.external_dirs "[`"$skills`"]"

Write-Host ""
Write-Host "Base safety settings applied." -ForegroundColor Green
Write-Host "Next: run hermes setup --portal (or hermes setup) interactively."
Write-Host "After setup: run hermes doctor."
Write-Host "Project: $repo"