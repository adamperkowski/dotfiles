local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<C-p>', "<cmd>_dP<cr>", opts)
vim.keymap.set('n', 'J', "<cmd>m .+1<cr>", opts)
vim.keymap.set('n', 'K', "<cmd>m .-2<cr>", opts)
vim.keymap.set('n', '<C-t>', vim.cmd.Ex, opts)
vim.keymap.set('n', '<F5>', vim.cmd.UndotreeToggle, opts)

