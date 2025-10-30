let
  scripts = ../../external/scripts;
in
{
  home.file = builtins.listToAttrs (
    map (name: {
      name = ".local/bin/${builtins.replaceStrings [ ".sh" ] [ "" ] name}";
      value = {
        source = scripts + "/${name}";
        executable = true;
      };
    }) (builtins.attrNames (builtins.readDir scripts))
  );
}
