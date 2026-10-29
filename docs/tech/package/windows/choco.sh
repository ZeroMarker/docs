#!/usr/bin/env bash
set -euo pipefail

if ! command -v choco >/dev/null 2>&1; then
  echo "Chocolatey is not installed. Install it first: https://chocolatey.org/install" >&2
  exit 1
fi

choco upgrade chocolatey -y
choco install -y elixir
