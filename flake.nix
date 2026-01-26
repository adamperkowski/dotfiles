{
  description = "my nixos dotfiles :3";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    systems.url = "github:nix-systems/default";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anvim = {
      url = "https://codeberg.org/koibtw/anvim/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cuteff = {
      url = "https://codeberg.org/koibtw/cuteff/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    evergarden = {
      url = "https://codeberg.org/evergarden/nix/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-stable.follows = "nixpkgs";
      };
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        home-manager.follows = "home-manager";
      };
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
