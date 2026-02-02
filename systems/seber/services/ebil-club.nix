{ lib, pkgs, ... }:

let
  tls = {
    forceSSL = true;
    sslCertificate = "/run/agenix/ssl-adamperkowski-cert";
    sslCertificateKey = "/run/agenix/ssl-adamperkowski-key";
  };

  mkSite =
    {
      name,
      sshPubkey,
      canonical ? null,
    }:
    let
      defaultHost = "${name}.ebil.club";
      servedHost = if canonical != null then canonical else defaultHost;

      home = "/var/ebil.club/${name}";
      rootDir = "${home}/${defaultHost}";
    in
    {
      services.nginx.virtualHosts = {
        "${servedHost}" = (
          {
            locations = {
              "/" = {
                root = rootDir;
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
                root = rootDir;
                extraConfig = "try_files /index.txt @curl_fallback;";
              };
              "@curl_fallback".return =
                "200 'hi! this site is best viewed in a web browser :3 if u still want to curl it, try setting a different user-agent header'";
            };
            extraConfig = "error_page 404 /404.html;";
          }
          // tls
        );
      }
      // lib.optionalAttrs (canonical != null) {
        "${defaultHost}" = (
          {
            locations."/".return = "307 https://${canonical}$request_uri";
          }
          // tls
        );
      };

      users = {
        groups."${name}" = { };
        users."${name}" = {
          inherit home;
          createHome = false;
          isNormalUser = true;
          hashedPassword = "!";
          group = name;
          openssh.authorizedKeys.keys = [
            ''command="${pkgs.rrsync}/bin/rrsync ~/${defaultHost}",restrict,no-agent-forwarding,no-port-forwarding,no-pty,no-user-rc,no-X11-forwarding ${sshPubkey}''
          ];
        };
      };

      systemd.tmpfiles.rules = [
        "d ${home} 0750 ${name} nginx -"
        "d ${home}/${defaultHost} 2750 ${name} nginx -"
      ];
    };
in
{
  imports = [
    (mkSite {
      name = "seba";
      sshPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN7xlBanf8BNQXosqGT5QroBntpFUsy3g12fO/fPE414";
    })
    (mkSite {
      name = "evergarden";
      sshPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAyvnWmxdPq+ztt2GevfT+Yc4E6X/uSHc4tfD2nwc1vq";
      canonical = "evergarden.moe";
    })
  ];

  services.nginx.virtualHosts = {
    "_" = {
      locations."/".return = "307 https://ebil.club";
      default = true;
    }
    // tls;

    "ebil.club" = {
      locations = {
        "/" = {
          root = "/var/ebil.club/ebil.club";
          index = "index.html";
          extraConfig = "try_files $uri $uri/ =404;";
        };
      };
      extraConfig = "error_page 404 /404.html;";
    }
    // tls;
  };

  systemd.tmpfiles.rules = [
    "d /var/ebil.club 0755 root root -"
    "d /var/ebil.club/ebil.club 2750 koi nginx -"
  ];
}
