{
  imports = [ ./seba.nix ];

  services.nginx.virtualHosts."ebil.club" = {
    locations."/" = {
      root = "/var/ebil.club/ebil.club";
      index = "index.html";
      extraConfig = "try_files $uri $uri/ =404;";
    };
    extraConfig = "error_page 404 /404.html;";
    onlySSL = true;
    sslCertificate = "/run/agenix/ssl-adamperkowski-cert";
    sslCertificateKey = "/run/agenix/ssl-adamperkowski-key";
  };

  systemd.tmpfiles.rules = [
    "Z /var/ebil.club/ebil.club 0750 adam nginx"
    "d /var/ebil.club/ebil.club 0750 adam nginx -"
  ];
}
