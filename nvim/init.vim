let g:python3_host_prog = '/usr/bin/python3'

lua require('plugins')


" material theme plugin
let g:material_theme_style = 'ocean'
if (has('termguicolors'))
    set termguicolors
endif


" basic options
colorscheme material

set number          " enable line numbers
set relativenumber  " use relative line numbers
set nowrap          " disable line wrapping
set cursorline      " highlight the current line

set scrolloff=3     " show rows around cursor
set sidescrolloff=8 " show columns around cursor

set mouse=a         " enable mouse selection
set splitbelow      " default horizontal split below
set splitright      " default vertical split right

set ignorecase      " ignore case when finding
set smartcase       " except if it contains an upper-case letter

set tabstop=4       " set tab width to 4 spaces
set shiftwidth=4    " set indent width to 4 spaces
set expandtab       " insert spaces instead of tabs


" auto-run commands
autocmd FileType cpp	nnoremap <buffer> <leader>r :!g++ '%:p' -o '%:p:r' && '%:p:r'<CR>
autocmd FileType python nnoremap <buffer> <leader>r: :!python3 '%:p'<CR>
