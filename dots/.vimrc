set clipboard+=unnamedplus   " Sets clipboard to use system's board
set mouse=v             " Middle-click paste with mouse
set ignorecase          " Case insensitive matching
"set expandtab           " Converts tabs to spaces 
set tabstop=4           " Number of columns occupied by a tab
"set foldmethod=indent   " Automatically set to indention folding.  Thank the Lord
set softtabstop=4       " Number of spaces in tab when editing
set shiftwidth=4        " When indenting with '>', use 2 spaces
set number              " Display line numbers on left margin
set relativenumber      " Display relative line numbers
syntax enable           " Enable syntax processing. Pairs with the 'set hlsearch' option
set cursorline          " Highlight current line
set hlsearch            " Highlights search matches
set wildmenu            " Visual autocomplete for command menu, use Tab to display commands
set showmatch           " Shows matching character for parenthesis-like characters
set nobackup            " Stops backup files. Same name as orig with '~' added
map <F2> :NERDTreeToggle<CR> 
" ^^ Set NerdTree to F2 key

autocmd BufEnter *.py set ai sw=4 ts=4 sta et fo=croql		" Set tabs to spaces for Python programs
autocmd FileType css set omnifunc=csscomplete#CompleteCSS " Enable autocomplete for CSS

if has('win32') " Commands to use if on windows
        set guifont=@SimSun-ExtB:h14
        set guioptions+=a       " Selecting text copies to clipboard for Windows (GVIM)
endif

let g:airline_powerline_fonts=1  "air-line setup

if !exists('g:airline_symbols')  "air-line setup
        let g:airline_symbols={}
endif

" Vim-plug setup
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

" List of Plugins declared here
Plug 'scrooloose/nerdtree'  
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mattn/emmet-vim'
Plug 'beautify-web/js-beautify'
Plug 'airblade/vim-gitgutter'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color' " Colors rgb, hex values in-line
Plug 'posva/vim-vue' "Add Vue.JS syntax
Plug 'mxw/vim-jsx' "Add JSX syntax
Plug 'pangloss/vim-javascript' "JS syntax and indention support
Plug 'isRuslan/vim-es6' " Adds ES6 syntax support
" End Vim-plug setup
call plug#end()

colorscheme dracula" Sets color scheme to Dracula
