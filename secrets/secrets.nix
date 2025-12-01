let
  adam = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID9feAlrIVPuVS28tz54/m7pZkjHHL5aVhV2qwBPPceT";
  seber = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIXT/a7M/lYUEkWmRz+aTko8GPi0SVvabNx2NxflVpi3";
in
{
  "chromium.sh.age".publicKeys = [ adam ];
  "cloudflared.pem.age".publicKeys = [ adam ];
  "jellyfin-rpc.json.age".publicKeys = [ adam ];
  "wakatime.cfg.age".publicKeys = [ adam ];

  "ssl-adamperkowski.cert.pem.age".publicKeys = [ seber ];
  "ssl-adamperkowski.key.pem.age".publicKeys = [ seber ];
}
