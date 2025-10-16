{ pkgs, config, ... }:

{
  programs.zsh = {
    enable = true;

    plugins = [
      {
        name = "syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
        file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
      }
      {
        name = "autosuggestions";
        src = pkgs.zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
      }
      {
        name = "autopair";
        src = pkgs.zsh-autopair;
        file = "share/zsh/zsh-autopair/autopair.zsh";
      }
    ];

    shellAliases = {
      sudo = "sudo ";

      cp = "cp -i";
      nv = ''nvim -u "$HOME/.config/nvim/init.lua"'';
      shred = "shred -uvz";

      diff = "diff --color=auto";
      grep = "grep --color=auto";
      ip = "ip -color=auto";
      ping = "prettyping";

      ls = "lsd -hN";
      la = "lsd -lahN";
      ll = "lsd -llhN";

      ga = "git add";
      gc = "git commit --edit -S";
      gp = "git push origin";
      gb = "git branch";
      gpull = "git pull origin";
      gmain = "if ! git checkout --track origin/main; then if ! git checkout main; then git checkout master; fi; fi";
    };

    envExtra = ''
      export DOTFILES="${config.home.homeDirectory}/dotfiles"
    '';

    initContent = ''
      . "$DOTFILES/external/zsh/prompt.zsh"
      . "$DOTFILES/external/zsh/functions.zsh"

      ff
    '';

    profileExtra = ''
      . "$DOTFILES/external/zsh/profile.zsh"
    '';
  };
}
