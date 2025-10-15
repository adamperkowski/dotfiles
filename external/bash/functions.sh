function shreddir() {
  find "$1" -type f -exec shred -uvz {} \; rm -rf "$1"
}

function nixrs() {
  sudo nixos-rebuild switch --flake ~/dotfiles\#$(hostname)
}

function nixpkgs-build() {
  nix-build -E "with import <nixpkgs> {}; callPackage ./$1 {}"
}

. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/nix-shell-generate.sh"

function ff() {
  kitget_output="/tmp/$(date +%s)"
  kitget --square -o "$kitget_output"
  fastfetch --kitty "$kitget_output" "$@"
  rm -f "$kitget_output"
}
