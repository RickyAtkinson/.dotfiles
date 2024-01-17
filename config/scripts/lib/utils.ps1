# Powershell utilities

function Write-HostInfo($msg)
{
    Write-Host "‣ $msg" -ForegroundColor Blue
}

function Write-HostSuccess($msg)
{
    Write-Host "✓ $msg" -ForegroundColor Green
}

function Write-HostWarning($msg)
{
    Write-Host "⚠ $msg" -ForegroundColor Yellow
}

function Write-HostError($msg)
{
    Write-Host "✖ $msg" -ForegroundColor Red
}
