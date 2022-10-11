set cursorline               " Highlight current line
set expandtab                " Converts tabs to spaces so that Git doesnt look terrible.
set hlsearch                 " Highlights search matches
set ignorecase               " Case insensitive matching
set listchars=tab:→\ ,eol:↲,space:␣,trail:•,extends:⟩,precedes:⟨
set nobackup                 " Stops backup files. Same name as orig with ~ added
set number                   " Display line numbers on left margin
set shiftwidth=2             " When indenting with >, use 4 spaces
set showmatch                " Shows matching character for parenthesis-like characters
set softtabstop=2            " Number of spaces in tab when editing
set tabstop=2                " Number of columns occupied by a tab

let mapleader=","

noremap <F5> :set list!<CR>
nnoremap <F6> :set number! <bar> :GitGutterToggle<CR>
vmap     <C-F>f <Plug>CtrlSFVwordPath
" Runs CtrlSF with , W
nnoremap <leader>W :CtrlSFVwordPath
" Search and replace text highlighted in Visual mode
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

"Enables Python syntax highlighting
let g:python_highlight_all=1
let g:python_highlight_builtins=1

"Explore mode default setting
let g:netrw_liststyle=1    

let uname = substitute(system('uname'),'\n','','')
" Example values: Linux, Darwin, MINGW64_NT-10.0, MINGW32_NT-6.1
if uname == 'Linux' || uname == 'Darwin'
  set clipboard=unnamed
endif

" air-line setup
let g:airline_powerline_fonts=1
if !exists('g:airline_symbols')
  let g:airline_symbols={}
endif

" Vim-plug setup
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
" Colors rgb, hex values in-line
Plug 'ap/vim-css-color' 
Plug 'beautify-web/js-beautify'
" Fuzzyfinder for files within vim
Plug 'ctrlpvim/ctrlp.vim'
" Fuzzyfinder for grep within vim
Plug 'dyng/ctrlsf.vim'
Plug 'franbach/miramare'
Plug 'hail2u/vim-css3-syntax'
" Adds ES6 syntax support
Plug 'isRuslan/vim-es6' 
" Add JSX syntax
Plug 'mxw/vim-jsx' 
" JS syntax and indention support
Plug 'pangloss/vim-javascript' 
Plug 'psliwka/vim-smoothie'
" Better syntax highlighting for lots of languages
Plug 'sheerun/vim-polyglot' 
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-python/python-syntax'
call plug#end()

" Sets color scheme
colorscheme miramare 
