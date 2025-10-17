{ inputs, ... }:

let
  agenix = inputs.agenix;
  spicetify-nix = inputs.spicetify-nix;
in
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    extraSpecialArgs = { inherit agenix spicetify-nix; };
    users.adam = import ../../home/adam.nix;
  };
}
