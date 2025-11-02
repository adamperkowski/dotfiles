#! /usr/bin/env bash

set -eo pipefail

if [[ -n $FF_SKIP ]]; then
  FF_SKIP=
  exit 0
fi

kitget_output="/tmp/$(date +%s)"

if [[ -n $FF_NO_KITGET ]] || [[ ! $(kitget --square -o "$kitget_output") ]]; then
  fastfetch --logo nixos_small --logo-padding-top 3 "$@"
else
  fastfetch --kitty "$kitget_output" "$@"
  rm -f "$kitget_output"
fi
