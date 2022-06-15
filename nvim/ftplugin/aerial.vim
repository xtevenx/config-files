lua vim.api.nvim_buf_set_keymap(0, 'n', '<tab>', "<cmd>lua require('aerial').select({ jump = false })<CR>", {})
