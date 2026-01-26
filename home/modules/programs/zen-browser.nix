{ config, inputs, ... }:

{
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs.zen-browser = {
    enable = true;

    profiles.default = {
      id = 0;
      isDefault = true;
      search = {
        force = true;
        default = "searxng";
        engines = {
          searxng = {
            name = "SearXNG";
            definedAliases = [ "@searxng" ];
            urls = [ { template = "https://searxng.system72.dev/search?q={searchTerms}"; } ];
            iconMapObj."261" = "https://searxng.system72.dev/static/themes/simple/img/favicon.png";
          };
          nixpkgs = {
            name = "Nixpkgs";
            definedAliases = [ "@nixpkgs" ];
            urls = [ { template = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}"; } ];
            iconMapObj."16" = "https://search.nixos.org/favicon.png";
          };
          nixos = {
            name = "NixOS Options";
            definedAliases = [ "@nixos" ];
            urls = [ { template = "https://search.nixos.org/options?channel=unstable&query={searchTerms}"; } ];
            iconMapObj."16" = "https://search.nixos.org/favicon.png";
          };
          mynixos = {
            name = "MyNixOS";
            definedAliases = [ "@mynixos" ];
            urls = [ { template = "https://mynixos.com/search?q={searchTerms}"; } ];
            iconMapObj."32" = "https://mynixos.com/favicon.ico";
          };
        };
      };
      settings = {
        "browser.search.separatePrivateDefault" = false;
        "browser.tabs.groups.enabled" = true;
        "browser.tabs.warnOnClose" = false;
        "devtools.theme" = "dark";
        "font.name.serif.x-western" = "Noto Serif";
        "general.autoScroll" = true;
        "layout.spellcheckDefault" = 0;
        "privacy.userContext.enabled" = false; # container tabs
        "zen.glance.enabled" = false;
        "zen.tabs.show-newtab-vertical" = false;
        "zen.welcome-screen.seen" = true;
        "zen.urlbar.behavior" = "floating-on-type";
        "zen.view.use-single-toolbar" = false;
        "zen.view.sidebar-expanded" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "media.videocontrols.picture-in-picture.video-toggle.enabled" = true;
        "layout.css.prefers-color-scheme.content-override" = 0; # dark mode
      };
      userChrome = builtins.readFile ../../../external/userChrome.css;
    };

    policies =
      let
        mkExtension =
          {
            id,
            pinned ? false,
            private ? false,
          }:
          {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/${id}/latest.xpi";
            installation_mode = "force_installed";
            default_area = if pinned then "navbar" else "menupanel";
            private_browsing = private;
          };

        mkExtensionSettings = builtins.mapAttrs (
          _: e: if builtins.isAttrs e then e else mkExtension { id = e; }
        );
      in
      {
        PromptForDownloadLocation = true;
        DefaultDownloadDirectory = config.xdg.userDirs.download;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableForgetButton = true;
        DisableFirefoxAccounts = true;
        DisableFirefoxStudies = true;
        DisableFirefoxScreenshots = true;
        DisableFirefoxPocket = true;
        DisableSafeMode = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        PictureInPicture = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
          EmailTracking = true;
          SuspectedFingerprinting = true;
        };
        GenerativeAI = {
          Enabled = false;
          Locked = true;
        };
        ExtensionSettings = mkExtensionSettings {
          "uBlock0@raymondhill.net" = mkExtension {
            id = "ublock-origin";
            pinned = true;
            private = true;
          };
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = mkExtension {
            id = "bitwarden-password-manager";
            pinned = true;
          };
          "addon@darkreader.org" = mkExtension {
            id = "darkreader";
            pinned = true;
          };
          "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}" = mkExtension {
            id = "styl-us";
            pinned = true;
          };
          "redirector@einaregilsson.com" = mkExtension {
            id = "redirector";
            pinned = true;
            private = true;
          };
          "{a29c89d0-8d34-47c1-8c30-6e4ade95bd1a}" = "wide-github-chrome";
        };
      };
  };

  home.sessionVariables.DEFAULT_BROWSER = "zen-beta";
  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "zen-beta.desktop" ];
    "x-scheme-handler/http" = [ "zen-beta.desktop" ];
    "x-scheme-handler/https" = [ "zen-beta.desktop" ];
  };
}
