#!/usr/bin/env bash
set -euo pipefail

npm run build
npm install

# Deploy static build output after confirming the target directory.
# cp -r build/* /var/www/html

# update package.json
npm i -g npm-check-updates
ncu -u
npm install
