{ inputs, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    inputs.agenix.nixosModules.default
    ./services
  ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
  };

  networking = {
    hostName = "seber";
    firewall.allowedTCPPorts = [
      80
      443
    ];
  };

  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    git
    vim
    htop
  ];

  services.nginx.enable = true;

  age = {
    identityPaths = [ "/home/adam/.ssh/id_ed25519" ];
    secrets = {
      vaultwarden-env = {
        file = ../../secrets/vaultwarden.env.age;
        mode = "0400";
        owner = "vaultwarden";
      };
      ssl-adamperkowski-cert = {
        file = ../../secrets/ssl-adamperkowski.cert.pem.age;
        mode = "0440";
        group = "nginx";
      };
      ssl-adamperkowski-key = {
        file = ../../secrets/ssl-adamperkowski.key.pem.age;
        mode = "0440";
        group = "nginx";
      };
    };
  };
}
