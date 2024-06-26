require('loader')

require('keymaps')
require('options')

if vim.g.neovide then
   require('neovide')
end

require('plugins.alpha')
require('plugins.lualine')
require('plugins.null-ls')
require('plugins.nvim-cmp')
require('plugins.nvim-tree')
require('plugins.toggleterm')
