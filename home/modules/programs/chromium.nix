{ config, ... }:

{
  programs.chromium = {
    enable = true;
    extensions = [
      "fgmjlmbojbkmdpofahffgcpkhkngfpef" # Startpage
      "jegbdohdgebjljoljfeinojeobdabpjo" # Redirector
      "bgnkhhnnamicmpeenaelnjfhikgbkllg" # AdGuard AdBlocker
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden Password Manager
      "bkkmolkhemgaeaeggcmfbghljjjoofoh" # Catppuccin Chrome Theme - Mocha
      "lnjaiaapbakfhlbjenjkhffcdpoompki" # Catppuccin for Web File Explorer Icons
      "kaalofacklcidaampbokdplbklpeldpj" # Wide GitHub
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
      "clngdbkpkpeebahjckkjfobafhncgmne" # Stylus
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
