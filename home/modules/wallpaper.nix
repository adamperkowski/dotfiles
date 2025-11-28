{ pkgs, ... }:

{
  home.file.".wallpaper.jpg" = {
    source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/orangci/walls-catppuccin-mocha/master/oversized-cat.jpg";
      sha256 = "0c9fkhixpzh6hvwbqvfrfsi7c5p1lwnaql6ri1kkdjahay1h0spl";
    };
  };
}
