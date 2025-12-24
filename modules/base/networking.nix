{
  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      extraCommands = ''
        iptables -I INPUT 1 -p tcp --dport 22 -m conntrack --ctstate NEW \
          -m recent --name SSH --rsource --update --seconds 120 --hitcount 10 -j DROP
        iptables -I INPUT 2 -p tcp --dport 22 -m conntrack --ctstate NEW \
          -m recent --name SSH --rsource --set
      '';
    };
  };
}
