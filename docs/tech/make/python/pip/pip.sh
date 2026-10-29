#!/usr/bin/env bash
set -euo pipefail

# Create and activate a local virtual environment.
python -m venv .venv
source .venv/bin/activate

# Upgrade packaging tools.
python -m pip install --upgrade pip setuptools wheel

# Install project dependencies when requirements.txt exists.
if [ -f requirements.txt ]; then
  python -m pip install -r requirements.txt
fi
