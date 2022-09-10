-- plugins/cinnamon.lua
require('cinnamon').setup { default_keymaps = true, default_delay = 1 }

-- plugins/indent-blankline.lua
require('indent_blankline').setup { show_current_context = true }

-- plugins/LuaSnip.lua
require('luasnip/loaders/from_vscode').lazy_load()

-- plugins/telescope.lua
require('telescope').setup()
require('telescope').load_extension('fzy_native')

-- plugins/nvim-colorizer.lua
require('colorizer').setup()
