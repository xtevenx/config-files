return {
   {
      'catppuccin/nvim',
      name = 'catppuccin',
      lazy = false,
      priority = 1000,
      config = function ()
         vim.o.background = 'dark'
         vim.o.termguicolors = true
         vim.g.catppuccin_flavour = 'mocha'
         require('catppuccin').setup {
             styles = {
                 comments = { 'italic' },
                 conditionals = { 'italic' },
                 loops = { 'italic' },
                 keywords = { 'italic' },
                 booleans = { 'italic' },
                 types = { 'italic' },
             },
             integrations = {
                 lsp_trouble = true,
                 aerial = true,
             }
         }

         vim.cmd [[colorscheme catppuccin]]

         -- plugins/indent-blankline.lua
         vim.api.nvim_set_hl(0, 'IndentBlanklineContextChar', { fg = '#7f849c', nocombine = true })
      end
   }
}
