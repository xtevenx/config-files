require('nvim-tree').setup {
   actions = {
      open_file = { quit_on_open = true },
   },
   view = {
      mappings = {
         list = {
            { key = 's', action = 'vsplit' },
         },
      },
   },
}
