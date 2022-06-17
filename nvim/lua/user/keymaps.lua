vim.o.timeoutlen = 600          -- Key mapping timeout

-- This file contains *almost* all the custom keybinds.
-- Some exceptions are:
-- - Comment toggle (plugins.lua)
-- - ToggleTerm (plugins.lua)

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { noremap = true })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { noremap = true })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { noremap = true })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { noremap = true })

vim.keymap.set('n', '<leader>w', ':bprevious | bdelete #<CR>')
vim.keymap.set('n', '<leader>f', ':lua vim.lsp.buf.format({ bufnr = 0 })<CR>')

vim.keymap.set('n', '<leader>sb', ":lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>")
vim.keymap.set('n', '<leader>sf', ":lua require('telescope.builtin').find_files()<CR>")
vim.keymap.set('n', '<leader>sg', ":lua require('telescope.builtin').live_grep()<CR>")
vim.keymap.set('n', '<leader>st', ":lua require('telescope.builtin').treesitter()<CR>")

vim.keymap.set('n', '<leader>e', ':NvimTreeOpen<CR>')

vim.keymap.set('n', '<C-n>', ':BufferLineCycleNext<CR>')
vim.keymap.set('n', '<C-m>', ':BufferLineCyclePrev<CR>')

vim.keymap.set('n', '<leader>d', ':Trouble<CR>')
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    if vim.api.nvim_buf_get_option(0, 'filetype') ~= 'Trouble' then
      vim.cmd('TroubleClose')
    end
  end,
})

-- Terminal Commands
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
