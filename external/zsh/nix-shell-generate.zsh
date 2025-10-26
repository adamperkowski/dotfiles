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
{
  pkgs ? import <nixpkgs> { },
}:

let
  mainPkg = if builtins.pathExists ./default.nix then pkgs.callPackage ./default.nix { } else { };
EOF
  } > /dev/null

  if [ "$#" -eq 0 ]; then
    echo -n '  pkgInputs = [ ] ' >> "$filename"
  else
    echo -e "  pkgInputs =\n    with pkgs;\n    [" >> "$filename"
    printf "      %s\n" "$@" >> "$filename"
    echo -ne "    ]\n    " >> "$filename"
  fi

  { tee -a "$filename" << EOF
++ (mainPkg.nativeBuildInputs or [ ]);
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
