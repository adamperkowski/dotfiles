{
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      LogLevel = "ERROR"; # haxerz OUT
      PubkeyAuthentication = true;
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      X11Forwarding = false;
      PermitTunnel = "no";
      PermitRootLogin = "no";
      AllowTcpForwarding = "no";
    };
  };
}
