{
  programs.jujutsu = {
    enable = true;

    settings = {
      user = {
        name = "koi";
        email = "me@koi.rip";
      };

      signing = {
        behavior = "force";
        backend = "gpg";
        key = "5A530832DA9120B0CA57DDB67CBDB58ECF1D3478";
      };

      ui = {
        diff-formatter = ":git";
        pager = [
          "sh"
          "-c"
          "diff-so-fancy | less -RFX"
        ];
      };

      colors = {
        "diff added token" = {
          underline = false;
        };
        "diff removed token" = {
          underline = false;
        };
      };

      aliases = {
        init = [
          "git"
          "init"
          "--colocate"
        ];
        clone = [
          "git"
          "clone"
          "--colocate"
          "--fetch-tags=none"
          "--branch"
        ];
        update = [
          "bookmark"
          "move"
          "--to=first_parent(@)"
        ];
      };

      templates = {
        draft_commit_description = ''
          concat(
            builtin_draft_commit_description,
            "${
              builtins.replaceStrings [ "# " ] [ "JJ: " ] (builtins.readFile ../../../external/gitmessage.txt)
            }",
            "\nJJ: ignore-rest\n",
            diff.git(),
          )
        '';
      };
    };
  };
}
