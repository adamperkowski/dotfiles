function nixos-rebuild() {
  sudo nixos-rebuild --no-reexec --flake "$HOME/dotfiles#$(hostname)" --log-format internal-json -v "$@" |& nom --json
}

function nixpkgs-build() {
  nix-build -E "with import <nixpkgs> {}; callPackage ./$1 {}"
}

function nixpkgs-review-gha() {
  gh workflow run 'review.yml' -R "$(gh api user --jq '.login')/nixpkgs-review-gha" -f pr="$1"
}

function cd() {
  { z "$@" 2>/dev/null && lsd -hN; } || {
    echo "dir \e[91m$*\e[0m not found!! \e[91mSTUPID! BONK!\e[0m :3"
    return 1
  }
}

function command_not_found_handler() {
  echo "command \e[91m$1\e[0m not found!! \e[91mSTUPID! BONK!\e[0m :3"
  return 127
}
