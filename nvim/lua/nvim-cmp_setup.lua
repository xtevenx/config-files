vim.opt.completeopt = {'menuone', 'noselect'}

local cmp = require('cmp')

local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<TAB>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        if (cmp.get_active_entry() ~= cmp.get_selected_entry()) then
          cmp.confirm()
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
    { name = 'buffer' },
    { name = 'nvim_lsp' },
    { name = 'path', option = { trailing_slash = true } },
    { name = 'luasnip' },
  },
  formatting = {
    format = require('lspkind').cmp_format(),
  },
})

local servers = {
  clangd = {},        -- https://github.com/clangd/clangd
                      -- Unzip release and add bin dir to path
  pyright = {},       -- https://github.com/microsoft/pyright
                      -- Run `npm install -g pyright`
  rust_analyzer = {}, -- https://github.com/rust-lang/rust-analyzer
                      -- Clone and run `cargo xtask install --server`
  sumneko_lua = {     -- https://github.com/sumneko/lua-language-server
                      -- Unzip release and add bin dir to path
    Lua = { diagnostics = { globals = {'vim'} } },
  },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')
for lsp, settings in pairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
    settings = settings,
  }
end
