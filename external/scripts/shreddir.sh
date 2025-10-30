#! /usr/bin/env bash

set -euo pipefail

find "$1" -type f -exec shred -uvz {} \;
rm -rf "$1"
