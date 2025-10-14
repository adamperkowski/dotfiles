require("catppuccin").setup {
  integraions = {
    cmp = true,
    gitsigns = true,
    native_lsp = true,
  }
}

vim.cmd.colorscheme("catppuccin")
