{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "laptop";

  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver = {
    xkb.layout = "us";
    xkbVariant = "colemak";
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
  ];
}
