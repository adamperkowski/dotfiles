{ config, ... }:

{
  home = {
    username = "adam";
    homeDirectory = "/home/adam";
    stateVersion = "25.05";
  };

  age.identityPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];

  imports = [
    ./modules/external.nix
    ./modules/xdg.nix
    ./modules/age.nix
    ./modules/theme.nix
    ./modules/packages.nix
    ./modules/wallpaper.nix
    ./modules/programs
  ];
}
