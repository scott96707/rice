colo lucid
set clipboard+=unnamedplus   " Sets clipboard to use system's board
colo gruvbox
set mouse=v             " Middle-click paste with mouse
set ignorecase          " Case insensitive matching
set expandtab           " Converts tabs to white space 
set tabstop=4           " Number of columns occupied by a tab
"set foldmethod=indent   " Automatically set to indention folding.  Thank the Lord
set softtabstop=4       " Number of spaces in tab when editing
set shiftwidth=4        " When indenting with '>', use 2 spaces
set number              " Display line numbers on left margin
syntax enable           " Enable syntax processing. Pairs with the 'set hlsearch' option
set cursorline          " Highlight current line
set hlsearch            " Highlights search matches
set wildmenu            " Visual autocomplete for command menu, use Tab to display commands
set showmatch           " Shows matching character for parenthesis-like characters
set backup              " Keeps an automatic backup of this file. Same name as orig with '~' added
map <F2> :NERDTreeToggle<CR> 
" ^^ Set NerdTree to F2 key

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

" List of Plugins declared here
Plug 'scrooloose/nerdtree'  
Plug 'beautify-web/js-beautify'
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color' " Colors rgb, hex values in-line
" End Vim-plug setup
call plug#end()
colorscheme dracula" Sets color scheme to Dracula
