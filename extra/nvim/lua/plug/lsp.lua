vim.diagnostic.config {
  signs = false,
  virtual_text = {
    virt_text_pos = 'right_align',
    suffix = ' ',
  },
  update_in_insert = true
}

local lspconfig = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local capabilities = cmp_nvim_lsp.default_capabilities()

lspconfig.rust_analyzer.setup {
  capabilities = capabilities
}

lspconfig.clangd.setup {
  capabilities = capabilities
}

lspconfig.lua_ls.setup {
  capabilities = capabilities,

  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc')) then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT'
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          "${3rd}/luv/library"
        }
      }
    })
  end,

  settings = {
    Lua = {}
  }
}
