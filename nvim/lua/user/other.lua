-- LuaSnip
require('luasnip/loaders/from_vscode').lazy_load()

-- nvim-treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = 'all',
  sync_install = false,
  highlight = { enable = true },
  rainbow = { enable = true },
}

-- toggleterm
local commands = {
  c = 'gcc "%:p" -o "%:p:r" && "%:p:r"',
  cpp = 'g++ "%:p" -o "%:p:r" && "%:p:r"',
  python = 'python3 "%:p"',
  rust = 'cargo run',
} -- Can only use double quotes inside the command.

for ft, cmd in pairs(commands) do
  vim.api.nvim_create_autocmd('FileType', {
    pattern = ft,
    callback = function()
      vim.keymap.set('n', '<leader>r', ":TermExec cmd='" .. cmd .. "'<CR>")
    end,
  })
end

-- nvim-tree
local function aerial_split(_)
  require('nvim-tree.actions').on_keypress('split')
  require('aerial').close_all()
  require('aerial').open_all()
end

require('nvim-tree').setup {
  open_on_setup = true,
  ignore_buffer_on_setup = true,
  view = {
    width = 33, -- Same as aerial when 'no symbols' to display.
    mappings = {
      list = {
        { key = 's', action = 'aerial_split', action_cb = aerial_split }
      }
    }
  }
}

vim.keymap.set('n', '<C-h>', ':NvimTreeOpen<CR>')

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

vim.keymap.set('n', '<C-n>', ':BufferLineCycleNext<CR>')
vim.keymap.set('n', '<C-m>', ':BufferLineCyclePrev<CR>')

-- Lualine
require('lualine').setup {
  options = { disabled_filetypes = { 'packer' } },
  sections = { lualine_c = { 'filename', 'aerial' } },
  extensions = { 'aerial', 'nvim-tree', 'toggleterm' },
}

vim.o.showmode = false

-- One Dark
require('onedark').setup {
  dark_float = true,
  sidebars = { 'aerial', 'packer' }
}
vim.o.background = 'dark'
vim.o.termguicolors = true

-- indent-blankline
require('indent_blankline').setup {
  show_current_context = true,
}

vim.cmd('highlight IndentBlanklineContextChar guifg=#5c6370 gui=nocombine')
