require('plugins')
require('impatient')
require('user.nvim-cmp')
require('user.other')


-- Basic NeoVim Configurations

vim.g.python3_host_prog = '/usr/bin/python3'

vim.o.number = true             -- Display line numbers
vim.o.relativenumber = true     -- Display relative line numbers
vim.o.wrap = false              -- Disable line wrapping
vim.o.cursorline = true         -- Highlight current line

vim.o.scrolloff = 4             -- Show rows around cursor
vim.o.sidescrolloff = 12        -- Show columns around cursor

vim.o.mouse = 'a'               -- Enable mouse interaction
vim.o.splitbelow = true         -- Default horizontal splits below
vim.o.splitright = true         -- Default vertical splits right

vim.o.ignorecase = true         -- Ignore case when finding
vim.o.smartcase = true          -- Except if query contains a capital letter

vim.o.tabstop = 4               -- Set tab width to 4 spaces
vim.o.shiftwidth = 4            -- Set indent width to 4 spaces
vim.o.expandtab = true          -- Insert spaces instead of tabs

vim.keymap.set('n', '<leader>w', ':bprevious | bdelete #<CR>')
