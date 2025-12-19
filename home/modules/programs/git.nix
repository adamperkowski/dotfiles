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

        commit.template = "~/.gitmessage";
        init.defaultBranch = "main";
      };
    };
    diff-so-fancy = {
      enable = true;
      enableGitIntegration = true;
      settings.markEmptyLines = false;
    };
  };

  home.file.".gitmessage".text = ''


    # remember to set commit author to pr author when merging
    # Reviewed-on:
    # Reviewed-by: adam <me@adamperkowski.dev>
    # Signed-off-by: adam <me@adamperkowski.dev>
    # Co-authored-by: user <user@users.noreply.github.com>
  '';
}
