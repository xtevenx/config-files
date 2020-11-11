set nocompatible    " disable vi compatible mode for scripting to work properly


" install plugins (with vim-plug) ============================================
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.vim/plugged/')

" papercolor-theme configurations --------------------------------------------
Plug 'NLKNguyen/papercolor-theme'

" onedark configurations -----------------------------------------------------
Plug 'joshdick/onedark.vim'

" YouCompleteMe configurations -----------------------------------------------
Plug 'ycm-core/YouCompleteMe'

" auto-pairs configurations --------------------------------------------------
Plug 'jiangmiao/auto-pairs'

" nerdcommenter configurations -----------------------------------------------
Plug 'preservim/nerdcommenter'
let g:NERDDefaultAlign = 'left'  " don't follow indents with comment delimeters
let g:NERDCommentEmptyLines = 1  " comment empty lines when commenting many lines

" vim-gitgutter configurations -----------------------------------------------
Plug 'airblade/vim-gitgutter'

" vimtex configurations ------------------------------------------------------
Plug 'lervag/vimtex'
let g:tex_flavor = 'latex'
let g:vimtex_view_automatic=0

if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif

au VimEnter * let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme

" nerdtree configurations ----------------------------------------------------
Plug 'preservim/nerdtree'
nnoremap <C-n> :NERDTreeToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vim-airline configurations -------------------------------------------------
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

let g:airline_powerline_fonts=1
let g:airline_theme='papercolor'
let g:airline#extensions#whitespace#enabled=0

" promptline configurations --------------------------------------------------
Plug 'edkolev/promptline.vim'
":PromptlineSnapshot ~/.promptline.sh

" vim-devicons configurations ------------------------------------------------
Plug 'ryanoasis/vim-devicons'

call plug#end()


" appearance options
syntax on
set background=dark
colorscheme PaperColor

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

" miscellaneous options
set backspace=indent,eol,start  " allow backspace over everything
set confirm                     " confirm before closing unsaved file

set undolevels=950324       " save a virtually unlimited amount of undos
                            " `undolevels` is humorously set to the number of commits on the official linux git
                            " repository at the time of editing
set undofile                " enable undo-persistance (after file close)

" create undo directory if it doesn't yet exist
let &undodir=expand('~/.vim/undodir')
if !isdirectory(&undodir)
    call mkdir(&undodir, 'p')
endif

