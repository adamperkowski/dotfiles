function shreddir() {
  find "$1" -type f -exec shred -uvz {} \; rm -rf "$1"
}

function nixrs() {
  sudo nixos-rebuild switch --flake ~/dotfiles\#$(hostname)
}

function nixpkgs-build() {
  nix-build -E "with import <nixpkgs> {}; callPackage ./$1 {}"
}

. "$DOTFILES/external/zsh/nix-shell-generate.zsh"

function ff() {
  if [ -n "$FF_NO_KITGET" ]; then
    fastfetch --logo nixos_small --logo-padding-top 3 "$@"
    return
  fi

  kitget_output="/tmp/$(date +%s)"
  kitget --square -o "$kitget_output" > /dev/null
  fastfetch --kitty "$kitget_output" "$@"
  rm -f "$kitget_output"
}
