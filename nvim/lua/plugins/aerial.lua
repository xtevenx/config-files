require('aerial').setup {
  backends = { 'treesitter', 'lsp', 'markdown' },
  close_on_select = true,
  min_width = 30, -- Same as nvim-tree default width
}
