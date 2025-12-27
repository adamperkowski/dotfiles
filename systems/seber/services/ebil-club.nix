{ lib, pkgs, ... }:

let
  tls = {
    onlySSL = true;
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
                extraConfig = ''
                  if ($http_user_agent ~* "curl") {
                    rewrite ^ /index.txt last;
                  }
                  try_files $uri $uri/ =404;
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
      name = "kolpix";
      sshPubkey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDY0nHqaw1FriPBnK/hsdVGO69RGu6k/FAYNtUmYCEUS3MN0+loQWRwV2zk0KlWwIP/sMtWH/QjX5oNGpSt9Oj9jmfjgdPkQcl+4B/u93V6wK6Xl+5FufkXbtzENakPQVLX4INyZ9gViuRE4eguPFeRYSckcboxfeqlM24OUT7gvtn4r3z6c0Yx8qit/GVn1F7/ozi0lrSGknEVFUr3ewoQZWm7rpd9SjbTutqLtX6quEQzn6GG/wNxUodnIPwflGgBlfzej2SekuzLvnE1VfaaBvzOZei4VdvY7JrbKN+zlkmuKtEaZB7fkwOxegHsFRxLjSzLasI84wbWt38KTlDxPLjWPq62rJZOnI1XILCUamt9fSTraDfYeHeTCjrlKKctX0l4fvMLG4ZE1wHsELShisZuN4dPb1BqTgEL3s7n60kXG4TTUbo/frXocVf7PX1QINfnWkUPXT4fWkhYV0XALqBpnXs9XJXbk7dCWoWIuwm8+R2svcGvdiIrVGMy9cCP4bIqNzZ7NlOAvIysgmnLcv5GsTv7YfBXrJFnBXScsacqJaH3BLVg+zVYXKvokjZJ0mEa260aMqJDS7lK+xbnBhwH3B+tOAaR7ZoB0c1j2JyFOjTLL9K1uw0dRyQB4b0ZWQ08ByNi1rYT/FHBHU/Jl1rocEUgwmUDFNFufIMwZQ==";
    })
    (mkSite {
      name = "robin";
      sshPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKKxTuK2A7wbXnjkIhDrze4B5Uj2rnpmPAWGjPDMPiyk";
      canonical = "robinwobin.dev";
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
        "/discord".return = "302 https://discord.gg/mJAQHPJ9Eb";
      };
      extraConfig = "error_page 404 /404.html;";
    }
    // tls;
  };

  systemd.tmpfiles.rules = [
    "d /var/ebil.club 0755 root root -"
    "d /var/ebil.club/ebil.club 2750 adam nginx -"
  ];
}
