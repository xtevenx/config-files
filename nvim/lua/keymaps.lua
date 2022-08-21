vim.o.timeoutlen = 600 -- Key mapping timeout

-- This file contains *almost* all the custom keybinds.
-- Exceptions are at:
-- - plugins/Comment.lua
-- - plugins/others.lua

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { noremap = true })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { noremap = true })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { noremap = true })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { noremap = true })

vim.keymap.set('n', '<leader>w', '<cmd>bprevious | bdelete #<CR>')

vim.keymap.set('n', '<leader>sb', "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>")
vim.keymap.set('n', '<leader>sc', "<cmd>lua require('telescope.builtin').treesitter()<CR>")
vim.keymap.set('n', '<leader>sf', "<cmd>lua require('telescope.builtin').find_files()<CR>")
vim.keymap.set('n', '<leader>sg', "<cmd>lua require('telescope.builtin').live_grep()<CR>")

vim.keymap.set('n', '<leader>b', '<cmd>AerialToggle<CR>')
vim.keymap.set('n', '<leader>d', '<cmd>TroubleToggle<CR>')
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>')

vim.keymap.set('n', '<C-n>', '<cmd>BufferLineCycleNext<CR>')
vim.keymap.set('n', '<C-m>', '<cmd>BufferLineCyclePrev<CR>')

-- Formatting Commands
vim.keymap.set('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
-- vim.keymap.set('n', '<leader>f', '<cmd>lua vim.lsp.buf.format()<CR>')  -- v0.8+

local choose_nls = { 'c', 'cpp' }
for _, ft in ipairs(choose_nls) do
  vim.api.nvim_create_autocmd('FileType', {
    pattern = ft,
    callback = function()
      vim.keymap.set('n', '<leader>f', "<cmd>lua vim.lsp.buf.formatting({ name = 'null-ls' })<CR>", { buffer = true })
      -- vim.keymap.set('n', '<leader>f', "<cmd>lua vim.lsp.buf.format({ name = 'null-ls' })<CR>", { buffer = true })  -- v0.8+
    end,
  })
end

-- Simple Run Commands
local commands = {
  c = 'gcc "%:p" -o "%:p:r" && "%:p:r"',
  cpp = 'g++ "%:p" -o "%:p:r" && "%:p:r"',
  python = 'python3 "%:p"',
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
