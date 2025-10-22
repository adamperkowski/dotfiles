{ pkgs, ... }:

{
  home.file.".wallpaper.jpg" = {
    source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/orangci/walls-catppuccin-mocha/master/excalibur-lake.jpg";
      sha256 = "0h22bgbldxfc8is8ivp0x0zvjav508ppih1k9y0f1srmm46l03id";
    };
  };
}
