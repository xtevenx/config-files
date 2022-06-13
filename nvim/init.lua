require('plugins')

require('impatient')

require('nvim-cmp_setup')


-- LuaSnip

require('luasnip/loaders/from_vscode').lazy_load {}


-- nvim-treesitter

require('nvim-treesitter.configs').setup {
  ensure_installed = 'all',
  sync_install = false,
  highlight = { enable = true },
  rainbow = { enable = true },
}


-- nvim-tree

require('nvim-tree').setup {
  view = {
    mappings = {
      list = {
        { key = 's', action = 'vsplit' }
      }
    }
  }
}

vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>')


-- Lualine

require('lualine').setup {}
vim.o.showmode = false


-- One Dark

require('onedark').setup {}
vim.o.background = 'dark'
vim.o.termguicolors = true


-- Miscellaneous

vim.g.python3_host_prog = '/usr/bin/python3'

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

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'cpp',
  callback = function()
    vim.keymap.set('n', '<leader>r', ":!g++ '%:p' -o '%:p:r' && '%:p:r'<CR>")
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.keymap.set('n', '<leader>r', ":!python3 '%:p'<CR>")
  end
})
