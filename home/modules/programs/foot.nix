{ pkgs, ... }:

let
  catppuccin = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/foot/8d263e0e6b58a6b9ea507f71e4dbf6870aaf8507/themes/catppuccin-mocha.ini";
    hash = "sha256-rVWISDKhJfH1mbEkFEQ6JSq3fFmZk86EJgKS694LbOs=";
  };
in
{
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        include = builtins.toString catppuccin;
        font = "Maple Mono NF:pixelsize=16";
        dpi-aware = "yes";
      };
      cursor = {
        style = "beam";
        blink = "yes";
      };
      colors.cursor = "11111b b4befe";
    };
  };
}
