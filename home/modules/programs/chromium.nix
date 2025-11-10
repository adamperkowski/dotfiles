{ config, ... }:

{
  programs.chromium = {
    enable = true;
    extensions = [
      { id = "fgmjlmbojbkmdpofahffgcpkhkngfpef"; } # Startpage
      { id = "bgnkhhnnamicmpeenaelnjfhikgbkllg"; } # AdGuard AdBlocker
      { id = "bkkmolkhemgaeaeggcmfbghljjjoofoh"; } # Catppuccin Chrome Theme - Mocha
      { id = "lnjaiaapbakfhlbjenjkhffcdpoompki"; } # Catppuccin for Web File Explorer Icons
      { id = "kaalofacklcidaampbokdplbklpeldpj"; } # Wide GitHub
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # Dark Reader
      { id = "clngdbkpkpeebahjckkjfobafhncgmne"; } # Stylus
    ];
  };

  age.secrets.chromium = {
    file = ../../../secrets/chromium.sh.age;
    mode = "0500";
    path = "${config.home.homeDirectory}/.local/bin/chromium";
  };

  home.sessionVariables.DEFAULT_BROWSER = "chromium";
  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "chromium-browser.desktop" ];
    "x-scheme-handler/http" = [ "chromium-browser.desktop" ];
    "x-scheme-handler/https" = [ "chromium-browser.desktop" ];
  };
}
