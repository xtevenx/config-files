local border_style
if vim.g.neovide then
    border_style = ''
else
    border_style = 'curved'
end

require('toggleterm').setup {
    open_mapping = '<leader>T', -- KEYMAP!
    direction = 'float',
    float_opts = { border = border_style },
}
