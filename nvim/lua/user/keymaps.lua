vim.o.timeoutlen = 600          -- Key mapping timeout

vim.keymap.set('n', '<leader>w', ':bprevious | bdelete #<CR>')
vim.keymap.set('n', '<leader>f', ':lua vim.lsp.buf.format({ bufnr = 0 })<CR>')

vim.keymap.set('n', '<C-h>', ':NvimTreeOpen<CR>')
vim.keymap.set('n', '<C-k>', ":lua require('aerial').close_all(); require('aerial').open_all()<CR>")
vim.keymap.set('n', '<C-n>', ':BufferLineCycleNext<CR>')
vim.keymap.set('n', '<C-m>', ':BufferLineCyclePrev<CR>')

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
