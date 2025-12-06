{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nix-output-monitor
    jellyfin-mpv-shim
    jellyfin-tui
    prettyping
    playerctl
    lsd
    jq
    gh

    signal-desktop

    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.fira-code

    wl-clipboard

    kitget
  ];
}
