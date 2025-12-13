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
    nodejs
  ];

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

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

      "vault.adamperkowski.dev" = {
        locations."/" = {
          proxyPass = "http://127.0.0.1:8222";
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

      "lebel.adamperkowski.dev" = {
        locations."/" = {
          proxyPass = "http://127.0.0.1:14831";
          extraConfig = ''
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header Host $host;

            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
          '';
        };
        onlySSL = true;
        sslCertificate = "/run/agenix/ssl-adamperkowski-cert";
        sslCertificateKey = "/run/agenix/ssl-adamperkowski-key";
      };
    };
  };

  services.vaultwarden = {
    enable = true;
    environmentFile = "/run/agenix/vaultwarden-env";
    config = {
      DOMAIN = "https://vault.adamperkowski.dev";
      SIGNUPS_ALLOWED = false;
      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;
      ROCKET_LOG = "critical";
      LOG_LEVEL = "warn";
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

  systemd.services.lebel = {
    description = "lebel";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      User = "adam";
      Group = "users";
      ExecStart = "${pkgs.nodejs}/bin/node --env-file /var/lebel/.env /var/lebel/build/main.js";
      WorkingDirectory = "/var/lebel";
      Restart = "on-failure";
      RestartSec = 10;
    };
  };
}
