{ pkgs, ... }:

{
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
