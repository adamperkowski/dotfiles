let
  adam = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID9feAlrIVPuVS28tz54/m7pZkjHHL5aVhV2qwBPPceT";
in
{
  "chromium.sh.age".publicKeys = [ adam ];
  "wakatime.cfg.age".publicKeys = [ adam ];
}
