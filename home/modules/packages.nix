{ pkgs, ... }:

{
  home.packages = with pkgs; [
    jellyfin-tui
    prettyping
    fastfetch
    playerctl
    lsd
    jq

    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.fira-code

    wl-clipboard

    unstable.kitget
  ];
}
