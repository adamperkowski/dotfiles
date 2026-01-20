{ pkgs, ... }:

{
  xdg = {
    mimeApps.enable = true;

    userDirs = {
      enable = true;
      download = "/tmp/downloads";
      desktop = "/tmp/garbage";
      documents = "/tmp/garbage";
      music = "/tmp/garbage";
      pictures = "/tmp/garbage";
      publicShare = "/tmp/garbage";
      templates = "/tmp/garbage";
      videos = "/tmp/garbage";
    };

    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
      ];

      config.common = {
        default = [
          "gtk"
          "gnome"
        ];

        "org.freedesktop.impl.portal.Access" = [ "gtk" ];
        "org.freedesktop.impl.portal.Notification" = [ "gtk" ];
      };
    };
  };

  home.sessionVariables = {
    #XDG_DATA_HOME = "~/.local/share";
    #XDG_CONFIG_HOME = "~/.config";
    #XDG_STATE_HOME = "~/.local/state";
    #XDG_CACHE_HOME = "~/.cache";
  };
}
