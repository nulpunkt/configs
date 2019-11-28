" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle (required)!
Bundle 'gmarik/vundle'
Bundle 'junegunn/fzf'
Bundle 'scrooloose/syntastic'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
" Bundle 'shawncplus/phpcomplete.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'elzr/vim-json'
Bundle 'tpope/vim-fireplace'
Bundle 'luochen1990/rainbow'
Bundle 'nulpunkt/php-getter-setter.vim'

" The usual suspects
syntax on
filetype plugin on
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
set clipboard=unnamed
" Dat pesky wait between <esc>O and insert..
set timeout timeoutlen=1000 ttimeoutlen=100
set wildmenu

let mapleader=" "

" Cool search plugin
nnoremap <C-p> :call fzf#run({ 'source': 'find . \( -name "*.tmp.js" -o -path ./node_modules -o -path ./.git -o -path ./coverage -o -path ./private/node_modules -o -path ./public/js/bower_components -o -path ./bower_components \) -prune -o -type f -print', 'sink': 'e' })<CR>

" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:syntastic_php_checkers=['php', 'phpcs']
let g:syntastic_php_phpcs_args = '--standard=PSR12'
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'

let g:ctrlp_max_depth = 40
let g:ctrlp_max_files = 0

let g:rainbow_active = 1

let g:vim_json_syntax_conceal = 0

colorscheme jellybeans

set completeopt-=preview

au FileType php map <C-c> :w<CR>:!/usr/bin/php -l %<CR>
au FileType php set omnifunc=phpcomplete#CompletePHP
au FileType php nnoremap <leader>o :call RunPhpTest()<cr>
au FileType php nnoremap K :!pman <cword><cr>
au FileType php setlocal expandtab
au BufWritePre *.php,*.rb,*.py,*.clj,*.json,*.sql,*.yml,*.js,*.jsx,*.css,*.md,*.cpp,*.h :%s/\s\+$//e

au FileType javascript nnoremap <leader>o :call RunJsTest()<cr>

au FileType python nnoremap <leader>o :call RunPythonTest()<cr>

au FileType clojure nnoremap <leader>o :call RunClojureTest()<cr>
au FileType clojure setlocal expandtab | setlocal ts=2 | setlocal sts=2 | setlocal sw=2

au Filetype html setlocal expandtab | setlocal ts=2 | setlocal sts=2 | setlocal sw=2
au Filetype css setlocal expandtab | setlocal ts=2 | setlocal sts=2 | setlocal sw=2

au Filetype markdown setlocal ts=2 | setlocal sts=2 | setlocal sw=2 | setlocal tw=79

au FileType ruby set omnifunc=rubycomplete#Complete
au Filetype ruby setlocal expandtab | setlocal ts=2 | setlocal sts=2 | setlocal sw=2
au FileType ruby nnoremap <leader>o :call RunRubyTest()<cr>

au Filetype cucumber setlocal expandtab | setlocal ts=2 | setlocal sts=2 | setlocal sw=2

au Filetype json setlocal expandtab | setlocal ts=2 | setlocal sts=2 | setlocal sw=2
au Filetype yaml setlocal expandtab | setlocal ts=2 | setlocal sts=2 | setlocal sw=2

au FileType c nnoremap <leader>o :!clang -lm -Wall % && ./a.out && rm a.out<cr>

au Filetype javascript setlocal expandtab | setlocal ts=2 | setlocal sts=2 | setlocal sw=2

au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell

" Stuff for finding test files
nnoremap <Leader>bu :vs <C-R>=substitute(substitute(expand("%:p"), "backend", "backend\/test/unit", ""), "\.php", "Test.php", "")<CR> <CR>
nnoremap <Leader>au :vs <C-R>=substitute(substitute(expand("%:p"), "api", "api\/test/unit", ""), "\.php", "Test.php", "")<CR> <CR>
nnoremap <Leader>ai :vs <C-R>=substitute(substitute(expand("%:p"), "\/api", "\/api\/test/integration", ""), "\.php", "Test.php", "")<CR> <CR>
nnoremap <Leader>ad :vs <C-R>=substitute(substitute(expand("%:p"), "\/api", "\/api\/test/database", ""), "\.php", "Test.php", "")<CR> <CR>
nnoremap <Leader>cu :vs <C-R>=substitute(substitute(expand("%:p"), "\/colourbox", "\/colourbox\/tests/unit", ""), "\.php", "Test.php", "")<CR> <CR>
nnoremap <Leader>ci :vs <C-R>=substitute(substitute(expand("%:p"), "\/colourbox", "\/colourbox\/tests/integration", ""), "\.php", "Test.php", "")<CR> <CR>
nnoremap <Leader>cd :vs <C-R>=substitute(substitute(expand("%:p"), "\/colourbox", "\/colourbox\/tests/database", ""), "\.php", "Test.php", "")<CR> <CR>
nnoremap Q <nop>

" Make the directory the current file should reside in
nnoremap <Leader>m :!mkdir -p %:h<CR><CR>

" fix tmux's retarded \015 instead of line break
nnoremap <Leader>f :s/\\015/\r/g<CR>
" fix log files that are on one line
nnoremap <Leader>l :%s/#/\r#/g<CR>:%s/\\n//g<CR>
" Copy the contents of the current file into copy buffer
nnoremap <leader>cc :!cat % \| xclip -selection clipboard <cr><cr>

" Open files in a new tab
noremap gf <c-w>gF

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
" Easy blame
nnoremap <Leader>b :Gblame -w<CR>
" Easy date
iab <expr> dts strftime("%F %T")

" Easy window resize
nnoremap L <C-w><
nnoremap H <C-w>>

" Ctags, open in new tab
nnoremap <C-]> <C-w><C-]><C-w>T

" File in the current directory
nnoremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Remove unessesary whitespace from lines of assignment
nnoremap <leader>w :'<,'>s/\s\+=/ =/<cr>

" Transpose params
nnoremap <Leader>sp :normal F(ldt,f)i, pF(lxx

" Set spell
nnoremap <Leader>se :silent! set spell spelllang=en<CR>

" More natural moving on long, wraped lines
nnoremap k gk
nnoremap j gj

nnoremap <Enter> :nohlsearch<CR><Enter>

vmap gl :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

nnoremap <leader>gp :Ggrepphp 
command! -nargs=* Ggrepphp call MyGGrep('<args>', "'*.php' '*.phtml'")

command! PhpscStyleFix :!patch -p0 -ui <(./vendor/bin/phpcs --report=diff --standard=PSR12 --extensions=php %)

fun! MyGGrep(p, ft)
	exec ':r!git grep -in "' . a:p . '" -- ' . a:ft
endfunction

fun! RunPhpTest()
    let current_name = expand('%')
    if match(current_name, 'Test.php$') != -1
        let s:phptestfile = current_name
    endif
    if exists("s:phptestfile")
        exec ':!phpunit '.s:phptestfile
    else
        echo "No php test file set yet"
    endif
endfunction

fun! RunJsTest()
    let current_name = expand('%')
    if match(current_name, 'test.js$') != -1
        let s:jstestfile = current_name
    endif
    if exists("s:jstestfile")
        exec ':!npm test '.s:jstestfile
    else
        echo "No js test file set yet"
    endif
endfunction

fun! RunRubyTest()
    let current_name = expand('%')
    if match(current_name, '_test.rb$') != -1
        let s:rbtestfile = current_name
    endif
    if exists("s:rbtestfile")
        exec ':!ruby '.s:rbtestfile
    else
        echo "No ruby test file set yet"
    endif
endfunction


fun! RunPythonTest()
    let current_name = expand('%')
    if match(current_name, '_test.py$') != -1
        let s:pytestfile = current_name
    endif
    if exists("s:pytestfile")
        exec ':!pyrg '.s:pytestfile
    else
        echo "No python test file set yet"
    endif
endfunction

fun! RunClojureTest()
    let current_name = expand('%')
    if match(current_name, '_test.clj$') != -1
        let s:cljtestns = substitute(substitute(substitute(substitute(current_name, ".\/test\/", "", ""), ".clj", "", ""), '\/', '.', ''), "_", '-', '')
    endif
    if exists("s:cljtestns")
        exec ':silent %Eval'
        exec ':RunTests '.s:cljtestns
    else
        echo "No clojure test namespace set yet"
    endif
endfunction
