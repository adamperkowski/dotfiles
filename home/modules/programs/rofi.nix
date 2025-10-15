let
  catppuccinMocha = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/rofi/71fb15577ccb091df2f4fc1f65710edbc61b5a53/themes/catppuccin-mocha.rasi";
    sha256 = "0ikn0yc2b9cyzk4xga8mcq1j7xk2idik4wzpsibrphy8qr2pla4b";
  };
  catppuccinConfig = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/rofi/71fb15577ccb091df2f4fc1f65710edbc61b5a53/catppuccin-default.rasi";
    sha256 = "1f3r6yarrykj8cxvi5hblzlr5n8zbncifnxps9xl5gl32w6ysq5z";
  };
in
{
  programs.rofi = {
    enable = true;
    font = "FiraCode Nerd Font 14";

    # cool hack lmao
    theme = ''
      ${catppuccinMocha}"
      @import "${catppuccinConfig}'';
  };
}
