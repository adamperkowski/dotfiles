{ config, ... }:

let
  dotfiles = "${config.home.homeDirectory}/dotfiles/external/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    hypr = "hypr";
    nvim = "nvim";
    fastfetch = "fastfetch";
    lsd = "lsd";
  };
in
{
  xdg.mimeApps.enable = true;
  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;
}
