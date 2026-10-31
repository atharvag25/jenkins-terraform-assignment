
$ErrorActionPreference = "Stop"

$AppUrl = "http://127.0.0.1:5001/health"
$Python = Join-Path $PSScriptRoot ".venv\Scripts\python.exe"

Write-Host "Checking existing deployment..."

try {
    $response = Invoke-RestMethod -Uri $AppUrl -TimeoutSec 3
    if ($response.status -eq "healthy") {
        Write-Host "Application is already running and healthy."
        exit 0
    }
}
catch {
    Write-Host "No healthy deployment found. Starting Flask..."
}

if (-not (Test-Path $Python)) {
    throw "Python virtual environment not found: $Python"
}

$Process = Start-Process `
    -FilePath $Python `
    -ArgumentList @(
        "-c",
        "from app import app; app.run(host='127.0.0.1', port=5001)"
    ) `
    -WorkingDirectory $PSScriptRoot `
    -PassThru `
    -RedirectStandardOutput (Join-Path $PSScriptRoot "deploy.log") `
    -RedirectStandardError (Join-Path $PSScriptRoot "deploy-error.log")

Write-Host "Started Flask process. PID: $($Process.Id)"

for ($i = 1; $i -le 15; $i++) {
    Start-Sleep -Seconds 2

    try {
        $response = Invoke-RestMethod -Uri $AppUrl -TimeoutSec 3

        if ($response.status -eq "healthy") {
            Write-Host "Deployment successful!"
            Write-Host "Application URL: http://127.0.0.1:5001"
            Write-Host "Health endpoint: $AppUrl"
            exit 0
        }
    }
    catch {
        Write-Host "Waiting for application startup..."
    }
}

throw "Deployment failed. Check deploy.log and deploy-error.log."
