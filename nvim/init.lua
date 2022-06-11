require('plugins')

local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<TAB>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
      else
        fallback()
      end
    end),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = 'buffer' },
    { name = 'nvim_lsp' },
    { name = 'path', option = { trailing_slash = true } },
    { name = 'vsnip' },
  },
  formatting = {
    format = require('lspkind').cmp_format(),
  },
})

local servers = {
  'clangd',           -- https://github.com/clangd/clangd
                      -- Unzip release and add bin dir to path
  'rust_analyzer',    -- https://github.com/rust-lang/rust-analyzer
                      -- Clone and run `cargo xtask install --server`
  'sumneko_lua',      -- https://github.com/sumneko/lua-language-server
                      -- Unzip release and add bin dir to path
  -- 'texlab',           -- https://github.com/latex-lsp/texlab
  --                     -- Run `cargo install texlab`
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
  }
end

lspconfig.sumneko_lua.setup({
  settings = { Lua = { diagnostics = { globals = {'vim'} } } }
})

vim.opt.completeopt = {'menuone', 'noselect'}

vim.g.python3_host_prog = '/usr/bin/python3'

vim.g.material_theme_style = 'ocean'
vim.cmd('colorscheme material')
vim.o.termguicolors = true

vim.o.relativenumber = true     -- display relative line numbers
vim.o.wrap = false              -- disable line wrapping
vim.o.cursorline = true         -- highlight current line

vim.o.scrolloff = 4             -- show rows around cursor
vim.o.sidescrolloff = 12        -- show columns around cursor

vim.o.mouse = 'a'               -- enable mouse interaction
vim.o.splitbelow = true         -- default horizontal splits below
vim.o.splitright = true         -- default vertical splits right

vim.o.ignorecase = true         -- ignore case when finding
vim.o.smartcase = true          -- except if query contains a capital letter

vim.o.tabstop = 4               -- set tab width to 4 spaces
vim.o.shiftwidth = 4            -- set indent width to 4 spaces
vim.o.expandtab = true          -- insert spaces instead of tabs

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'cpp',
  callback = function()
    vim.keymap.set('n', '<buffer> <leader>r', ":!g++ '%:p' -o '%:p:r' && '%:p:r'<CR>")
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.keymap.set('n', '<buffer> <leader>r', ":!python3 '%:p'<CR>")
  end
})
