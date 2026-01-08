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
    users.koi = import ../home/koi.nix;
  };
}
