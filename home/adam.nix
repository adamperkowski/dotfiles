{
  home = {
    username = "adam";
    homeDirectory = "/home/adam";
    stateVersion = "25.05";
  };

  imports = [
    ./modules/scripts.nix
    ./modules/xdg.nix
    ./modules/age.nix
    ./modules/theme.nix
    ./modules/packages.nix
    ./modules/wallpaper.nix
    ./modules/programs
  ];
}
