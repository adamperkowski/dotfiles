{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim

      nvim-lspconfig

      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path

      indent-blankline-nvim
      nvim-autopairs
      undotree
      gitsigns-nvim
      copilot-lua
      nvim-colorizer-lua

      cord-nvim
      vim-wakatime

      jule-nvim
    ];
    extraPackages = with pkgs; [ lua-language-server ];
  };
}
