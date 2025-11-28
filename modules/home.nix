{ inputs, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    extraSpecialArgs = {
      inherit
        inputs
        ;
    }; # TODO: optimize maybe
    users.adam = import ../home/adam.nix;
  };
}
