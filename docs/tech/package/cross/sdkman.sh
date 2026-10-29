#!/usr/bin/env bash
set -euo pipefail

if ! command -v sdk >/dev/null 2>&1; then
  curl -fsSL "https://get.sdkman.io" | bash
  echo "SDKMAN installed. Open a new shell or source ~/.sdkman/bin/sdkman-init.sh, then rerun this script."
  exit 0
fi

sdk selfupdate
sdk list java

