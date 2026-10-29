#!/usr/bin/env bash
set -euo pipefail

mise use -g java

mise use -g gradle

# start.spring.io

./gradlew bootRun

