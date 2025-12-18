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
    ];

    screenshot-path = "~/screenshots/%Y-%m-%d_%H-%M-%S.png";
    prefer-no-csd = true;

    cursor = {
      theme = "catppuccin-mocha-dark-cursors";
      size = 24;
    };

    input = {
      keyboard = {
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

    gestures.hot-corners.enable = false;

    outputs = {
      HDMI-A-1 = {
        scale = 1;
        mode = {
          width = 1920;
          height = 1080;
          refresh = 60.0;
        };
      };

      eDP-1 = {
        scale = 1;
        mode = {
          width = 1920;
          height = 1080;
          refresh = 60.0;
        };
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

    # TODO: uncomment on next release
    # recent-windows.enable = false;

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
        open-maximized = true;
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

    binds = {
      "mod+shift+slash".action.show-hotkey-overlay = [ ];

      "mod+return".action.spawn = [ "footclient" ];
      "mod+shift+return".action.spawn = [
        "rofi"
        "-show"
        "drun"
      ];

      "mod+tab".action.toggle-overview = [ ];
      "mod+shift+c".action.close-window = [ ];

      "mod+home".action.focus-column-first = [ ];
      "mod+end".action.focus-column-last = [ ];
      "mod+shift+home".action.move-column-to-first = [ ];
      "mod+shift+end".action.move-column-to-last = [ ];

      # TODO: make a loop for these
      "mod+n".action.focus-column-left = [ ];
      "mod+e".action.focus-window-down = [ ];
      "mod+i".action.focus-window-up = [ ];
      "mod+o".action.focus-column-right = [ ];
      "mod+left".action.focus-column-left = [ ];
      "mod+down".action.focus-window-down = [ ];
      "mod+up".action.focus-window-up = [ ];
      "mod+right".action.focus-column-right = [ ];

      "mod+shift+n".action.move-column-left = [ ];
      "mod+shift+e".action.move-window-down = [ ];
      "mod+shift+i".action.move-window-up = [ ];
      "mod+shift+o".action.move-column-right = [ ];
      "mod+shift+left".action.move-column-left = [ ];
      "mod+shift+down".action.move-window-down = [ ];
      "mod+shift+up".action.move-window-up = [ ];
      "mod+shift+right".action.move-column-right = [ ];

      "mod+ctrl+n".action.focus-monitor-left = [ ];
      "mod+ctrl+e".action.focus-monitor-down = [ ];
      "mod+ctrl+i".action.focus-monitor-up = [ ];
      "mod+ctrl+o".action.focus-monitor-right = [ ];
      "mod+ctrl+left".action.focus-monitor-left = [ ];
      "mod+ctrl+right".action.focus-monitor-right = [ ];
      "mod+ctrl+up".action.focus-monitor-up = [ ];
      "mod+ctrl+down".action.focus-monitor-down = [ ];

      "mod+l".action.focus-workspace-up = [ ];
      "mod+u".action.focus-workspace-down = [ ];
      "mod+page_up".action.focus-workspace-up = [ ];
      "mod+page_down".action.focus-workspace-down = [ ];

      "mod+shift+l".action.move-column-to-workspace-up = [ ];
      "mod+shift+u".action.move-column-to-workspace-down = [ ];
      "mod+shift+page_up".action.move-column-to-workspace-up = [ ];
      "mod+shift+page_down".action.move-column-to-workspace-down = [ ];

      # TODO: make a loop for these
      "mod+1".action.focus-workspace = 1;
      "mod+2".action.focus-workspace = 2;
      "mod+3".action.focus-workspace = 3;
      "mod+4".action.focus-workspace = "social";
      "mod+0".action.focus-workspace = "social";

      "mod+shift+1".action.move-column-to-workspace = 1;
      "mod+shift+2".action.move-column-to-workspace = 2;
      "mod+shift+3".action.move-column-to-workspace = 3;
      "mod+shift+4".action.move-column-to-workspace = "social";
      "mod+shift+0".action.move-column-to-workspace = "social";

      "mod+bracketleft".action.consume-or-expel-window-left = [ ];
      "mod+bracketright".action.consume-or-expel-window-right = [ ];

      "mod+f".action.maximize-column = [ ];
      "mod+shift+f".action.fullscreen-window = [ ];
      "mod+ctrl+f".action.expand-column-to-available-width = [ ];
      "mod+r".action.switch-preset-column-width = [ ];

      "mod+minus".action.set-column-width = "-10%";
      "mod+equal".action.set-column-width = "+10%";
      "mod+shift+minus".action.set-window-height = "-10%";
      "mod+shift+equal".action.set-window-height = "+10%";

      "mod+space".action.toggle-window-floating = [ ];
      "mod+shift+space".action.switch-focus-between-floating-and-tiling = [ ];

      "print".action.screenshot = [ ];
      "shift+print".action.screenshot-window = [ ];
      "ctrl+print".action.screenshot-screen = [ ];

      "mod+shift+q".action.quit = [ ];
    };
  };
}
