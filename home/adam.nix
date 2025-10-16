{ pkgs, ... }:

{
  home = {
    username = "adam";
    homeDirectory = "/home/adam";
    stateVersion = "25.05";
  };

  imports = [
    ./modules/theme.nix
    ./modules/dotfiles.nix
    ./modules/programs
  ];

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

    unstable.kitget
  ];
}
