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
set wildmenu
set wildmode=full
set hlsearch
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

syntax on
filetype on
au BufNewFile,BufRead *.scss set filetype=css
au BufRead,BufNewFile *.go set filetype=go

map <C-p> :w<CR>:!/usr/bin/php -l %<CR>
" map <C-u> :w<CR>:!~/bin/phpu %<CR>

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

nnoremap <silent> <F10> :%s/$//g<CR>:%s// /g<CR>
command! FIXMACLINES <ESC>:%s/^M/\r/g
let php_sql_query=1                                                                                        
let php_htmlInStrings=1

vmap gl :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
