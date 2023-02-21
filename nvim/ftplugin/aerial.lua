vim.keymap.set('n', '<tab>', "<cmd>lua require('aerial').select({ jump = false })<CR>", { buffer = true })
