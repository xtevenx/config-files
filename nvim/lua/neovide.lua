-- Neovide configurations
vim.o.guifont = 'CaskaydiaCove NF:h12'
vim.g.neovide_cursor_animation_length = 0.06
vim.g.neovide_cursor_trail_length = 0.4

-- Make ctrl-v work properly for pasting
vim.keymap.set({ 'i', 'c' }, '<C-v>', '<C-r>+', { noremap = true })

-- Set basic terminal colors properly for the catppuccin color theme
vim.g.terminal_color_0 = '#45474a'
vim.g.terminal_color_1 = '#f38ba8'
vim.g.terminal_color_2 = '#a6e3a1'
vim.g.terminal_color_3 = '#f9e2af'
vim.g.terminal_color_4 = '#89b4fa'
vim.g.terminal_color_5 = '#f5c2e7'
vim.g.terminal_color_6 = '#94e2d5'
vim.g.terminal_color_7 = '#bac2de'
vim.g.terminal_color_8 = '#585b70'
vim.g.terminal_color_9 = '#f38ba8'
vim.g.terminal_color_10 = '#a6e3a1'
vim.g.terminal_color_11 = '#f9e2af'
vim.g.terminal_color_12 = '#89b4fa'
vim.g.terminal_color_13 = '#f5c2e7'
vim.g.terminal_color_14 = '#94e2d5'
vim.g.terminal_color_15 = '#a6adc8'
