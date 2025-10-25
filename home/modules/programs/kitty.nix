{
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    font.name = "Fira Code Nerd Font";
    shellIntegration.enableZshIntegration = true;
    shellIntegration.mode = "no-rc no-cursor";
    settings = {
      cursor = "#b4befe";
      cursor_shape = "beam";
      cursor_shape_unfocused = "hollow";
      cursor_trail = 1;
      cursor_trail_decay = "0.05 0.2";
      cursor_trail_start_threshold = 2;
      enable_audio_bell = false;
    };
  };
}
