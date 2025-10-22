{
  programs.chromium = {
    enable = true;
    extensions = [
      { id = "fgmjlmbojbkmdpofahffgcpkhkngfpef"; } # Startpage
      { id = "bgnkhhnnamicmpeenaelnjfhikgbkllg"; } # AdGuard AdBlocker
      { id = "bkkmolkhemgaeaeggcmfbghljjjoofoh"; } # Catppuccin Chrome Theme - Mocha
      { id = "lnjaiaapbakfhlbjenjkhffcdpoompki"; } # Catppuccin for Web File Explorer Icons
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # Dark Reader
      { id = "clngdbkpkpeebahjckkjfobafhncgmne"; } # Stylus
    ];
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "chromium-browser.desktop" ];
    "x-scheme-handler/http" = [ "chromium-browser.desktop" ];
    "x-scheme-handler/https" = [ "chromium-browser.desktop" ];
  };

  home.sessionVariables.DEFAULT_BROWSER = "chromium";
}
