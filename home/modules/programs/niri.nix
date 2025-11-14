{ config, ... }:

{
  services.gnome-keyring.enable = false;

  home.sessionVariables = {
    XDG_BACKEND = "wayland";
    NIXOS_OZONE_WL = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  programs.niri.settings = {
    spawn-at-startup = [
      { argv = [ "swww img ~/.wallpaper.jpg" ]; }
      { argv = [ "waybar" ]; }
      { argv = [ "vesktop" ]; }
    ];

    screenshot-path = "~/screenshots/%Y-%m-%d_%H-%M-%S.png";
    prefer-no-csd = true;

    cursor = {
      theme = "catppuccin-mocha-dark-cursors";
      size = 24;
    };

    input = {
      keyboard = {
        # xkb.layout = "pl";
        repeat-delay = 180;
        repeat-rate = 60;
        numlock = true;
      };

      mouse.accel-profile = "flat";

      # TODO: laptop touchpad

      focus-follows-mouse = {
        enable = true;
        max-scroll-amount = "0%";
      };
    };

    outputs = {
      HDMI-A-1 = {
        scale = 1;
        mode = {
          width = 1920;
          height = 1080;
          refresh = 60.0;
        };

        # TODO: uncomment on next niri release
        # hot-corners.enable = false;
      };

      eDP-1 = {
        scale = 1;
        mode = {
          width = 1920;
          height = 1080;
          refresh = 60.0;
        };

        # TODO: uncomment on next niri release
        # hot-corners.enable = false;
      };
    };

    layout = {
      gaps = 8;
      center-focused-column = "never";
      background-color = "transparent";

      default-column-width.proportion = 0.5;

      focus-ring.enable = false;
      border = {
        enable = true;
        width = 2;
        active.color = "#b4befe";
        inactive.color = "#313244";
        urgent.color = "#cba6f7";
      };
    };

    animations = {
      window-open.kind.easing = {
        duration-ms = 400;
        curve = "cubic-bezier";
        curve-args = [
          0.23
          1
          0.32
          1
        ];
      };

      window-close.kind.easing = {
        duration-ms = 400;
        curve = "cubic-bezier";
        curve-args = [
          0.23
          1
          0.32
          1
        ];
      };
    };

    workspaces = {
      "1" = { };
      "2" = { };
      "3" = { };
      "social" = { };
    };

    window-rules = [
      {
        clip-to-geometry = true;
      }
      {
        matches = [ { app-id = "^Rofi"; } ];
        open-floating = true;
        open-focused = true;
      }
      {
        matches = [ { app-id = "^vesktop"; } ];
        open-on-workspace = "social";
        default-column-width.proportion = 0.56;
      }
      {
        matches = [ { app-id = "^steam"; } ];
        open-on-workspace = "3";
        default-column-width.proportion = 1.0;
      }
      {
        matches = [ { title = "^(Picture in picture|Picture-in-Picture|Discord Popout)"; } ];
        default-column-width.fixed = 800;
        default-window-height.fixed = 450;
        open-floating = true;
        default-floating-position = {
          x = 0;
          y = 0;
          relative-to = "bottom-right";
        };
      }
      {
        matches = [ { title = "^notificationtoast.*"; } ];
        open-floating = true;
        default-floating-position = {
          x = 0;
          y = 0;
          relative-to = "bottom-right";
        };
      }
    ];

    layer-rules = [
      {
        matches = [ { namespace = "^swww-daemon"; } ];
        place-within-backdrop = true;
      }
    ];

    binds = with config.lib.niri.actions; {
      "Mod+Shift+Slash".action = show-hotkey-overlay;

      "Mod+Return".action = spawn "kitty";
      "Mod+Shift+Return".action.spawn = [
        "rofi"
        "-show"
        "drun"
      ];

      "Mod+Tab".action = toggle-overview;
      "Mod+Shift+C".action = close-window;

      "Mod+Home".action = focus-column-first;
      "Mod+End".action = focus-column-last;
      "Mod+Shift+Home".action = move-column-to-first;
      "Mod+Shift+End".action = move-column-to-last;

      # TODO: make a loop for these
      "Mod+H".action = focus-column-left;
      "Mod+J".action = focus-window-down;
      "Mod+K".action = focus-window-up;
      "Mod+L".action = focus-column-right;
      "Mod+Left".action = focus-column-left;
      "Mod+Down".action = focus-window-down;
      "Mod+Up".action = focus-window-up;
      "Mod+Right".action = focus-column-right;

      "Mod+Shift+H".action = move-column-left;
      "Mod+Shift+J".action = move-window-down;
      "Mod+Shift+K".action = move-window-up;
      "Mod+Shift+L".action = move-column-right;
      "Mod+Shift+Left".action = move-column-left;
      "Mod+Shift+Down".action = move-window-down;
      "Mod+Shift+Up".action = move-window-up;
      "Mod+Shift+Right".action = move-column-right;

      "Mod+Ctrl+H".action = focus-monitor-left;
      "Mod+Ctrl+J".action = focus-monitor-down;
      "Mod+Ctrl+K".action = focus-monitor-up;
      "Mod+Ctrl+L".action = focus-monitor-right;
      "Mod+Ctrl+Left".action = focus-monitor-left;
      "Mod+Ctrl+Right".action = focus-monitor-right;
      "Mod+Ctrl+Up".action = focus-monitor-up;
      "Mod+Ctrl+Down".action = focus-monitor-down;

      "Mod+I".action = focus-workspace-up;
      "Mod+U".action = focus-workspace-down;
      "Mod+Page_Up".action = focus-workspace-up;
      "Mod+Page_Down".action = focus-workspace-down;

      "Mod+Shift+I".action = move-column-to-workspace-up;
      "Mod+Shift+U".action = move-column-to-workspace-down;
      "Mod+Shift+Page_Up".action = move-column-to-workspace-up;
      "Mod+Shift+Page_Down".action = move-column-to-workspace-down;

      # TODO: make a loop for these
      "Mod+1".action = focus-workspace 1;
      "Mod+2".action = focus-workspace 2;
      "Mod+3".action = focus-workspace 3;
      "Mod+4".action = focus-workspace "social";
      "Mod+0".action = focus-workspace "social";

      # the flake doesnt implement this (yet?)
      # "Mod+Shift+1".action = move-column-to-workspace 1;
      # "Mod+Shift+2".action = move-column-to-workspace 2;
      # "Mod+Shift+3".action = move-column-to-workspace 3;
      # "Mod+Shift+4".action = move-column-to-workspace "social";
      # "Mod+Shift+0".action = move-column-to-workspace "social";

      "Mod+BracketLeft".action = consume-or-expel-window-left;
      "Mod+BracketRight".action = consume-or-expel-window-right;

      "Mod+F".action = maximize-column;
      "Mod+Shift+F".action = fullscreen-window;
      "Mod+Ctrl+F".action = expand-column-to-available-width;
      "Mod+R".action = switch-preset-column-width;

      "Mod+Minus".action = set-column-width "-10%";
      "Mod+Equal".action = set-column-width "+10%";
      "Mod+Shift+Minus".action = set-window-height "-10%";
      "Mod+Shift+Equal".action = set-window-height "+10%";

      "Mod+Space".action = toggle-window-floating;
      "Mod+Shift+Space".action = switch-focus-between-floating-and-tiling;

      # "Print".action = screenshot;
      # "Shift+Print".action = screenshot-window;
      # this doesnt work for some reason?
      # "Ctrl+Print".action = screenshot-screen;

      "Mod+Shift+Q".action = quit;
    };
  };
}
