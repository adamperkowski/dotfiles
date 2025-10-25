function shreddir() {
  find "$1" -type f -exec shred -uvz {} \; rm -rf "$1"
}

function nixrs() {
  sudo nixos-rebuild switch --flake ~/dotfiles\#$(hostname)
}

function nixdev() {
  export FF_SKIP=1

  if [ $(nix flake show | grep 'devShells') ]; then
    nix develop -c zsh
  else
    nix-shell --run zsh $@
  fi
}

function nixpkgs-build() {
  nix-build -E "with import <nixpkgs> {}; callPackage ./$1 {}"
}

function nixpkgs-review-gha() {
  gh workflow run 'review.yml' -R "$(gh api user --jq '.login')/nixpkgs-review-gha" -f pr="$1"
}

function cd() {
  { z "$@" 2>/dev/null && lsd -hN; } || { echo "dir \e[91m$*\e[0m not found!! \e[91mSTUPID! BONK!\e[0m :3"; return 1; }
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

  kitget_output="/tmp/$(date +%s)"
  if [ -n "$FF_NO_KITGET" ] || ! $(kitget --square -o "$kitget_output" &> /dev/null); then
    fastfetch --logo nixos_small --logo-padding-top 3 "$@"
  else
    fastfetch --kitty "$kitget_output" "$@"
  fi

  rm -f "$kitget_output"
}
