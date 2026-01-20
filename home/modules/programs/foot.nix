{ pkgs, ... }:

let
  evergarden = pkgs.fetchurl {
    url = "https://codeberg.org/evergarden/foot/raw/commit/7a3c989a4a3b8c511206596be972dfa147878973/themes/evergarden-fall-green.ini";
    hash = "sha256-TMdNTqjIqXHNXJ/A7K1lMr79wbYTpDvyRWBlGrCcOyI=";
  };
in
{
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        include = builtins.toString evergarden;
        font = "Maple Mono NF:pixelsize=15";
        dpi-aware = "yes";
      };
      cursor = {
        style = "beam";
        blink = "yes";
      };
    };
  };
}
