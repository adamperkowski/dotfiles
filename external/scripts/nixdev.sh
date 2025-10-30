#! /usr/bin/env bash

set -euo pipefail

export FF_SKIP=1

if [[ "$(nix flake show)" == *'devShells' ]]; then
  nix develop -c zsh
else
  nix-shell --run zsh "$@"
fi
