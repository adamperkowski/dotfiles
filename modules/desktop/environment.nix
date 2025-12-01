{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    xwayland-satellite
    htop
  ];
}
