{ pkgs, anvim, ... }:

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
}
