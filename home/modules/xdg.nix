let
  configs = ../../external/config;
in
{
  xdg.mimeApps.enable = true;

  xdg.configFile = builtins.mapAttrs (name: _: {
    source = configs + "/${name}";
    recursive = true;
  }) (builtins.readDir configs);
}
