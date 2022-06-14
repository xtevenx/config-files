-- LuaSnip
require('luasnip/loaders/from_vscode').lazy_load {}

-- nvim-treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = 'all',
  sync_install = false,
  highlight = { enable = true },
  rainbow = { enable = true },
}

-- nvim-tree
require('nvim-tree').setup {
  view = {
    mappings = {
      list = {
        { key = 's', action = 'vsplit' }
      }
    }
  }
}

vim.keymap.set('n', '<C-h>', ':NvimTreeToggle<CR>')

-- bufferline
require('bufferline').setup {
  options = {
    offsets = {
      {
        filetype = 'NvimTree',
        text = 'File Explorer',
      }
    }
  }
}

vim.keymap.set('n', '<C-n>', ':BufferLineCycleNext<CR>')
vim.keymap.set('n', '<C-m>', ':BufferLineCyclePrev<CR>')

-- Lualine
require('lualine').setup {}
vim.o.showmode = false

-- One Dark
require('onedark').setup {}
vim.o.background = 'dark'
vim.o.termguicolors = true
