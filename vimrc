syn on
set nocompatible
set number
set smartindent
set tabstop=4
set shiftwidth=4
set ruler
set formatoptions=tcqlron
"set fileencodings=utf-8,latin2
set so=999
set showcmd
set ignorecase
set smartcase
set nohidden
set showmatch
set autoread
set suffixes=.bak,~,.o,.h,.info,.swp,.class
set dir=/tmp/
set hlsearch
" Dat pesky wait between <esc>O and insert..
set timeout timeoutlen=1000 ttimeoutlen=100

execute pathogen#infect()

" Cool search plugin
let g:ctrlp_working_path_mode = '0'

syntax on
filetype on
au BufNewFile,BufRead *.scss set filetype=css
au BufRead,BufNewFile *.go set filetype=go

colorscheme jellybeans

autocmd FileType php map <C-c> :w<CR>:!/usr/bin/php -l %<CR>

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" Easy window resize
map L <C-w>>
map H <C-w><

vmap gl :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
