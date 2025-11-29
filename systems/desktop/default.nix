{ pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.agenix.nixosModules.default
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

  age.secrets.cloudflare = {
    file = ../../secrets/cloudflare.pem.age;
    mode = "0400";
  };

  systemd.services.cloudflared = {
    description = "cloudflare tunnel";
    after = [ "jellyfin.service" ];

    script = ''
      export TUNNEL_ORIGIN_CERT=/run/agenix/cloudflare

      cloudflared=${pkgs.cloudflared}/bin/cloudflared
      token=$($cloudflared tunnel token jelly)

      $cloudflared tunnel run --token $token
    '';

    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Restart = "on-failure";
      RestartSec = 60;
    };
  };
}
