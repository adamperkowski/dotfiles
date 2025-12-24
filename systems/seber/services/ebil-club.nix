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
      sshPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN7xlBanf8BNQXosqGT5QroBntpFUsy3g12fO/fPE414";
    })
    (mkSite {
      name = "kolpix";
      sshPubkey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDY0nHqaw1FriPBnK/hsdVGO69RGu6k/FAYNtUmYCEUS3MN0+loQWRwV2zk0KlWwIP/sMtWH/QjX5oNGpSt9Oj9jmfjgdPkQcl+4B/u93V6wK6Xl+5FufkXbtzENakPQVLX4INyZ9gViuRE4eguPFeRYSckcboxfeqlM24OUT7gvtn4r3z6c0Yx8qit/GVn1F7/ozi0lrSGknEVFUr3ewoQZWm7rpd9SjbTutqLtX6quEQzn6GG/wNxUodnIPwflGgBlfzej2SekuzLvnE1VfaaBvzOZei4VdvY7JrbKN+zlkmuKtEaZB7fkwOxegHsFRxLjSzLasI84wbWt38KTlDxPLjWPq62rJZOnI1XILCUamt9fSTraDfYeHeTCjrlKKctX0l4fvMLG4ZE1wHsELShisZuN4dPb1BqTgEL3s7n60kXG4TTUbo/frXocVf7PX1QINfnWkUPXT4fWkhYV0XALqBpnXs9XJXbk7dCWoWIuwm8+R2svcGvdiIrVGMy9cCP4bIqNzZ7NlOAvIysgmnLcv5GsTv7YfBXrJFnBXScsacqJaH3BLVg+zVYXKvokjZJ0mEa260aMqJDS7lK+xbnBhwH3B+tOAaR7ZoB0c1j2JyFOjTLL9K1uw0dRyQB4b0ZWQ08ByNi1rYT/FHBHU/Jl1rocEUgwmUDFNFufIMwZQ==";
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
    "d /var/ebil.club 0755 - - -"
    "Z /var/ebil.club/ebil.club 0750 adam nginx"
    "d /var/ebil.club/ebil.club 0750 adam nginx -"
  ];
}
