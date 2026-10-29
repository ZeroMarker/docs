#!/usr/bin/env bash
set -euo pipefail

if ! command -v winget >/dev/null 2>&1; then
  echo "winget is not available. Run this script on Windows with App Installer enabled." >&2
  exit 1
fi

winget install --id Microsoft.PowerShell --source winget

cat <<'EOF'

Useful winget commands:

  winget search everything
  winget install Notepad++.Notepad++ --location d:/notepad++
  winget install Notepad++.Notepad++ --interactive
  winget uninstall Notepad++.Notepad++
  winget list
  winget show "Docker.DockerDesktop"
  winget source remove winget
  winget source add winget https://mirrors.ustc.edu.cn/winget-source
EOF
