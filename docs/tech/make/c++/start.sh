#!/usr/bin/env bash
set -euo pipefail

mise use -g cmake

mise use -g python

mise use -g uv

uv tool install cmake-init

cmake-init mole
