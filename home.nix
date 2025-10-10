{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    hypr = "hypr";
    nvim = "nvim";
  };
in {
  home.username = "adam";
  home.homeDirectory = "/home/adam";
  home.stateVersion = "25.05";

  programs.bash = {
    enable = true;
    shellAliases = {
      sudo = "sudo ";

      cp = "cp -i";
      nv = ''nvim -u "$HOME/.config/nvim/init.lua"'';
      shred = "shred -uvz";
      kitget =
        "/home/adam/github/nixpkgs/pkgs/by-name/ki/kitget/result/bin/kitget";

      diff = "diff --color=auto";
      grep = "grep --color=auto";
      ip = "ip -color=auto";
      ping = "prettyping";

      ls = "lsd -hN --group-directories-first --color=auto";
      la = "lsd -lahN --group-directories-first --color=auto";
      ll = "lsd -llhN --group-directories-first --color=auto";

      ga = "git add";
      gc = "git commit --edit -S";
      gp = "git push origin";
      gb = "git branch";
      gpull = "git pull origin";
      gmain =
        "if ! git checkout --track origin/main; then if ! git checkout main; then git checkout master; fi; fi";

      nixrs = "sudo nixos-rebuild switch";
    };
    initExtra = ''
            function shreddir() {
              find "$1" -type f -exec shred -uvz {} \; rm -rf "$1"
            }

            function ff() {
              kitget_output="/tmp/$(date +%s)"
      	kitget --square -o "$kitget_output"
      	clear
      	fastfetch --kitty "$kitget_output" "$@"
      	rm -f "$kitget_output"
            }

            ff
    '';
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec Hyprland
      fi
    '';
  };

  programs.git = {
    enable = true;
    signing.signByDefault = true;
    extraConfig.init.defaultBranch = "main";
  };

  programs.kitty = {
    enable = true;
    font.name = "Fira Code Nerd Font";
  };

  programs.fastfetch = { enable = true; };

  programs.rofi = {
    enable = true;
    theme = "Arc-Dark";
  };

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
      splashBackground = "#1e1e2e";
      splashColor = "#cdd6f4";
      splashTheming = true;
    };
    vencord.settings = {
      useQuickCss = true;
      themeLinks = [
        "https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css"
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

  home.packages = with pkgs; [
    nerd-fonts.fira-code
    prettyping
    # kitget
    lsd
  ];

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;
}
