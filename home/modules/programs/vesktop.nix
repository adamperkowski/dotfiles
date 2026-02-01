{ inputs, config, ... }:
let
  colors = inputs.evergarden.lib.util.mkPalette config.evergarden;
in
{
  programs.vesktop = {
    enable = true;
    settings = {
      arRPC = true;
      splashBackground = "#${colors.base}";
      splashColor = "#${colors.text}";
      splashTheming = true;
    };
    vencord = {
      extraQuickCss = ".media-engine-video { transform: none; }";
      settings = {
        useQuickCss = true;
        themeLinks = [
          "https://everviolet.github.io/discord/themes/evergarden-${config.evergarden.variant}-${config.evergarden.accent}.theme.css"
        ];
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
  };
}
