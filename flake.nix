{
  description = "my nixos dotfiles :3";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-25.11/nixexprs.tar.xz";
    # nixpkgs-unstable.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";
    systems.url = "github:nix-systems/default";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anvim = {
      url = "https://codeberg.org/adamperkowski/anvim/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cuteff = {
      url = "https://codeberg.org/adamperkowski/cuteff/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      # inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };

    iamb = {
      url = "github:ulyssa/iamb/v0.0.11-alpha.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      inherit (nixpkgs) lib;
      system = "x86_64-linux";

      mkHost =
        name: extraModules:
        lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./modules/base
            ./systems/${name}
          ]
          ++ extraModules;
        };

      mkDesktopHost = name: mkHost name [ ./modules/desktop ];
    in
    {
      nixosConfigurations = {
        miku = mkDesktopHost "miku";
        hatsune = mkDesktopHost "hatsune";
        seber = mkHost "seber" [ ];
      };

      formatter.${system} = nixpkgs.legacyPackages.${system}.callPackage ./formatter.nix { };
    };
}
