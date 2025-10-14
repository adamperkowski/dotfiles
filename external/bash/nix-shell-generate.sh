# Copyright (c) 2025 Sebaguardian

function nix-shell-generate() {
  if [ -z "$filename" ]; then
    filename='shell.nix'
  fi

  if [ -e "$filename" ]; then
    echo "$filename already exists"
    return 1
  fi

  touch "$filename"
  { tee "$filename" << EOF
{ pkgs ? import <nixpkgs> {} }:

let
  pkgInputs = with pkgs; [
EOF
  } > /dev/null

  echo "    $@" >> "$filename"

  { tee -a "$filename" << EOF
  ];
in
pkgs.mkShell {
  packages = pkgInputs;

  shellHook = ''
    echo -ne "-----------------------------------\\n "

    echo -n "\${toString (map (pkg: "• \${pkg.name}\\n") pkgInputs)}"

    echo "-----------------------------------"
  '';
}
EOF
  } > /dev/null

  echo "$filename generated"
}
