#!/usr/bin/env bash
set -euo pipefail

npm install --save-dev webpack webpack-cli
npx webpack --mode development
npx webpack --mode production
