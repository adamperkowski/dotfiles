{
  home = {
    username = "adam";
    homeDirectory = "/home/adam";
    stateVersion = "25.05";
  };

  imports = [
    ./modules/age.nix
    ./modules/xdg.nix
    ./modules/theme.nix
    ./modules/packages.nix
    ./modules/wallpaper.nix
    ./modules/programs
  ];
}
