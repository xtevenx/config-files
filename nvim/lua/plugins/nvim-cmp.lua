vim.opt.completeopt = { 'menuone', 'noselect' }

local cmp = require('cmp')

local luasnip = require('luasnip')

cmp.setup {
  enabled = function()
    -- Keep completion enabled in command-line mode.
    if vim.api.nvim_get_mode().mode == 'c' then
      return true
    else
      local context = require('cmp.config.context')
      return not context.in_treesitter_capture('comment')
          and not context.in_syntax_group('Comment')
    end
  end,
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<TAB>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        if (cmp.get_active_entry() ~= cmp.get_selected_entry()) then
          cmp.confirm()
        elseif #cmp.get_entries() == 1 then
          cmp.confirm({ select = true })
        else
          cmp.select_next_item()
        end
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end),
    ['<S-TAB>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end),
    ['<CR>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        if cmp.get_selected_entry() == nil then
          cmp.close()
        else
          cmp.confirm()
        end
      else
        fallback()
      end
    end),
  }),
  sources = {
    { name = 'nvim_lsp' },
    {
      name = 'path',
      option = { trailing_slash = true },
    },
    { name = 'luasnip' },
  },
  formatting = {
    format = require('lspkind').cmp_format(),
  },
}

local servers = {
  -- https://github.com/clangd/clangd
  -- Run `pacman -S clang'
  clangd = {},
  -- https://github.com/microsoft/pyright
  -- Run `pip install pyright'
  pyright = {},
  -- https://github.com/rust-lang/rust-analyzer
  -- Run `pacman -S rust-analyzer`
  -- <OR> Clone and run `cargo xtask install --server`
  rust_analyzer = {
    ['rust-analyzer'] = {
      checkOnSave = { command = 'clippy', features = 'all' },
    },
  },
  -- https://github.com/sumneko/lua-language-server
  -- Run `pacman -S lua-language-server`
  sumneko_lua = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      },
    },
  },
  -- https://github.com/latex-lsp/texlab
  -- Run `pacman -S texlab`
  -- <OR> `cargo install texlab`
  texlab = {
    texlab = {
      build = { onSave = true },
    },
  },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local on_attach = require('aerial').on_attach

local lspconfig = require('lspconfig')
for lsp, settings in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = settings,
  }
end

-- plugins/nvim-autopairs.lua
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
