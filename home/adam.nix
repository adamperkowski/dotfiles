{ pkgs, config, ... }:

{
  home = {
    username = "adam";
    homeDirectory = "/home/adam";
    stateVersion = "25.05";
  };

  imports = [
    ./modules/age.nix
    ./modules/theme.nix
    ./modules/dotfiles.nix
    ./modules/programs
  ];

  age = {
    identityPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
    secrets = {
      chromium = {
        file = ../secrets/chromium.sh.age;
        mode = "0500";
        path = "${config.home.homeDirectory}/.local/bin/chromium";
      };
    };
  };

  home.packages = with pkgs; [
    prettyping
    fastfetch
    playerctl
    lsd
    jq

    nerd-fonts.fira-code
    wl-clipboard
    hyprpaper
    hyprcursor
    grim
    slurp

    nixd
    bash-language-server

    unstable.kitget
  ];
}
