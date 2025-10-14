function shreddir() {
  find "$1" -type f -exec shred -uvz {} \; rm -rf "$1"
}

function nixrs() {
  sudo nixos-rebuild switch --flake "~/dotfiles#$(hostname)"
}

function nixpkgs-build() {
  nix-build -E "with import <nixpkgs> {}; callPackage ./$1 {}"
}

function ff() {
  kitget_output="/tmp/$(date +%s)"
  kitget --square -o "$kitget_output"
  clear
  fastfetch --kitty "$kitget_output" "$@"
  rm -f "$kitget_output"
}
