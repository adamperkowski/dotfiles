{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;

    colors = {
      bg = "#232a2e";
      "bg+" = "#2b3337";
      selected-bg = "#374145";
      fg = "#f8f9e8";
      "fg+" = "#f8f9e8";
      label = "#f8f9e8";
      hl = "#f5d098";
      "hl+" = "#f5d098";
      header = "#f57f82";
      info = "#cbe3b3";
      prompt = "#cbe3b3";
      border = "#2b3337";
      marker = "#96b4aa";
      pointer = "#96b4aa";
      spinner = "#96b4aa";
    };

    defaultOptions = [
      "--height=30%"
      "--info=inline"
      "--layout=reverse"
    ];
  };
}
