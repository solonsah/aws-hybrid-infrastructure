$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$repositoryRoot = Split-Path -Parent $PSScriptRoot
$terraformDirectory = Join-Path $repositoryRoot "terraform"

if (-not (Get-Command terraform -ErrorAction SilentlyContinue)) {
    Write-Error "Terraform is not installed or is not available in PATH."
}

Write-Host "Checking Terraform formatting..."
& terraform "-chdir=$terraformDirectory" fmt -check -recursive

if ($LASTEXITCODE -ne 0) {
    throw "Terraform formatting validation failed."
}

Write-Host "Initializing Terraform without a backend..."
& terraform "-chdir=$terraformDirectory" init -backend=false -input=false

if ($LASTEXITCODE -ne 0) {
    throw "Terraform initialization failed."
}

Write-Host "Validating Terraform configuration..."
& terraform "-chdir=$terraformDirectory" validate

if ($LASTEXITCODE -ne 0) {
    throw "Terraform validation failed."
}

Write-Host "Terraform validation completed successfully."
