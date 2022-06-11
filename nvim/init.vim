let g:python3_host_prog = '/usr/bin/python3'

lua require('plugins')


set completeopt=menu,menuone,noselect

lua << EOF
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
          local entry = cmp.get_selected_entry()
          if not entry then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
          else
            cmp.confirm()
          end
        else
          fallback()
        end
      end),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = {
      { name = 'buffer' },
      { name = 'nvim_lsp' },
      { name = 'path' },
      { name = 'vsnip' },
    },
    formatting = {
      format = require('lspkind').cmp_format(),
    },
  })

  local servers = { 'rust_analyzer' }

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  local lspconfig = require('lspconfig')
  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      capabilities = capabilities,
    }
  end
EOF


" material theme plugin
let g:material_theme_style = 'ocean'
if (has('termguicolors'))
    set termguicolors
endif


" basic options
colorscheme material

set number          " enable line numbers
set relativenumber  " use relative line numbers
set nowrap          " disable line wrapping
set cursorline      " highlight the current line

set scrolloff=3     " show rows around cursor
set sidescrolloff=8 " show columns around cursor

set mouse=a         " enable mouse selection
set splitbelow      " default horizontal split below
set splitright      " default vertical split right

set ignorecase      " ignore case when finding
set smartcase       " except if it contains an upper-case letter

set tabstop=4       " set tab width to 4 spaces
set shiftwidth=4    " set indent width to 4 spaces
set expandtab       " insert spaces instead of tabs


" auto-run commands
autocmd FileType cpp	nnoremap <buffer> <leader>r :!g++ '%:p' -o '%:p:r' && '%:p:r'<CR>
autocmd FileType python nnoremap <buffer> <leader>r: :!python3 '%:p'<CR>
