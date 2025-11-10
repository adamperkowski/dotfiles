{
  pkgs,
  config,
  anvim,
  ...
}:

{
  imports = [ anvim.homeManagerModules.default ];

  programs.anvim = {
    enable = true;
    defaultEditor = true;
  };

  home.packages = with pkgs; [
    bash-language-server
    nixd
  ];

  age.secrets.wakatime = {
    file = ../../../secrets/wakatime.cfg.age;
    mode = "0500";
    path = "${config.home.homeDirectory}/.wakatime.cfg";
  };
}
