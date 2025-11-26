{
  programs = {
    git = {
      enable = true;
      signing.signByDefault = true;

      settings = {
        core = {
          compression = 9;
          whitespace = "error";
          preloadindex = true;
        };

        pull.rebase = true;
        interactive.singleKey = true;

        rebase = {
          autoStash = true;
          missingCommitsCheck = "warn";
        };

        status = {
          branch = true;
          showStash = true;
          showUntrackedFiles = "all";
        };

        log = {
          abbrevCommit = true;
        };

        diff = {
          context = 3;
          renames = "copies";
          interHunkContext = 10;
        };

        "color \"diff\"" = {
          commit = "blue";
          meta = "black bold";
          frag = "magenta";
          context = "white";
          whitespace = "yellow reverse";
          old = "red";
        };

        "color \"decorate\"" = {
          HEAD = "cyan reverse bold";
          branch = "green";
          tag = "yellow";
          remoteBranch = "magenta";
        };

        init.defaultBranch = "main";
      };
    };
    diff-so-fancy = {
      enable = true;
      enableGitIntegration = true;
      settings.markEmptyLines = false;
    };
  };

}
