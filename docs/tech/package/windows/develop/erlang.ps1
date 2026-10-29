$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

winget install --id erlang.erlangotp --source winget --accept-package-agreements --accept-source-agreements
winget install --id gleam.gleam --source winget --accept-package-agreements --accept-source-agreements

if (Get-Command choco -ErrorAction SilentlyContinue) {
    choco install elixir -y
} else {
    Write-Warning 'Chocolatey is not installed. Install Elixir manually or install Chocolatey first: https://chocolatey.org/install'
}
