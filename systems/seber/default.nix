{ inputs, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    inputs.agenix.nixosModules.default
  ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
  };

  networking.hostName = "seber";

  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    git
    vim
    htop
  ];

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  age = {
    identityPaths = [ "/home/adam/.ssh/id_ed25519" ];
    secrets = {
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

  services.nginx = {
    enable = true;
    virtualHosts = {
      "adam.qpon" = {
        locations."/" = {
          proxyPass = "http://127.0.0.1:8000";
          extraConfig = ''
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header Host $host;
          '';
        };

        onlySSL = true;
        sslCertificate = "/run/agenix/ssl-adamperkowski-cert";
        sslCertificateKey = "/run/agenix/ssl-adamperkowski-key";
      };
    };
  };

  systemd.services.website = {
    description = "my site :3";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "/var/website/website/bin/website";
      WorkingDirectory = "/var/website";
      Restart = "on-failure";
      RestartSec = 10;
    };
  };
}
