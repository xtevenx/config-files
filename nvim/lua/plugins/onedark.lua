require('onedark').setup {
  dark_float = true,
  sidebars = { 'aerial', 'packer', 'Trouble' }
}

vim.o.background = 'dark'
vim.o.termguicolors = true

-- plugins/indent-blankline.lua
vim.api.nvim_set_hl(0, 'IndentBlanklineContextChar', { fg = '#5c6370', nocombine = true })
