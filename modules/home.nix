{ inputs, ... }:

let
  iamb = inputs.iamb;
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
        iamb
        anvim
        agenix
        spicetify-nix
        ;
    }; # TODO: optimize maybe
    users.adam = import ../home/adam.nix;
  };
}
