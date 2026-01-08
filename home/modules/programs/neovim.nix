{
  pkgs,
  config,
  inputs,
  ...
}:

{
  imports = [ inputs.anvim.homeManagerModules.default ];

  programs.anvim = {
    enable = true;
    defaultEditor = true;
  };

  home.packages = with pkgs; [
    bash-language-server
    nixd
  ];
}
