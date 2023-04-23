vim.o.timeoutlen = 600 -- Key mapping timeout

-- This file contains *almost* all the custom keybinds.
-- Exceptions commented with 'KEYMAP!' in:
-- * loader.lua
-- * plugins/toggleterm.lua

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { noremap = true })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { noremap = true })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { noremap = true })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { noremap = true })

vim.keymap.set('n', '<leader>w', '<cmd>bprevious | bdelete #<CR>')

vim.keymap.set('n', '<leader>sb', require('telescope.builtin').current_buffer_fuzzy_find)
vim.keymap.set('n', '<leader>sc', require('telescope.builtin').treesitter)
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files)
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep)

vim.keymap.set('n', '<leader>b', '<cmd>AerialToggle<CR>')
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>')

vim.keymap.set('n', '<C-n>', '<cmd>BufferLineCycleNext<CR>')
vim.keymap.set('n', '<C-m>', '<cmd>BufferLineCyclePrev<CR>')

-- Formatting commands
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)

local choose_nls = { 'c', 'cpp', 'javascript' }
for _, ft in ipairs(choose_nls) do
   vim.api.nvim_create_autocmd('FileType', {
      pattern = ft,
      callback = function()
         vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ name = 'null-ls' }) end, { buffer = true })
      end,
   })
end

-- Simple run commands
local commands = {
   c = 'gcc "%:p" -o "%:p:r" && "%:p:r"',
   cpp = 'g++ "%:p" -o "%:p:r" && "%:p:r"',
   python = 'python "%:p"',
   rust = 'cargo run',
} -- Can only use double quotes inside the commands.

for ft, cmd in pairs(commands) do
   vim.api.nvim_create_autocmd('FileType', {
      pattern = ft,
      callback = function()
         vim.keymap.set('n', '<leader>r', "<cmd>TermExec cmd='" .. cmd .. "'<CR>", { buffer = true })
      end,
   })
end
