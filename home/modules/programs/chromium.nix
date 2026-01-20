{ config, ... }:

{
  programs.chromium = {
    enable = true;
    extensions = [
      "jegbdohdgebjljoljfeinojeobdabpjo" # Redirector
      "bgnkhhnnamicmpeenaelnjfhikgbkllg" # AdGuard AdBlocker
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden Password Manager
      "hkgfoiooedgoejojocmhlaklaeopbecg" # Picture-in-Picture Extension (by Google)
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
}
