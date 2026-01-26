{ inputs, pkgs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.evergarden.nixosModules.default
    inputs.niri.nixosModules.niri
    ../home.nix

    ./console.nix
    ./nixpkgs.nix
    ./environment.nix
    ./programs
    ./services
  ];

  users.users.koi.shell = pkgs.zsh;

  evergarden = {
    enable = false;
    variant = "fall";
    accent = "green";
  };
}
