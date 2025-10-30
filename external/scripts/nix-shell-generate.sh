#! /usr/bin/env bash

# Copyright (c) 2025 Sebaguardian

set -euo pipefail

nix-shell-generate() {
  local filename=${filename:-shell.nix}

  if [[ -e "$filename" ]]; then
    echo "$filename already exists"
    return 1
  fi

  cat > "$filename" << 'EOF'
{
  pkgs ? import <nixpkgs> { },
}:

let
  mainPkg = if builtins.pathExists ./default.nix then pkgs.callPackage ./default.nix { } else { };
EOF

  if [[ $# -eq 0 ]]; then
    echo -n '  pkgInputs = [ ] ' >> "$filename"
  else
    {
      echo "  pkgInputs ="
      echo "    with pkgs;"
      echo "    ["
      for pkg in "$@"; do
        echo "      $pkg"
      done
      echo "    ]"
      echo -n "    ";
    } >> "$filename"
  fi

  cat >> "$filename" << 'EOF'
++ (mainPkg.nativeBuildInputs or [ ]);
in
pkgs.mkShell {
  packages = pkgInputs;

  shellHook = ''
    echo -ne "-----------------------------------\n "

    echo -n "${toString (map (pkg: "• ${pkg.name}\n") pkgInputs)}"

    echo "-----------------------------------"
  '';
}
EOF

  echo "$filename generated"
}

nix-shell-generate "$@"
