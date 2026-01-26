{ pkgs, ... }:
{
  evergarden.adwaita.enable = true;

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  home.pointerCursor = {
    enable = true;
    name = "Qogir";
    package = pkgs.qogir-icon-theme;
    size = 24;
    gtk.enable = true;
    x11.enable = false;
  };
}
