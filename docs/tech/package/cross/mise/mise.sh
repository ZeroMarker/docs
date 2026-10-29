#!/usr/bin/env bash
set -euo pipefail

if ! command -v mise >/dev/null 2>&1; then
  curl -fsSL https://mise.run | sh
fi

if [ -n "${BASH_VERSION:-}" ] && [ -f "$HOME/.bashrc" ]; then
  activate_line='eval "$(mise activate bash)"'
  if ! grep -Fqx "$activate_line" "$HOME/.bashrc"; then
    printf '\n%s\n' "$activate_line" >>"$HOME/.bashrc"
  fi
fi

mise install java@21
mise use -g java@21
mise ls java
mise ls-remote java | grep -i temurin || true

cat <<'EOF'

Windows installation:

  winget install --id jdx.mise --source winget

PowerShell activation:

  Add-Content -Path $PROFILE -Value '(&mise activate pwsh) | Out-String | Invoke-Expression'
EOF

