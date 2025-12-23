{ pkgs, ... }:

let
  mkSite =
    { name, sshPubkey }:
    let
      host = "${name}.ebil.club";
      home = "/var/ebil.club/${name}";
    in
    {
      services.nginx.virtualHosts."${host}" = {
        locations."/" = {
          root = "${home}/${host}";
          index = "index.html";
          extraConfig = "try_files $uri $uri/ =404;";
        };
        extraConfig = "error_page 404 /404.html;";
        sslCertificate = "/run/agenix/ssl-adamperkowski-cert";
        sslCertificateKey = "/run/agenix/ssl-adamperkowski-key";
        onlySSL = true;
      };

      users = {
        groups."${name}" = { };
        users."${name}" = {
          inherit home;
          isNormalUser = true;
          hashedPassword = "!";
          group = name;
          openssh.authorizedKeys.keys = [
            ''command="${pkgs.rrsync}/bin/rrsync ~/${host}",restrict,no-agent-forwarding,no-port-forwarding,no-pty,no-user-rc,no-X11-forwarding ${sshPubkey}''
          ];
        };
      };

      systemd.tmpfiles.rules = [
        "Z ${home} 0750 ${name} nginx"
        "d ${home}/${host} 0750 ${name} nginx -"
      ];
    };
in
{
  imports = [
    (mkSite {
      name = "seba";
      sshPubkey = "AAAAC3NzaC1lZDI1NTE5AAAAIN7xlBanf8BNQXosqGT5QroBntpFUsy3g12fO/fPE414";
    })
  ];

  services.nginx.virtualHosts."ebil.club" = {
    locations = {
      "/" = {
        root = "/var/ebil.club/ebil.club";
        index = "index.html";
        extraConfig = "try_files $uri $uri/ =404;";
      };
      "/discord".return = "302 https://discord.gg/mJAQHPJ9Eb";
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
