{
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
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
