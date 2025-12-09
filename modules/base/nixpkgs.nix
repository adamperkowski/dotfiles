# { inputs, ... }:

{
  nixpkgs = {
    config.allowUnfree = true;
    # overlays = [
    #   (_: prev: {
    #     unstable = import inputs.nixpkgs-unstable {
    #       system = prev.stdenv.hostPlatform.system;
    #       config = prev.config;
    #     };
    #   })
    # ];
  };
}
