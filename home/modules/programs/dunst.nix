{ pkgs, ... }:

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

        frame_color = "#b4befe";
        separator_color = "frame";
        highlight = "#cba6f7";
      };

      urgency_low = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
      };

      urgency_normal = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
      };

      urgency_critical = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#eba0ac";
      };
    };
  };
}
