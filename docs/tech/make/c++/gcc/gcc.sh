#!/usr/bin/env bash
set -euo pipefail

# Compile a single C file.
gcc -Wall -Wextra -std=c99 main.c -o main

# Compile and run.
./main

# Generate assembly for inspection.
# gcc -S main.c -o main.s
