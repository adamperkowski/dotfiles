{ pkgs, ... }:

{
  home.username = "adam";
  home.homeDirectory = "/home/adam";
  home.stateVersion = "25.05";

  imports = [
    ./modules/theme.nix
    ./modules/dotfiles.nix
    ./modules/programs
  ];

  home.packages = with pkgs; [
    nerd-fonts.fira-code
    prettyping
    fastfetch
    jq
    # kitget
    lsd
    hyprpaper
    hyprcursor
    wl-clipboard
    playerctl
    grim
    slurp
  ];
}
