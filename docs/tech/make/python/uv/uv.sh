#!/usr/bin/env bash
set -euo pipefail

# Install uv:
# curl -LsSf https://astral.sh/uv/install.sh | sh

uv init
uv add requests
uv run python main.py
