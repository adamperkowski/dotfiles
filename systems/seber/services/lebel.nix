{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.nodejs ];

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

  services.nginx.virtualHosts."lebel.ebil.club" = {
    locations = {
      "= /".return = "301 https://ebil.club";
      "/" = {
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
    };
    onlySSL = true;
    sslCertificate = "/run/agenix/ssl-adamperkowski-cert";
    sslCertificateKey = "/run/agenix/ssl-adamperkowski-key";
  };

  systemd.tmpfiles.rules = [ "d /var/lebel 0750 adam users -" ];
}
