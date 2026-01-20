{
  programs.vesktop = {
    enable = true;
    settings = {
      arRPC = true;
      splashBackground = "#232a2e";
      splashColor = "#f8f9e8";
      splashTheming = true;
    };
    vencord.settings = {
      useQuickCss = true;
      themeLinks = [ "https://everviolet.github.io/discord/themes/evergarden-fall-green.theme.css" ];
      plugins = {
        AlwaysExpandRoles.enabled = true;
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
        BetterGifPicker.enabled = true;
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
        ExpressionCloner.enabled = true;
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
        NoTrack = {
          enabled = true;
          disableAnalytics = true;
        };
        NoTypingAnimation.enabled = true;
        petpet.enabled = true;
        PinDMs.enabled = true;
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
        VolumeBooster.enabled = true;
        WhoReacted.enabled = true;
        YoutubeAdblock.enabled = true;
      };
    };
  };
}
