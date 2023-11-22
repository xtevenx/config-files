local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
   vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      lazypath,
   }
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
   'neovim/nvim-lspconfig',

   {
      'hrsh7th/nvim-cmp',
      lazy = true, -- setup in plugins/nvim-cmp.lua
      dependencies = {
         'hrsh7th/cmp-nvim-lsp',
         'hrsh7th/cmp-path',
         'L3MON4D3/LuaSnip',
         'saadparwaiz1/cmp_luasnip',
         'onsails/lspkind.nvim',
      },
   },

   -- Other Tools and LSP Integration
   {
      'jose-elias-alvarez/null-ls.nvim',
      lazy = true, -- setup in plugins/null-ls.lua
      dependencies = { 'nvim-lua/plenary.nvim' },
   },

   -- Syntax Highlighting
   {
      'nvim-treesitter/nvim-treesitter',
      lazy = false,
      priority = 100,
      config = function()
         require('nvim-treesitter.configs').setup {
            ensure_installed = 'all',
            highlight = { enable = true },
            sync_install = false,
         }
      end,
   },

   -- Indent Style Guessing
   { 'NMAC427/guess-indent.nvim', lazy = false },

   -- Auto Pairing
   { 'windwp/nvim-autopairs',     lazy = false },

   -- Commenting
   {
      'numToStr/Comment.nvim',
      lazy = false,
      config = function()
         require('Comment').setup {
            toggler = { line = '<leader>c<space>' }, -- KEYMAP!
            opleader = { line = '<leader>c' },       -- KEYMAP!
         }
      end,
   },

   -- Git Integration
   { 'lewis6991/gitsigns.nvim', lazy = false },

   -- Fuzzy Finder
   {
      'nvim-telescope/telescope.nvim',
      lazy = true,
      config = function()
         require('telescope').setup()
         require('telescope').load_extension('fzy_native')
      end,
      dependencies = {
         'nvim-lua/plenary.nvim',
         'nvim-telescope/telescope-fzy-native.nvim',
      },
   },

   -- Terminal Manager
   { 'akinsho/toggleterm.nvim', lazy = true }, -- setup in plugins/toggleterm.lua

   -- File Explorer
   {
      'nvim-tree/nvim-tree.lua',
      lazy = true, -- setup in plugins/nvim-tree.lua
      dependencies = { 'nvim-tree/nvim-web-devicons' },
   },

   -- Code Outline
   {
      'stevearc/aerial.nvim',
      lazy = true,
      config = function()
         require('aerial').setup {
            backends = { 'treesitter', 'lsp', 'markdown', 'man' },
            layout = { min_width = 30 },
            close_on_select = true,
         }
      end,
   },

   -- Diagnostics Summary
   {
      'folke/trouble.nvim',
      keys = {
         { '<leader>d', '<cmd>TroubleToggle<CR>' }, -- KEYMAP!
      },
      dependencies = { 'nvim-tree/nvim-web-devicons' },
   },

   -- Buffer Line
   {
      'akinsho/bufferline.nvim',
      lazy = false,
      config = function()
         require('bufferline').setup {
            options = {
               separator_style = 'padded_slant',
               offsets = {
                  { filetype = 'NvimTree', text = 'File Explorer' },
               }
            }
         }
      end,
      dependencies = { 'nvim-tree/nvim-web-devicons' },
   },

   -- Status Line
   {
      'nvim-lualine/lualine.nvim',
      lazy = true, -- setup in plugins/lualine.lua
      dependencies = { 'nvim-tree/nvim-web-devicons' },
   },

   -- Start Screen
   {
      'goolord/alpha-nvim',
      lazy = true, -- setup in plugins/alpha.lua
      dependencies = { 'nvim-tree/nvim-web-devicons' },
   },

   -- Color Highlighting
   { 'norcalli/nvim-colorizer.lua', lazy = false },

   -- Indentation Guides
   {
      'lukas-reineke/indent-blankline.nvim',
      lazy = false,
      opts = {},
      main = 'ibl',
   },

   -- Smooth Scrolling
   {
      'declancm/cinnamon.nvim',
      lazy = true, -- setup in plugins/cinnamon.lua IFF not in neovide.
   },
}

plugins = vim.list_extend(plugins, require('plugins.catppuccin'))

require('lazy').setup(plugins, {})
