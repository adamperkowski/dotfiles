{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.rrsync ];

  services.nginx.virtualHosts."seba.ebil.club" = {
    locations."/" = {
      root = "/var/ebil.club/seba/seba.ebil.club";
      index = "index.html";
      extraConfig = "try_files $uri $uri/ =404;";
    };
    extraConfig = "error_page 404 /404.html;";
    onlySSL = true;
    sslCertificate = "/run/agenix/ssl-adamperkowski-cert";
    sslCertificateKey = "/run/agenix/ssl-adamperkowski-key";
  };

  users = {
    groups.seba = { };
    users.seba = {
      isNormalUser = true;
      home = "/var/ebil.club/seba";
      hashedPassword = "!";
      group = "seba";
      openssh.authorizedKeys.keys = [
        ''command="${pkgs.rrsync}/bin/rrsync ~/seba.ebil.club",restrict,no-agent-forwarding,no-port-forwarding,no-pty,no-user-rc,no-X11-forwarding ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN7xlBanf8BNQXosqGT5QroBntpFUsy3g12fO/fPE414''
      ];
    };
  };

  systemd.tmpfiles.rules = [
    "Z /var/ebil.club/seba 0750 seba nginx"
    "d /var/ebil.club/seba/seba.ebil.club 0750 seba nginx -"
  ];
}
