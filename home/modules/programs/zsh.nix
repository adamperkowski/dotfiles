{ pkgs, ... }:

let
  external = ../../../external/zsh;
in
{
  home.shell.enableZshIntegration = true;
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
      cp = "cp -i";
      nv = "nvim";
      car = "cat";
      shred = "shred -uvz";

      mkdirenv = "echo -e 'if has nix; then\\n  use flake\\nfi' >> .envrc && direnv allow";

      nixb = "nom build";
      nixs = "FF_SKIP=1 nom shell";
      nixdev = "FF_SKIP=1 nom develop -c \"$SHELL\"";

      diff = "diff --color=auto";
      grep = "grep --color=auto";
      ip = "ip -color=auto";
      ping = "prettyping";

      ls = "eza";
      ll = "eza -lg";
      la = "eza -lga";

      gap = "git add --patch";
      ga = "git add";
      gc = "git commit --edit -S";
      gp = "git push origin";
      gb = "git branch";
      gl = "git log";
      gd = "git diff";
      gco = "git checkout";
      gpull = "git pull origin";
      gmain = "if ! git checkout --track origin/main; then if ! git checkout main; then git checkout master; fi; fi";
    };

    initContent = ''
      ${builtins.readFile (external + "/keymap.zsh")}
      ${builtins.readFile (external + "/prompt.zsh")}
      ${builtins.readFile (external + "/functions.zsh")}

      export GPG_TTY=$(tty)
      source <(fzf --zsh)

      cuteff
    '';

    profileExtra = ''
      ${builtins.readFile (external + "/profile.zsh")}
    '';
  };
}
