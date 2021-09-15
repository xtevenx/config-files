set nocompatible    " disable vi compatible mode for scripting to work properly


" install plugins (with vim-plug) ============================================
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.vim/plugged/')

" Syntax/Autocomplete Plugins ================================================

" delimitmate configurations --------------------------------------------------
Plug 'raimondi/delimitmate'
" Auto-close enclosing punctuation (braces, etc).

" vim-polyglot configurations ------------------------------------------------
Plug 'sheerun/vim-polyglot'
" Syntax highlighting for most languages.

" YouCompleteMe configurations -----------------------------------------------
Plug 'ycm-core/YouCompleteMe'
" Heavy but robust auto-complete engine.

" Integration Plugins ========================================================

" vim-gitgutter configurations -----------------------------------------------
Plug 'airblade/vim-gitgutter'
" Show git diff markers in margin.

" vimtex configurations ------------------------------------------------------
Plug 'lervag/vimtex'
" TeX language auto-complete and stuff.

let g:tex_flavor = 'latex'

if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif

au VimEnter * let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme

" disable viewer options
let g:vimtex_view_automatic=0
let g:vimtex_view_general_viewer='echo'

" Display Plugins ============================================================

" indentLine configurations --------------------------------------------------
Plug 'Yggdroot/indentLine'
" Indentation markers for large code folds.

" indentLine screws with TeX file display.
autocmd BufNewFile,BufRead *.tex IndentLinesDisable

" material.vim configurations ------------------------------------------------
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
" Material Design based color scheme.

"let g:material_terminal_italics = 1
let g:material_theme_style = 'ocean'

if (has('termguicolors'))
    set termguicolors
endif

" Miscellaneous Plugins ======================================================

" comfortable-motion.vim configurations --------------------------------------
Plug 'yuttie/comfortable-motion.vim'
" Smooth scrolling in vim.

" for 42 row vim window (laptop).
"nnoremap <silent> <C-j> :call comfortable_motion#flick( 144)<CR>
"nnoremap <silent> <C-k> :call comfortable_motion#flick(-144)<CR>

" for 52 row vim window (desktop).
nnoremap <silent> <C-j> :call comfortable_motion#flick( 170)<CR>
nnoremap <silent> <C-k> :call comfortable_motion#flick(-170)<CR>

" nerdcommenter configurations -----------------------------------------------
Plug 'preservim/nerdcommenter'
" Indentation commands.

let g:NERDDefaultAlign = 'left'  " don't follow indents with comment delimeters
let g:NERDCommentEmptyLines = 1  " comment empty lines when commenting many lines

" nerdtree configurations ----------------------------------------------------
Plug 'preservim/nerdtree'
" Integrated ide-like file browser.

nnoremap <C-n> :NERDTreeToggle<CR>

" close vim if nerdtree is the last window open.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" promptline configurations --------------------------------------------------
" invoke `promptline': PromptlineSnapshot ~/.promptline.sh airline
Plug 'edkolev/promptline.vim'
" Shell prompt based off current vim-airline theme.

" vim-airline configurations -------------------------------------------------
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Customizable status line with more information.

let g:airline_powerline_fonts=1
let g:airline_theme='material'
let g:airline#extensions#whitespace#enabled=0

" vim-devicons configurations ------------------------------------------------
Plug 'ryanoasis/vim-devicons'
" Fancy icons for NERDTree and vim-airline.

call plug#end()


" appearance options
syntax on
set background=dark
colorscheme material

set number          " enable line numbers
set relativenumber  " show relative line numbers on non-active lines
set nowrap          " disable line wrapping
set cursorline      " enable line highligting on cursor

set encoding=utf8   " use utf-8 encoding (unicode support)

set scrolloff=3     " number of lines to view around the cursor
set sidescrolloff=8 " number of columns to view around the cursor

set ruler           " always display the cursor
set laststatus=2    " always display the status bar
set noshowmode      " don't show mode information b/c it's shown in lightline.

set mouse=a         " enable mouse use
set splitbelow      " split horizontal windows at the bottom.
set splitright      " split vertical windows on the right.

" code indent options
set autoindent              " enable auto-indent
set expandtab               " convert tabs to spaces
filetype plugin on          " enable file-type specific plugins
filetype indent on          " enable file-type specific indentation rules

set shiftwidth=4            " number of spaces to use when shifting
set shiftround              " round to the nearest `shiftwidth` spaces when shifting

set tabstop=4               " number of spaces to use when tabbing
set smarttab                " use `tabstop` number of spaces when tabbing

" search options
set hlsearch    " highlight all occurances when searching
set ignorecase  " ignore case when searching
set smartcase   " enable case-sensitive search if query includes upper-case letter

" typesetting options
set spelllang=en
autocmd BufNewFile,BufRead *.tex set spell

" miscellaneous options
set backspace=indent,eol,start  " allow backspace over everything
set confirm                     " confirm before closing unsaved file

set undolevels=1042665      " Save a virtually unlimited amount of undos.
                            " `undolevels` is humorously set to the number of commits on the
                            " official linux git repository at the time of editing.
set undofile                " enable undo-persistance (after file close)

" create undo directory if it doesn't yet exist
let &undodir=expand('~/.vim/undodir')
if !isdirectory(&undodir)
    call mkdir(&undodir, 'p')
endif

" extra plugin configurations.
let g:promptline_preset = {
    \'c' : [ promptline#slices#cwd({ 'dir_limit': 2 }) ],
    \'x' : [ promptline#slices#git_status() ],
    \'warn' : [ promptline#slices#last_exit_code() ]}
