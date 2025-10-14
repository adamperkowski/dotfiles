{
  description = "my nixos dotfiles :3";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";

      mkHost =
        name:
        lib.nixosSystem {
          inherit system;
          modules = [
            ./modules/base
            ./systems/${name}
            home-manager.nixosModules.home-manager
            ./modules/home
          ];
        };
    in
    {
      nixosConfigurations = {
        desktop = mkHost "desktop";
        laptop = mkHost "laptop";
      };

      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-tree;
    };
}
