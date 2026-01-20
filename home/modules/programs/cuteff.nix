{ inputs, ... }:

{
  imports = [ inputs.cuteff.homeManagerModules.default ];
  programs.cuteff = {
    enable = true;
    settings = {
      padding = 2;
      paddingTop = 1;
      paddingBottom = 1;

      colors = {
        "1" = "203;227;179";
        "2" = "245;208;152";
      };

      headerCats = true;

      modules = [
        {
          name = "  user";
          stat = "username";
        }
        {
          name = "  host";
          stat = "hostname";
        }
        {
          name = "  uptime";
          stat = "uptime";
        }
        {
          name = "  distro";
          stat = "distro";
        }
        {
          name = "  kernel";
          stat = "kernel";
        }
      ];
    };
  };
}
