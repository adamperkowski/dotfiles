{ inputs, config, ... }:
let
  colors = inputs.evergarden.lib.util.mkPalette config.evergarden;
in
{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;

    colors = {
      bg = "#${colors.base}";
      "bg+" = "#${colors.surface0}";
      selected-bg = "#${colors.surface1}";
      fg = "#${colors.text}";
      "fg+" = "#${colors.text}";
      label = "#${colors.text}";
      hl = "#${colors.yellow}";
      "hl+" = "#${colors.yellow}";
      header = "#${colors.red}";
      info = "#${colors.green}";
      prompt = "#${colors.green}";
      border = "#${colors.surface0}";
      marker = "#${colors.subtext0}";
      pointer = "#${colors.subtext0}";
      spinner = "#${colors.subtext0}";
    };

    defaultOptions = [
      "--height=30%"
      "--info=inline"
      "--layout=reverse"
    ];
  };
}
