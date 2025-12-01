{ inputs, pkgs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.niri.nixosModules.niri
    ../home.nix

    ./console.nix
    ./nixpkgs.nix
    ./environment.nix
    ./programs
    ./services
  ];

  users.users.adam.shell = pkgs.zsh;
}
