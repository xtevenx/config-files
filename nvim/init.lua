require('loader')

require('impatient')
require('keymaps')
require('options')

if vim.g.neovide then
    require('neovide')
else
    require('plugins.cinnamon')
end

require('plugins.aerial')
require('plugins.alpha')
require('plugins.bufferline')
require('plugins.catppuccin')
require('plugins.Comment')
require('plugins.lualine')
require('plugins.null-ls')
require('plugins.nvim-cmp')
require('plugins.nvim-tree')
require('plugins.nvim-treesitter')
require('plugins.others')
require('plugins.toggleterm')
require('plugins.trouble')
