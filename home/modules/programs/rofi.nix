{ pkgs, ... }:

let
  evergarden = ../../../external/rofi-evergarden.rasi;
  catppuccinConfig = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/rofi/71fb15577ccb091df2f4fc1f65710edbc61b5a53/catppuccin-default.rasi";
    hash = "sha256-v2DtDReDvkJ70rdbF5ldH9mS6acLlrg7Q3L6nJU3ebg=";
  };
in
{
  programs.rofi = {
    enable = true;
    font = "Maple Mono NF 14";

    # cool hack lmao
    theme = ''
      ${evergarden}"
      @import "${catppuccinConfig}'';
  };
}
