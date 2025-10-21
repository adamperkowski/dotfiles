require("keymap")

vim.opt.number = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.g.rustfmt_autosave = 1

vim.diagnostic.config {
  signs = false,
  underline = true,
  virtual_text = {
    virt_text_pos = "right_align",
    suffix = " ",
  },
  update_in_insert = true,
}

require("plugconfig")

for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  vim.api.nvim_set_hl(0, group, {})
end
