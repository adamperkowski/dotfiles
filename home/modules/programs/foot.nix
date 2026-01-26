{ config, ... }:
{
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        include = "${config.evergarden.ports.foot}/evergarden-${config.evergarden.variant}-${config.evergarden.accent}.ini";
        font = "Maple Mono NF:pixelsize=15";
        dpi-aware = "yes";
      };
      cursor = {
        style = "beam";
        blink = "yes";
      };
    };
  };
}
