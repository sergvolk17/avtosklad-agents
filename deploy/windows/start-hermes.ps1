$ErrorActionPreference = "Stop"

Write-Host "=== AutoSklad Hermes start ===" -ForegroundColor Cyan

if (-not (Get-Command hermes -ErrorAction SilentlyContinue)) {
  throw "Hermes is not installed or PowerShell was not reopened after installation."
}

hermes doctor
Write-Host ""
Write-Host "Starting Hermes interactive console..." -ForegroundColor Green
hermes