{ pkgs, ... }:

let
  configs = ../../external/config;
in
{
  xdg = {
    mimeApps.enable = true;

    configFile = builtins.mapAttrs (name: _: {
      source = configs + "/${name}";
      recursive = true;
    }) (builtins.readDir configs);

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
}
