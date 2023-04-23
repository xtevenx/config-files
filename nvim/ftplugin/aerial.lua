vim.keymap.set('n', '<tab>', function() require('aerial').select({ jump = false }) end, { buffer = true })
