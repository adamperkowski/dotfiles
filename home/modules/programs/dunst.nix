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

        background = "#232a2e";
        foreground = "#f8f9e8";
        frame_color = "#cbe3b3";
        separator_color = "frame";
        highlight = "#f5d098";
      };

      urgency_low = {
        background = "#232a2e";
        foreground = "#f8f9e8";
      };

      urgency_normal = {
        background = "#232a2e";
        foreground = "#f8f9e8";
      };

      urgency_critical = {
        background = "#232a2e";
        foreground = "#f8f9e8";
        frame_color = "#f57f82";
      };
    };
  };
}
