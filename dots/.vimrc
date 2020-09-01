set clipboard+=unnamedplus   " Sets clipboard to use system's board (Linux)
set mouse=v             " Middle-click paste with mouse
set ignorecase          " Case insensitive matching
set tabstop=4           " Number of columns occupied by a tab
set softtabstop=4       " Number of spaces in tab when editing
set shiftwidth=4        " When indenting with '>', use 4 spaces
set number              " Display line numbers on left margin
set relativenumber      " Display relative line numbers
set cursorline          " Highlight current line
set hlsearch            " Highlights search matches
set wildmenu            " Visual autocomplete for command menu, use Tab to display commands
set showmatch           " Shows matching character for parenthesis-like characters
set nobackup            " Stops backup files. Same name as orig with '~' added

autocmd BufEnter *.tf set ai sw=2 ts=2 sta et fo=croql

nnoremap <F5> :call SetLineNumbering()<CR>
function! SetLineNumbering()
	if &relativenumber
		setlocal norelativenumber
		setlocal nonumber
	else
		setlocal relativenumber
		setlocal number
	endif
endfunction

let uname = substitute(system('uname'), '\n', '', '')
" Example values: Linux, Darwin, MINGW64_NT-10.0, MINGW32_NT-6.1

if uname == 'Linux' || uname == 'Darwin'
    " do linux/mac command
	set clipboard=unnamed
else " windows
    " do windows command
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
" List of Plugins below
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mattn/emmet-vim'
Plug 'beautify-web/js-beautify'
Plug 'airblade/vim-gitgutter'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color' " Colors rgb, hex values in-line
Plug 'posva/vim-vue' " Add Vue.JS syntax
Plug 'mxw/vim-jsx' " Add JSX syntax
Plug 'pangloss/vim-javascript' " JS syntax and indention support
Plug 'isRuslan/vim-es6' " Adds ES6 syntax support
Plug 'dracula/vim', { 'as': 'dracula' }
" End Vim-plug plugins
call plug#end()

colorscheme dracula " Sets color scheme to Dracula
