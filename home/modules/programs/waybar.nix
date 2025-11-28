{ pkgs, ... }:

let
  catppuccin = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/waybar/refs/tags/v1.1/themes/mocha.css";
    sha256 = "puMFl8zIKOiYhE6wzqnffXOHn/VnKmpVDzrMJMk+3Rc=";
  };
in
{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        width = 1920;

        modules-left = [
          "hyprland/workspaces"
          "niri/workspaces"
        ];
        modules-center = [ "custom/music" ];
        modules-right = [
          "tray"
          "battery"
          "clock"
        ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          sort-by-name = true;
          format = " {icon} ";
          format-icons = {
            "default" = "";
            "9" = "󰓇";
            "10" = "";
          };
        };

        "niri/workspaces" = {
          disable-scroll = true;
          sort-by-name = true;
          persistent-only = true;
          persistent-workspaces = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
            "4" = [ ];
          };
          format = "{icon}";
          format-icons = {
            "default" = "  ";
            "social" = "  ";
            "5" = "";
          };
        };

        "custom/music" = {
          escape = true;
          interval = 10;
          tooltop = false;
          exec = "playerctl metadata --format '{{ artist }}   {{ title }}'";
          on-click = "playerctl play-pause";
          max-length = 100;
        };

        tray = {
          icon-size = 18;
          spacing = 10;
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}";
          format-charging = "󰂄";
          format-plugged = "󱟢";
          format-alt = "{icon}";
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
        };

        clock = {
          timezone = "Europe/Warsaw";
          format = "{:%H:%M}";
          tooltip-format = "<big>{:%B %d}</big>\n<tt><small>{calendar}</small></tt>";
        };
      };
    };

    style = ''
      @import "${catppuccin}";

      * {
        font-family: 'Fira Code Nerd Font', monospace;
        font-size: 14px;
        border: none;
        border-radius: 0;
        min-height: 0;
      }

      #waybar {
        background: transparent;
        color: @lavender;
      }

      #workspaces {
        background-color: @base;
        border: 2px solid @lavender;
      }

      #workspaces button {
        padding: 5px;
        margin: 0;
        color: @lavender;
      }

      #workspaces button#niri-workspace-5 {
        font-size: 0px;
        border: none;
        padding: 0px;
        margin: 0px;
        min-width: 0px;
        min-height: 0px;
      }

      #workspaces button.active {
        color: @mauve;
      }

      #custom-music,
      #tray,
      #clock,
      #battery {
        border: 2px solid @lavender;
        background-color: @base;
        padding: 0 5px;
      }

      #tray {
        border-right: none;
      }

      #clock {
        border-left: none;
      }

      #battery {
        border-left: none;
        border-right: none;
        color: @teal;
      }

      #battery.charging {
        color: @teal;
      }

      #battery.warning:not(.charging) {
        color: @red;
      }

      #custom-music {
        color: @mauve;
      }
    '';
  };
}
