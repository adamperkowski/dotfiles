{
  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      extraCommands = ''
        set -euo pipefail

        ensure_rule() {
          if ! iptables -C INPUT "$@" 2>/dev/null; then
            iptables -I INPUT 1 "$@"
          fi
        }
        ensure_rule6() {
          if ! ip6tables -C INPUT "$@" 2>/dev/null; then
            ip6tables -I INPUT 1 "$@"
          fi
        }

        v4blocklist=(
          '66.132.159.0/24'
          '162.142.125.0/24'
          '167.94.138.0/24'
          '167.94.145.0/24'
          '167.94.146.0/24'
          '167.248.133.0/24'
          '199.45.154.0/24'
          '199.45.155.0/24'
          '206.168.34.0/24'
          '206.168.35.0/24'
        )
        v6blocklist=(
          '2602:80d:1000:b0cc:e::/80'
          '2620:96:e000:b0cc:e::/80'
          '2602:80d:1003::/112'
          '2602:80d:1004::/112'
        )

        for ip in "''${v4blocklist[@]}"; do
          ensure_rule -s "$ip" -j DROP
        done
        for ip in "''${v6blocklist[@]}"; do
          ensure_rule6 -s "$ip" -j DROP
        done
      '';
    };
  };
}
