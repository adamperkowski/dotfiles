{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "desktop";

  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";

  hardware.graphics.enable = true;

  services.xserver = {
    xkb = {
      layout = "us";
      variant = "colemak";
    };
    videoDrivers = [ "nvidia" ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = true;
    nvidiaSettings = false;
  };

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
    remotePlay.openFirewall = true;
  };

  programs.gamemode.enable = true;

  services.jellyfin = {
    enable = true;
    package = pkgs.jellyfin;
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [ cloudflared ];

  systemd.services.cloudflared = {
    description = "cloudflare tunnel";
    after = [ "jellyfin.service" ];

    script = "${pkgs.cloudflared}/bin/cloudflared tunnel run --token eyJhIjoiZTcyNjAwOGE4ZmVjNDIwYTNhMDMzZDU2MWNjMGYyZmYiLCJ0IjoiZDUwNTQ4NjktYzEzZC00ZDc4LTk4MjYtOGFhNGJmOWUwOTBiIiwicyI6Ik9UWm1PVEl3WldFdFptVXlOaTAwWWpkbUxUZ3dPVGt0T0RZeFptWmxaREUwWWprMCJ9";
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Restart = "on-failure";
      RestartSec = 60;
    };
  };
}
