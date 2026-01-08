{
  home = {
    username = "koi";
    homeDirectory = "/home/koi";
    stateVersion = "25.11";
  };

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
