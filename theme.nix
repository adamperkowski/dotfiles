{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    catppuccin-papirus-folders
    magnetic-catppuccin-gtk
    catppuccin-cursors.mochaDark
  ];

  gtk = {
    enable = true;
    theme.name = "Catppuccin-GTK-Dark";
    iconTheme.name = "Papirus-Dark";
    cursorTheme = {
      name = "catppuccin-mocha-dark-cursors";
      size = 24;
    };
  };

  xdg.configFile."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=Catppuccin-GTK-Dark
    gtk-icon-theme-name=Papirus-Dark
    gtk-cursor-theme-name=catppuccin-mocha-dark-cursors
    gtk-cursor-theme-size=24
  '';

  xdg.configFile."gtk-4.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=Catppuccin-GTK-Dark
    gtk-icon-theme-name=Papirus-Dark
    gtk-cursor-theme-name=catppuccin-mocha-dark-cursors
    gtk-cursor-theme-size=24
  '';
}
