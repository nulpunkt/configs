" Use Pathogen:
call pathogen#infect()

" Vundle

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle (required)!
Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/syntastic'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
Bundle 'shawncplus/phpcomplete.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'elzr/vim-json'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'tpope/vim-fireplace'
Bundle 'guns/vim-clojure-static'

" The usual suspects
syntax on
filetype plugin on
set nocompatible
set relativenumber
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
set clipboard=unnamed
" Dat pesky wait between <esc>O and insert..
set timeout timeoutlen=1000 ttimeoutlen=100
set wildmenu
set shellcmdflag=-ic

let mapleader=" "

" Cool search plugin
let g:ctrlp_working_path_mode = '0'

" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:syntastic_php_checkers=['php', 'phpcs']
let g:syntastic_php_phpcs_args = '--standard=PSR2'
let g:syntastic_javascript_checkers = ['jshint']

let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0

colorscheme jellybeans

set completeopt-=preview

au FileType php map <C-c> :w<CR>:!/usr/bin/php -l %<CR>
au FileType php set omnifunc=phpcomplete#CompletePHP
au BufWritePre *.php :%s/\s\+$//e

au Filetype html setlocal ts=2 | setlocal sts=2 | setlocal sw=2

au FileType ruby set omnifunc=rubycomplete#Complete
au Filetype ruby setlocal expandtab | setlocal ts=2 | setlocal sts=2 | setlocal sw=2

au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell

au Filetype clojure setlocal expandtab | setlocal ts=2 | setlocal sts=2 | setlocal sw=2
au VimEnter *.clj RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound

" Stuff for finding test files
nnoremap <Leader>au :vs <C-R>=substitute(substitute(expand("%:p"), "\/api", "\/api\/test/unit", ""), "\.php", "Test.php", "")<CR> <CR>
nnoremap <Leader>ai :vs <C-R>=substitute(substitute(expand("%:p"), "\/api", "\/api\/test/integration", ""), "\.php", "Test.php", "")<CR> <CR>
nnoremap <Leader>ad :vs <C-R>=substitute(substitute(expand("%:p"), "\/api", "\/api\/test/database", ""), "\.php", "Test.php", "")<CR> <CR>
nnoremap <Leader>cu :vs <C-R>=substitute(substitute(expand("%:p"), "\/colourbox", "\/colourbox\/tests/unit", ""), "\.php", "Test.php", "")<CR> <CR>
nnoremap <Leader>ci :vs <C-R>=substitute(substitute(expand("%:p"), "\/colourbox", "\/colourbox\/tests/integration", ""), "\.php", "Test.php", "")<CR> <CR>

" Make the directory the current file should reside in
nnoremap <Leader>m :!mkdir -p %:h<CR><CR>

" fix tmux's retarded \015 instead of line break
nnoremap <Leader>f :s/\\015/\r/g<CR>

set pastetoggle=<F11>

" Parenthesis are a pain
inoremap é (
inoremap ï )
inoremap ½ $

" Easy window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Easy new tab
nnoremap <Leader>t :tabnew<CR>

" Easy window resize
nnoremap L <C-w><
nnoremap H <C-w>>

" File in the current directory
nnoremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Transpose params
nnoremap <Leader>sp :normal F(ldt,f)i, pF(lxx

" Set spell
nnoremap <Leader>se :silent! set spell spelllang=en<CR>

" More natural moving on long, wraped lines
nnoremap k gk
nnoremap j gj

nnoremap <Enter> :nohlsearch<CR><Enter>

vmap gl :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

function! MidjeTestFacts(filter)
	Require
	execute "Eval (use 'midje.repl) (and (load-facts " . a:filter . ") (check-facts))"
endfunction
