local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
    'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path
  }
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Auto-completion
  use 'neovim/nvim-lspconfig'

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/nvim-cmp'

  use 'onsails/lspkind.nvim'

  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  -- Other Tools and LSP Integration
  use { 'jose-elias-alvarez/null-ls.nvim',
        requires = { 'nvim-lua/plenary.nvim' } }

  -- Syntax Highlighting
  use { 'nvim-treesitter/nvim-treesitter', run = 'TSUpdate' }
  use 'p00f/nvim-ts-rainbow'

  -- Indent Style Guessing
  use { 'NMAC427/guess-indent.nvim',
        config = function() require('guess-indent').setup() end }

  -- Auto Pairing
  use { 'windwp/nvim-autopairs',
        config = function() require('nvim-autopairs').setup() end }

  -- Commenting
  use 'numToStr/Comment.nvim'

  -- Git Integration
  use { 'lewis6991/gitsigns.nvim',
        config = function() require('gitsigns').setup() end }

  -- Fuzzy Finder
  use { 'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim',
                     'nvim-telescope/telescope-fzy-native.nvim' } }

  -- Terminal Manager
  use 'akinsho/toggleterm.nvim'

  -- File Explorer
  use { 'nvim-tree/nvim-tree.lua',
        requires = { 'nvim-tree/nvim-web-devicons' } }

  -- Code Outline
  use 'stevearc/aerial.nvim'

  -- Diagnostics Summary
  use { 'folke/trouble.nvim',
        config = function() require('trouble').setup() end,
        requires = { 'nvim-tree/nvim-web-devicons' } }

  -- Buffer Line
  use { 'akinsho/bufferline.nvim',
        requires = { 'nvim-tree/nvim-web-devicons' } }

  -- Status Line
  use { 'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons' } }

  -- Start Screen
  use { 'goolord/alpha-nvim',
        requires = { 'nvim-tree/nvim-web-devicons' } }

  -- Color Scheme
  use 'catppuccin/nvim'

  -- Color Highlighting
  use { 'norcalli/nvim-colorizer.lua' }

  -- Indentation Guides
  use 'lukas-reineke/indent-blankline.nvim'

  -- Smooth Scrolling
  use 'declancm/cinnamon.nvim'

  -- Keybind Helper
  use { 'folke/which-key.nvim',
        config = function() require('which-key').setup() end }

  -- Performance
  use 'nathom/filetype.nvim'
  use 'lewis6991/impatient.nvim'
  use { 'dstein64/vim-startuptime', disable = true }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
