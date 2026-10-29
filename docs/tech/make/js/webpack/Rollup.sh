#!/usr/bin/env bash
set -euo pipefail

npm install --save-dev rollup
npx rollup src/index.js --file dist/bundle.js --format esm
