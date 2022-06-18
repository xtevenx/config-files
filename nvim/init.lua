require('plugins')
require('impatient')
require('user.alpha')
require('user.keymaps')
require('user.null-ls')
require('user.nvim-cmp')
require('user.other')


-- Basic Neovim Configurations

vim.g.python3_host_prog = '/usr/bin/python3'

vim.g.tex_flavor = 'latex'

vim.o.number = true             -- Display line numbers
vim.o.relativenumber = true     -- Display relative line numbers
vim.o.wrap = false              -- Disable line wrapping
vim.o.cursorline = true         -- Highlight current line

vim.o.scrolloff = 4             -- Show rows around cursor
vim.o.sidescrolloff = 8         -- Show columns around cursor

vim.o.mouse = 'a'               -- Enable mouse interaction
vim.o.splitbelow = true         -- Default horizontal splits below
vim.o.splitright = true         -- Default vertical splits right

vim.o.ignorecase = true         -- Ignore case when finding
vim.o.smartcase = true          -- Except if query contains a capital letter

vim.o.tabstop = 4               -- Set tab width to 4 spaces
vim.o.shiftwidth = 4            -- Set indent width to 4 spaces
vim.o.expandtab = true          -- Insert spaces instead of tabs

vim.o.cmdheight = 0             -- Disable command line if not in use

vim.o.undofile = true           -- Use an undo file

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
