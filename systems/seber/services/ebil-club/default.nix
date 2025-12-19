{
  imports = [ ./seba.nix ];

  services.nginx.virtualHosts."ebil.club" = {
    locations."/" = {
      return = "200 'meow dm to get cool handle https://witchsky.app/profile/did:plc:b26ewgkrnx3yvsp2cdao3ntu :3'";
      extraConfig = ''
        add_header Content-Type text/plain;
      '';
    };
    onlySSL = true;
    sslCertificate = "/run/agenix/ssl-adamperkowski-cert";
    sslCertificateKey = "/run/agenix/ssl-adamperkowski-key";
  };
}
