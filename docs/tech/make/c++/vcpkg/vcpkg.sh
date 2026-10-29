#!/usr/bin/env bash
set -euo pipefail

git clone https://github.com/Microsoft/vcpkg.git

./vcpkg/bootstrap-vcpkg.sh

vcpkg install

vcpkg integrate install

# Windows:
# .\vcpkg\bootstrap-vcpkg.bat

# CMake example:
# cmake -B build -S . -DCMAKE_TOOLCHAIN_FILE="$PWD/vcpkg/scripts/buildsystems/vcpkg.cmake"
