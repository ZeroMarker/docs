#!/usr/bin/env bash
set -euo pipefail

if ! command -v mise >/dev/null 2>&1; then
  echo "mise is not installed. Run cross/mise/mise.sh first." >&2
  exit 1
fi

tools=(
  dart
  java
  gradle
  maven
  kotlin
  scala
  julia
  flutter
)

for tool in "${tools[@]}"; do
  mise use -g "$tool"
done

mise ls

