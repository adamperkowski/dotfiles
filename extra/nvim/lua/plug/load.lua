local Plug = vim.fn['plug#']
vim.call('plug#begin')

Plug('julelang/jule.nvim')

Plug('neovim/nvim-lspconfig')

Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')

Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')

Plug('catppuccin/nvim', { ['as'] = 'catppuccin' })
-- TODO
-- Plug('nvim-lualine/lualine.nvim')

Plug('lukas-reineke/indent-blankline.nvim')
Plug('windwp/nvim-autopairs')
Plug('mbbill/undotree')
Plug('lewis6991/gitsigns.nvim')
Plug('zbirenbaum/copilot.lua')
Plug('norcalli/nvim-colorizer.lua')

Plug('andweeb/presence.nvim')
Plug('wakatime/vim-wakatime')

vim.call('plug#end')
