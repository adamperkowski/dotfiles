function shreddir() {
  find "$1" -type f -exec shred -uvz {} \; rm -rf "$1"
}

function nixrs() {
  sudo nixos-rebuild switch --flake ~/dotfiles\#$(hostname)
}

function nixpkgs-build() {
  nix-build -E "with import <nixpkgs> {}; callPackage ./$1 {}"
}

function cd() {
  { z "$@" 2>/dev/null && ls; } || echo "dir \e[91m$*\e[0m not found!! \e[91mSTUPID! BONK!\e[0m :3"
}

function command_not_found_handler() {
  echo "command \e[91m$1\e[0m not found!! \e[91mSTUPID! BONK!\e[0m :3"
  return 127
}

. "$DOTFILES/external/zsh/nix-shell-generate.zsh"

function ff() {
  if [ -n "$FF_SKIP" ]; then
    FF_SKIP=
    return
  fi

  if [ -n "$FF_NO_KITGET" ]; then
    fastfetch --logo nixos_small --logo-padding-top 3 "$@"
    return
  fi

  kitget_output="/tmp/$(date +%s)"
  kitget --square -o "$kitget_output" > /dev/null
  fastfetch --kitty "$kitget_output" "$@"
  rm -f "$kitget_output"
}
