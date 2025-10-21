{ pkgs, spicetify-nix, ... }:

let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
  imports = [
    spicetify-nix.homeManagerModules.spicetify
  ];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
    wayland = true;
    enabledExtensions = with spicePkgs.extensions; [
      catJamSynced
      seekSong
      fullAlbumDate
      songStats
      adblock
      playNext
    ];
  };
}
