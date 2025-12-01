{ inputs, ... }:

{
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
}
