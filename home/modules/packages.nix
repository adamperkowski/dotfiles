{ pkgs, ... }:

{
  # TODO: update all to 25.11 stable
  home.packages = with pkgs; [
    unstable.jellyfin-tui
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
