let
  koi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID9feAlrIVPuVS28tz54/m7pZkjHHL5aVhV2qwBPPceT";
  seber = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBAp82e57ij5x+Ei1Tjwxuex0fil5vV9wfEfNYgC5dFQ";
in
{
  "chromium.sh.age".publicKeys = [ koi ];
  "cloudflared.pem.age".publicKeys = [ koi ];
  "jellyfin-rpc.json.age".publicKeys = [ koi ];

  "vaultwarden.env.age".publicKeys = [ seber ];
  "ssl-adamperkowski.cert.pem.age".publicKeys = [ seber ];
  "ssl-adamperkowski.key.pem.age".publicKeys = [ seber ];
}
