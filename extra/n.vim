call plug#begin()

Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'nanotee/zoxide.vim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'windwp/nvim-autopairs'
Plug 'wakatime/vim-wakatime'
Plug 'lambdalisue/vim-suda'
Plug 'julelang/jule.nvim', { 'branch': 'main' }
Plug 'mbbill/undotree'
Plug 'lewis6991/gitsigns.nvim'
Plug 'github/copilot.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'norcalli/nvim-colorizer.lua'

call plug#end()

set number
set relativenumber

highlight CocFloating ctermbg=black

colorscheme catppuccin-mocha

set tabstop=4
set shiftwidth=4
set expandtab

let g:rustfmt_autosave = 1

lua << EOF
require("jule").setup {
  format_on_save = true,
}

require("ibl").setup()
require("nvim-autopairs").setup {}
require'colorizer'.setup()

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

EOF

cnoreabbrev sudow SudaWrite

imap <silent><script><expr> <M-Tab> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

nnoremap <leader>tc :tabnew<CR>
nnoremap <leader>tn :tabnext<CR>
nnoremap <leader>tp :tabprevious<CR>
nnoremap <leader>tq :tabclose<CR>
nnoremap <C-t> :Ex<CR>
nnoremap <F5> :UndotreeToggle<CR>
nnoremap J :m .+1<CR>
nnoremap K :m .-2<CR>
nnoremap <C-p> "_dP
noremap q b
