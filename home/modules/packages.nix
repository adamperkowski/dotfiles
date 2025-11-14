{ pkgs, ... }:

{
  home.packages = with pkgs; [
    jellyfin-tui
    prettyping
    fastfetch
    playerctl
    lsd
    jq

    nerd-fonts.fira-code
    wl-clipboard
    grim
    slurp

    unstable.kitget
  ];
}
