{ config, ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      sudo = "sudo ";

      cp = "cp -i";
      nv = ''nvim -u "$HOME/.config/nvim/init.lua"'';
      shred = "shred -uvz";

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
      gmain = "if ! git checkout --track origin/main; then if ! git checkout main; then git checkout master; fi; fi";
    };
    initExtra = ''
      . ${config.home.homeDirectory}/dotfiles/external/bash/functions.sh

      ff
    '';
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec Hyprland
      fi
    '';
  };
}
