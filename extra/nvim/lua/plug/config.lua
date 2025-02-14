vim.cmd.colorscheme "catppuccin"
vim.g.undotree_SetFocusWhenToggle = true

local cmp_nvim_lsp = require('cmp_nvim_lsp')
local capabilities = cmp_nvim_lsp.default_capabilities()

vim.diagnostic.config {
  signs = false,
  virtual_text = {
    virt_text_pos = 'right_align',
    suffix = ' ',
  }
}

local lspconfig = require('lspconfig')
lspconfig.rust_analyzer.setup {
  capabilities = capabilities
}

require('mason').setup {
  ui = {
    icons = {
      package_installed = '',
      package_pending = '󱍢',
      package_uninstalled = '',
    }
  }
}

require('mason-lspconfig').setup {
  ensure_installed = {
    'rust_analyzer'
  },
  automatic_installation = true
}

local cmp = require('cmp')
cmp.setup {
  completion = {
    completeopt = 'menu,menuone,preview,noselect',
  },
  mapping = cmp.mapping.preset.insert {
    ["<Up>"] = cmp.mapping.select_prev_item(),
    ["<Down>"] = cmp.mapping.select_next_item(),
    ["<Tab>"] = cmp.mapping.confirm({ select = false }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  },
}

require('ibl').setup {}
require('nvim-autopairs').setup {}

require('gitsigns').setup {
  signs = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged_enable = true,
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
    use_focus = true,
  },
  current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
}

require('copilot').setup {
  panel = {
    enabled = false
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    keymap = {
      accept = '<M-Tab>'
    }
  }
}

require('jule').setup {
  format_on_save = true
}

if vim.fn.has('persistent_undo') == 1 then
  local target_path = vim.fn.expand("~/.vim_undo")

  if vim.fn.isdirectory(target_path) == 0 then
    vim.fn.mkdir(target_path, 'p')
  end

  vim.o.undodir = target_path
  vim.o.undofile = true
end
