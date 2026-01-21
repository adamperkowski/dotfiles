{ lib, config, ... }:

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
      hashedPassword = lib.mkForce "!";
      openssh.authorizedKeys.keys = lib.mkForce [
        "no-agent-forwarding,no-port-forwarding,no-pty,no-user-rc,no-X11-forwarding ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDeSHaoF0Qs1G8JO/enOo2vxzkvvOqAMZPG2DX7TgG8u"
      ];
    };
  };

  systemd.user.services.maivi = {
    description = "maivi :3";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    unitConfig.ConditionUser = "robin";
    serviceConfig = {
      ExecStart = "${config.users.users.robin.home}/maivi";
      Restart = "on-failure";
      RestartSec = 20;
    };
  };

  services.nginx.virtualHosts = {
    "robinwobin.dev" = (
      {
        locations = {
          "/" = {
            root = "/var/ebil.club/robin/robin.ebil.club";
            index = "index.html";
            extraConfig = "try_files $uri $uri/ =404;";
          };
          "= /" = {
            extraConfig = ''
              if ($http_user_agent ~* "curl") {
                return 302 /index.txt;
              }
            '';
          };
          "/index.txt" = {
            root = "/var/ebil.club/robin/robin.ebil.club";
            extraConfig = "try_files /index.txt @curl_fallback;";
          };
          "@curl_fallback".return =
            "200 'hi! this site is best viewed in a web browser :3 if u still want to curl it, try setting a different user-agent header'";
        };
        extraConfig = "error_page 404 /404.html;";
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

  /*
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
  */
}
