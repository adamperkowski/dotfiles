{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware.nix
    inputs.agenix.nixosModules.default
  ];

  boot.loader.systemd-boot.enable = true;

  networking.hostName = "miku";

  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver = {
    xkb = {
      layout = "us";
      variant = "colemak";
    };

    videoDrivers = [ "nvidia" ];
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      open = true;
      nvidiaSettings = false;
    };
  };

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
    remotePlay.openFirewall = true;
  };

  programs.gamemode.enable = true;

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    cloudflared
    prismlauncher
  ];

  age = {
    identityPaths = [ "${config.users.users.koi.home}/.ssh/id_ed25519" ];

    secrets.cloudflared = {
      file = ../../secrets/cloudflared.pem.age;
      mode = "0400";
    };
  };

  systemd.services.cloudflared = {
    description = "cloudflare tunnel";
    after = [ "jellyfin.service" ];

    script = ''
      export TUNNEL_ORIGIN_CERT=/run/agenix/cloudflared

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
