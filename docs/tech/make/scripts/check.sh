#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

while IFS= read -r -d '' script; do
  bash -n "$script"
done < <(find . -path './.git' -prune -o -name '*.sh' -print0)

if command -v make >/dev/null 2>&1; then
  make -C 'c++/make/main' clean all >/dev/null
  make -C 'c++/make/main' clean >/dev/null
fi

echo "checks passed"
