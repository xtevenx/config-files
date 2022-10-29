require('aerial').setup {
  backends = { 'treesitter', 'lsp', 'markdown', 'man' },
  layout = { min_width = 30 },
  close_on_select = true,
}
