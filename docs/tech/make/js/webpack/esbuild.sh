#!/usr/bin/env bash
set -euo pipefail

npm install --save-dev esbuild
npx esbuild src/index.js --bundle --outfile=dist/index.js
npx esbuild src/index.js --bundle --minify --sourcemap --outfile=dist/index.js
