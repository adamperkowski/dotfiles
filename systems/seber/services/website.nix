{
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

  services.nginx.virtualHosts."adam.qpon" = {
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

  systemd.tmpfiles.rules = [ "d /var/website 2750 adam users -" ];
}
