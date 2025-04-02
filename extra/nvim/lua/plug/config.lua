require('catppuccin').setup {
  integrations = {
    cmp = true,
    gitsigns = true,
    native_lsp = true
  }
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
    { name = 'jule' },
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  },
}

require('ibl').setup {
  scope = {
    enabled = false
  }
}
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
  },
  filetypes = {
    markdown = true
  }
}

require('jule').setup {
  format_on_save = true,
  enable_cmp = true,
}

vim.cmd.colorscheme 'catppuccin'
vim.g.undotree_SetFocusWhenToggle = true

if vim.fn.has('persistent_undo') == 1 then
  local target_path = vim.fn.expand("~/.vim_undo")

  if vim.fn.isdirectory(target_path) == 0 then
    vim.fn.mkdir(target_path, 'p')
  end

  vim.o.undodir = target_path
  vim.o.undofile = true
end

require('cord').setup {
  display = {
    theme = 'catppuccin',
    flavor = 'dark',
  }
}
