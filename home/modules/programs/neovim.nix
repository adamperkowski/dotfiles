{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim

      nvim-lspconfig

      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path

      indent-blankline-nvim
      nvim-autopairs
      undotree
      gitsigns-nvim
      copilot-lua
      nvim-colorizer-lua

      cord-nvim
      vim-wakatime

      jule-nvim
    ];
    extraPackages = with pkgs; [ lua-language-server ];
  };

  programs.vesktop = {
    enable = true;
    settings = {
      arRPC = true;
      splashBackground = "#1e1e2e";
      splashColor = "#cdd6f4";
      splashTheming = true;
    };
    vencord.settings = {
      useQuickCss = true;
      themeLinks = [
        "https://catppuccin.github.io/discord/dist/catppuccin-mocha-lavender.theme.css"
        "https://raw.githubusercontent.com/mwittrien/BetterDiscordAddons/master/Themes/SettingsModal/SettingsModal.theme.css"
      ];
      plugins = {
        NoTrack = {
          enabled = true;
          disableAnalytics = true;
        };
        AlwaysTrust = {
          enabled = true;
          domain = true;
          file = true;
        };
        AnonymiseFileNames = {
          enabled = true;
          anonymiseByDefault = true;
          method = 0;
          randomisedLength = 8;
        };
        BetterSettings = {
          enabled = true;
          disableFade = true;
          organizeMenu = true;
        };
        CallTimer.enabled = true;
        ClearURLs.enabled = true;
        Decor = {
          enabled = true;
          agreedToGuidelines = true;
        };
        Experiments.enabled = true;
        FakeNitro = {
          enabled = true;
          enableEmojiBypass = true;
          emojiSize = 48;
          transformEmojis = true;
          enableStickerBypass = true;
          stickerSize = 160;
          transformStickers = true;
          transformCompoundSentence = true;
          enableStreamQualityBypass = true;
          useHyperLinks = true;
        };
        FakeProfileThemes = {
          enabled = true;
          nitroFirst = true;
        };
        FavoriteGifSearch.enabled = true;
        FixCodeblockGap.enabled = true;
        ForceOwnerCrown.enabled = true;
        FriendsSince.enabled = true;
        MessageLogger = {
          enabled = true;
          deketeStyle = "text";
          logDeletes = true;
          logEdits = true;
          ignoreBots = false;
          ignoreSelf = false;
          collapseDeleted = true;
          inlineEdits = true;
        };
        MoreKaomoji.enabled = true;
        NoTypingAnimation.enabled = true;
        petpet.enabled = true;
        RelationshipNotifier.enabled = true;
        ShowHiddenChannels.enabled = true;
        ShowHiddenThings.enabled = true;
        ShowMeYourName = {
          enabled = true;
          mode = "nick-user";
          displayNames = false;
          inReplies = false;
          friendNicknames = "dms";
        };
        SilentTyping = {
          enabled = true;
          showIcon = true;
        };
        USRBG.enabled = true;
        ViewRaw.enabled = true;
        WhoReacted.enabled = true;
        VolumeBooster.enabled = true;
      };
    };
  };
}
