#!/usr/bin/env bash
set -euo pipefail

brew install clib

clib search torrent

clib install bpkg/bpkg
