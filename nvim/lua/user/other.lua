-- LuaSnip
require('luasnip/loaders/from_vscode').lazy_load()

-- nvim-treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = 'all',
  sync_install = false,
  highlight = { enable = true },
  rainbow = { enable = true },
}

-- telescope.nvim
require('telescope').setup()
require('telescope').load_extension('fzy_native')

-- nvim-tree.lua
require('nvim-tree').setup {
  view = {
    mappings = {
      list = {
        { key = 's', action = 'vsplit' },
      },
    },
  },
}

-- bufferline.nvim
require('bufferline').setup {
  options = {
    separator_style = 'padded_slant',
    offsets = {
      { filetype = 'NvimTree', text = 'File Explorer' },
    }
  }
}

-- Lualine.nvim
local trouble_extension = {
  sections = {
    lualine_a = { function() return 'Trouble' end },
  },
  filetypes = { 'Trouble' },
}
require('lualine').setup {
  options = {
    disabled_filetypes = { 'packer' },
  },
  sections = {
    lualine_c = { 'filename', 'aerial' },
  },
  extensions = { 'aerial', 'nvim-tree', 'toggleterm', trouble_extension },
}

vim.o.showmode = false

-- onedark.nvim
require('onedark').setup {
  dark_float = true,
  sidebars = { 'aerial', 'packer', 'Trouble' }
}
vim.o.background = 'dark'
vim.o.termguicolors = true

-- indent-blankline.nvim
require('indent_blankline').setup {
  show_current_context = true,
}

vim.cmd('highlight IndentBlanklineContextChar guifg=#5c6370 gui=nocombine')


-- Miscellaneous

vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    local close = {
      ['aerial'] = 'AerialCloseAll',
      ['NvimTree'] = 'NvimTreeClose',
      ['Trouble'] = 'TroubleClose',
    }
    local buft = vim.api.nvim_buf_get_option(0, 'filetype')
    for ft, cmd in pairs(close) do
      if buft ~= ft then
        vim.cmd(cmd)
      end
    end
  end,
})
