local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Auto-completion
  use 'neovim/nvim-lspconfig'

  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/nvim-cmp'

  use 'onsails/lspkind.nvim'

  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  -- [Bonus] Snippet Database
  use 'rafamadriz/friendly-snippets'

  -- Syntax Highlighting
  use {'nvim-treesitter/nvim-treesitter', run = 'TSUpdate'}
  use 'p00f/nvim-ts-rainbow'

  -- Indent Style Guessing
  use {
    'NMAC427/guess-indent.nvim',
    config = function() require('guess-indent').setup {} end,
  }

  -- Auto Pairing
  use {
    'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup {} end,
  }

  -- Commenting
  use {
    'numToStr/Comment.nvim',
    config = function() require('Comment').setup {
      toggler = { line = '<leader>c<space>' },
      opleader = { line = '<leader>c' },
    } end,
  }

  -- Terminal Manager
  use {
    'akinsho/toggleterm.nvim',
    config = function() require('toggleterm').setup {
      open_mapping = '<C-j>',
      direction = 'float',
      float_opts = { border = 'curved' },
    } end,
  }

  -- File Explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  -- Buffer Line
  use {
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
  }

  -- Status Line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  -- Color Scheme
  use 'ful1e5/onedark.nvim'
  use { 'navarasu/onedark.vim', disable = true }  -- slow performance

  -- Indentation Guides
  use 'lukas-reineke/indent-blankline.nvim'

  -- Smooth Scrolling
  use {
    'declancm/cinnamon.nvim',
    config = function() require('cinnamon').setup {
      default_keymaps = true,
      default_delay = 8,
    } end,
  }

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