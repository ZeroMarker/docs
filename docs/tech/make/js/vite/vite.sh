#!/usr/bin/env bash
set -euo pipefail

npm create vite@latest
npm install
npm run dev
npm run build
