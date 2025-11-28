{ pkgs, ... }:

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
}
