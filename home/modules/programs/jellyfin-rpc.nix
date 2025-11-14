{ pkgs, ... }:

{
  home.packages = with pkgs; [ jellyfin-rpc ];

  age.secrets.jellyfin-rpc = {
    file = ../../../secrets/jellyfin-rpc.json.age;
    mode = "0400";
  };

  systemd.user.services.jellyfin-rpc = {
    Unit = {
      Description = "jellyfin discord RPC";
      After = [ "network.target" ];
    };

    Service = {
      ExecStart = "${pkgs.jellyfin-rpc}/bin/jellyfin-rpc -c /run/user/1000/agenix/jellyfin-rpc";
      Restart = "on-failure";
      RestartSec = 60;
    };

    Install.WantedBy = [ "default.target" ];
  };
}
