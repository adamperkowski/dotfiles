{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;

    colors = {
      bg = "#1e1e2e";
      "bg+" = "#313244";
      selected-bg = "#45475a";
      fg = "#cdd6f4";
      "fg+" = "#cdd6f4";
      label = "#cdd6f4";
      hl = "#cba6f7";
      "hl+" = "#cba6f7";
      header = "#f38ba8";
      info = "#b4befe";
      prompt = "#b4befe";
      border = "#6c7086";
      marker = "#a6adc8";
      pointer = "#a6adc8";
      spinner = "#a6adc8";
    };

    defaultOptions = [
      "--height=30%"
      "--info=inline"
      "--layout=reverse"
    ];
  };
}
