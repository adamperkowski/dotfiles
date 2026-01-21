{
  users.users.robin = {
    isNormalUser = true;
    hashedPassword = "$y$j9T$fjikoYmPQxjKqjobJ/vZC/$ULBf6ns9PS8EUHBeRbnd3QQbOSCtAe18JhK3UUy.nv2";
    ignoreShellProgramCheck = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKKxTuK2A7wbXnjkIhDrze4B5Uj2rnpmPAWGjPDMPiyk robin"
    ];
  };

  systemd.tmpfiles.rules = [ "d /var/boo 770 robin users -" ];
}
