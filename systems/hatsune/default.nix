{ pkgs, ... }:

{
  imports = [ ./hardware.nix ];

  boot.loader.systemd-boot.enable = true;

  networking.hostName = "hatsune";

  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver = {
    xkb = {
      layout = "us";
      variant = "colemak";
    };
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
  ];
}
