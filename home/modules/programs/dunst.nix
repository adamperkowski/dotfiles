{
  inputs,
  config,
  pkgs,
  ...
}:
let
  colors = inputs.evergarden.lib.util.mkPalette config.evergarden;
in
{
  home.packages = with pkgs; [ libnotify ];
  services.dunst = {
    enable = true;
    settings = {
      global = {
        alignment = "right";
        origin = "top-right";
        width = "(78, 400)";
        offset = "(0,0)";
        font = "Maple Mono NF 10";

        background = "#${colors.base}";
        foreground = "#${colors.text}";
        frame_color = "#${colors.accent}";
        separator_color = "frame";
        highlight = "#${colors.yellow}";
      };

      urgency_low = {
        background = "#${colors.base}";
        foreground = "#${colors.text}";
      };

      urgency_normal = {
        background = "#${colors.base}";
        foreground = "#${colors.text}";
      };

      urgency_critical = {
        background = "#${colors.base}";
        foreground = "#${colors.text}";
        frame_color = "#${colors.red}";
      };
    };
  };
}
