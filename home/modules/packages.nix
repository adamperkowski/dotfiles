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
    grim
    slurp

    unstable.kitget
  ];
}
