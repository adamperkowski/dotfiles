{ pkgs, ... }:

{
  nix = {
    package = pkgs.lixPackageSets.stable.lix;

    settings = {
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      trusted-users = [
        "root"
        "adam"
      ];
    };
  };
}
