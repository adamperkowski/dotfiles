{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nix-output-monitor
    jellyfin-desktop
    jellyfin-tui
    prettyping
    playerctl
    lsd
    jq
    gh
    codeberg-cli

    signal-desktop

    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    maple-mono.NF

    wl-clipboard

    kitget
  ];
}
