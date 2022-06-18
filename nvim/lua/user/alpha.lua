local dashboard = require('alpha.themes.dashboard')

-- Colors (from ful1e5/onedark.nvim)
local BLUE = 'Function'
local CYAN = 'PreProc'
local GREEN = 'String'
local PURPLE = 'Statement'
local RED = 'Identifier'

-- Modified from https://github.com/goolord/alpha-nvim
local function button(sc, txt, keybind, keybind_opts, opts_)
  local sc_ = sc:gsub('%s', ''):gsub('SPC', '<leader>')

  local opts = {
    position = 'center',
    shortcut = sc,
    cursor = 5,
    width = 50,
    align_shortcut = 'right',
    hl_shortcut = CYAN,
  }

  for k, v in pairs(opts_ or {}) do
    opts[k] = v
  end

  if keybind then
    keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
    opts.keymap = { 'n', sc_, keybind, keybind_opts }
  end

  local function on_press()
    local key = vim.api.nvim_replace_termcodes(sc_ .. '<Ignore>', true, false, true)
    vim.api.nvim_feedkeys(key, 't', false)
  end

  return {
    type = 'button',
    val = txt,
    on_press = on_press,
    opts = opts,
  }
end

-- Header
dashboard.section.header.val = {
  [[                              ______   __  _________   ]],
  [[                             /\__  _\ /\ \/\  ___  _\  ]],
  [[  ___      __    ___   __  __\/_/\ \/ \ \ `\\ \_/\ \/  ]],
  [[/' _ `\  /'__`\ / __`\/\ \/\ \  \ \ \  \ \ , ` \\ \ \  ]],
  [[/\ \/\ \/\  __//\ \L\ \ \ \_/ |  \_\ \__\ \ \`\ \\ \ \ ]],
  [[\ \_\ \_\ \____\ \____/\ \___/   /\_____\\ \_\ \_\\ \_\]],
  [[ \/_/\/_/\/____/\/___/  \/__/    \/_____/ \/_/\/_/ \/_/]],
}

dashboard.section.header.opts = { position = 'center', hl = PURPLE }

-- Buttons
dashboard.section.buttons.val = {
  button('e', 'ﱐ  New File', '<cmd>enew<CR>', nil, { hl = GREEN }),
  button('f', '  Find File', '<cmd>Telescope find_files<CR>', nil, { hl = BLUE }),
  button('q', '  Quit', '<cmd>qall!<CR>', nil, { hl = RED }),
}

-- Layout
local l_header = #dashboard.section.header.val
local l_buttons = #dashboard.section.buttons.val * 2 - 1
local l_footer = #dashboard.section.footer.val
local hb_padding = 2

local p_total = vim.o.lines - (l_header + l_buttons + l_footer) - hb_padding - 1
local bf_padding = 0
local hf_padding = (1 - bf_padding) / 2

dashboard.config.layout = {
  { type = 'padding', val = math.floor(p_total * hf_padding) },
  dashboard.section.header,
  { type = 'padding', val = hb_padding },
  dashboard.section.buttons,
  { type = 'padding', val = math.floor(p_total * bf_padding) },
  dashboard.section.footer,
}

-- Setup
require('alpha').setup(dashboard.opts)
