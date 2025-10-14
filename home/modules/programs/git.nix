{
  programs.git = {
    enable = true;
    signing.signByDefault = true;
    extraConfig.init.defaultBranch = "main";
  };
}
