{
  systemd.services.mimi = {
    description = "mimi tne discord bot";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    script = ''
      export $(cat .env | xargs)
      ./mimi/bin/mimi
    '';

    serviceConfig = {
      WorkingDirectory = "/var/mimi";
      Restart = "on-failure";
      RestartSec = 60;
    };
  };

  systemd.tmpfiles.rules = [ "d /var/mimi 2750 adam users -" ];
}
