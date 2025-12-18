{ pkgs, ... }:

{
  home.file.".wallpaper.jpg" = {
    source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/orangci/walls-catppuccin-mocha/7bfdf10d16ad3a689f9f0cf3a0930da3d1a245a8/oversized-cat.jpg";
      hash = "sha256-9GoAg1dQyTZniNlQrCyn4RZ2onbZbbz4hgb+2yOcLjE=";
    };
  };
}
