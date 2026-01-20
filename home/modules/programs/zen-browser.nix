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
        engines.searxng = {
          name = "SearXNG";
          iconMapObj."261" = "https://searxng.system72.dev/static/themes/simple/img/favicon.png";
          definedAliases = [ "@searxng" ];
          urls = [ { template = "https://searxng.system72.dev/search?q={searchTerms}"; } ];
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
        "zen.urlbar.behavior" = "float";
        "zen.view.use-single-toolbar" = false;
        "zen.view.sidebar-expanded" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "media.videocontrols.picture-in-picture.video-toggle.enabled" = true;
        "layout.css.prefers-color-scheme.content-override" = 0; # dark mode
      };
      userChrome = ''
        :root {
          --zen-main-browser-background: #191E21 !important;
          --zen-toolbar-element-bg: #262F33 !important;
          --tab-selected-bgcolor: #374145 !important;
          --toolbox-textcolor: #F8F9E8 !important;
          --sidebar-text-color: #839e9a !important;
          --toolbarbutton-icon-fill: #6F8788 !important;
        }
        label.toolbarbutton-text {
          color: #6F8788 !important;
        }
        label.zen-current-workspace-indicator-name {
          color: #ADC9BC !important;
        }
      '';
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
