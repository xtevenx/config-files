-- LuaSnip
require('luasnip/loaders/from_vscode').lazy_load()

-- nvim-treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = 'all',
  sync_install = false,
  highlight = { enable = true },
  rainbow = { enable = true },
}

-- nvim-tree
require('nvim-tree').setup {
  open_on_setup = true,
  ignore_buffer_on_setup = true,
  view = {
    width = 33, -- Same as aerial when 'no symbols' to display.
    mappings = {
      list = {
        { key = 's', action = 'split' },
      },
    },
  },
}

vim.api.nvim_create_autocmd('BufEnter', {
  nested = true,
  callback = function()
    local ignore = { ['NvimTree'] = true, ['aerial'] = true }
    local wins = vim.api.nvim_list_wins()
    local close = true
    for _, win in ipairs(wins) do
      local buf = vim.api.nvim_win_get_buf(win)
      local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
      if ignore[ft] == nil then
        close = false
        break
      end
    end
    if close then
      vim.cmd('qall!')
    end
  end
})

-- bufferline
require('bufferline').setup {
  options = {
    separator_style = 'padded_slant',
    offsets = {
      { filetype = 'NvimTree', text = 'File Explorer' },
    }
  }
}

-- Lualine
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

-- One Dark
require('onedark').setup {
  dark_float = true,
  sidebars = { 'aerial', 'packer', 'Trouble' }
}
vim.o.background = 'dark'
vim.o.termguicolors = true

-- indent-blankline
require('indent_blankline').setup {
  show_current_context = true,
}

vim.cmd('highlight IndentBlanklineContextChar guifg=#5c6370 gui=nocombine')
