let
  tls = {
    forceSSL = true;
    sslCertificate = "/run/agenix/ssl-adamperkowski-cert";
    sslCertificateKey = "/run/agenix/ssl-adamperkowski-key";
  };
in
{
  nix.settings.trusted-users = [ "robin" ];

  users = {
    groups.robin = { };
    users.robin = {
      group = "robin";
      home = "/var/robin";
      createHome = false;
      isNormalUser = true;
      hashedPassword = "!";
      openssh.authorizedKeys.keys = [
        "no-agent-forwarding,no-port-forwarding,no-pty,no-user-rc,no-X11-forwarding ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDeSHaoF0Qs1G8JO/enOo2vxzkvvOqAMZPG2DX7TgG8u"
      ];
    };
  };

  systemd.tmpfiles.rules = [ "d /var/robin 2755 robin robin -" ];

  systemd.user.services.maivi = {
    description = "maivi :3";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    unitConfig.ConditionUser = "robin";
    serviceConfig = {
      ExecStart = "/var/robin/maivi";
      Restart = "on-failure";
      RestartSec = 20;
    };
  };

  services.nginx.virtualHosts = {
    "robinwobin.dev" = (
      {
        locations."/" = {
          proxyPass = "http://127.0.0.1:8008";
          extraConfig = ''
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header Host $host;
          '';
        };
      }
      // tls
    );
    "robin.ebil.club" = (
      {
        locations."/".return = "307 https://robinwobin.dev$request_uri";
      }
      // tls
    );
  };
}
