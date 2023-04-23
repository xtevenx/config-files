local trouble_extension = {
   filetypes = { 'Trouble' },
   sections = {
      lualine_a = { function() return 'Trouble' end },
   },
}

require('lualine').setup {
   options = { theme = 'catppuccin' },
   extensions = { 'aerial', 'nvim-tree', 'toggleterm', trouble_extension },
   sections = {
      lualine_c = { 'filename', 'aerial' },
   },
}

vim.o.laststatus = 3
vim.o.showmode = false
