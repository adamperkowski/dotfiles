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
    initExtra = ''
      PS1='\[\e[2m\]\u\[\e[0;38;2;180;190;254m\]@\[\e[0;2m\]\h\[\e[0m\]:\[\e[38;2;180;190;254m\]\l\[\e[0m\] \[\e[2m\]->\[\e[0m\] \[\e[38;2;180;190;254m\]$(pwd | sed "s|^$HOME|~|" | sed "s/\//\[\e[0;2m\] » \[\e[0;38;2;180;190;254m\]/g")\[\e[0m\] \[\e[2m\](\[\e[0;0m\]$?\[\e[0;2m\])\n\[\e[0m\]\[\e[38;2;180;190;254m\]>\[\e[0m\] '

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
