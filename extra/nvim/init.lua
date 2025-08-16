require("keymap")
require("plug.load")
require("plug.lsp")
require("plug.config")

vim.opt.number = true
vim.opt.relativenumber = true

vim.g.rustfmt_autosave = 1

-- hide all LSP semantic highlights
for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
	vim.api.nvim_set_hl(0, group, {})
end

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.cmd([[
  augroup Stylua
    autocmd BufWritePost *.lua lua local view = vim.fn.winsaveview(); vim.cmd('silent !stylua ' .. vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())); vim.cmd("edit"); vim.fn.winrestview(view)
  augroup END
]])
