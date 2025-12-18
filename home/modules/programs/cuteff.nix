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
        "1" = "180;190;254";
        "2" = "203;166;247";
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
