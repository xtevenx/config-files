-- plugins/indent-blankline.lua
require('indent_blankline').setup { show_current_context = true }

-- plugins/telescope.lua
require('telescope').setup()
require('telescope').load_extension('fzy_native')

-- plugins/nvim-colorizer.lua
require('colorizer').setup()
