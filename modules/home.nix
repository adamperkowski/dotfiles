{ inputs, ... }:

let
  anvim = inputs.anvim;
  agenix = inputs.agenix;
  spicetify-nix = inputs.spicetify-nix;
in
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    extraSpecialArgs = {
      inherit
        inputs
        anvim
        agenix
        spicetify-nix
        ;
    }; # TODO: optimize maybe
    users.adam = import ../home/adam.nix;
  };
}
