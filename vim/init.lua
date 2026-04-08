-- Bootstrap lazy.nvim (Modern plugin manager for Neovim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "junegunn/fzf",
  "scrooloose/syntastic",
  "SirVer/ultisnips",
  "honza/vim-snippets",
  "tpope/vim-fugitive",
  "elzr/vim-json",
  "tpope/vim-fireplace",
  "luochen1990/rainbow",
  "nulpunkt/php-getter-setter.vim",
  "nanotech/jellybeans.vim",
})

-- UI and Editor Settings
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.ruler = true
vim.opt.formatoptions = "tcqlron"
vim.opt.scrolloff = 999
vim.opt.showcmd = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hidden = false
vim.opt.showmatch = true
vim.opt.autoread = true
vim.opt.suffixes = ".bak,~,.o,.h,.info,.swp,.class"
vim.opt.directory = "/tmp/"
vim.opt.hlsearch = true
vim.opt.clipboard = "unnamed"
vim.opt.timeout = true
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 100
vim.opt.wildmenu = true
vim.opt.completeopt:remove("preview")
vim.cmd("syntax on")
vim.cmd("filetype plugin on")
vim.cmd("colorscheme jellybeans")

-- Plugin Configurations
vim.g.UltiSnipsExpandTrigger = "<tab>"
vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
vim.g.syntastic_php_checkers = { "php" }
vim.g.syntastic_javascript_checkers = { "jshint" }
vim.g.syntastic_cpp_compiler = "clang++"
vim.g.syntastic_cpp_compiler_options = " -std=c++11"
vim.g.ctrlp_max_depth = 40
vim.g.ctrlp_max_files = 0
vim.g.rainbow_active = 1
vim.g.vim_json_syntax_conceal = 0

-- Custom Helper Functions for Testing
_G.RunPhpTest = function()
  local current_name = vim.fn.expand("%")
  if current_name:match("Test.php$") then
    vim.g.phptestfile = current_name
  end
  if vim.g.phptestfile then
    vim.cmd("!phpunit " .. vim.g.phptestfile)
  else
    print("No php test file set yet")
  end
end

_G.RunJsTest = function()
  local current_name = vim.fn.expand("%")
  if current_name:match("test.js$") then
    vim.g.jstestfile = current_name
  end
  if vim.g.jstestfile then
    vim.cmd("!npm test " .. vim.g.jstestfile)
  else
    print("No js test file set yet")
  end
end

_G.RunRubyTest = function()
  local current_name = vim.fn.expand("%")
  if current_name:match("_test.rb$") then
    vim.g.rbtestfile = current_name
  end
  if vim.g.rbtestfile then
    vim.cmd("!ruby " .. vim.g.rbtestfile)
  else
    print("No ruby test file set yet")
  end
end

_G.RunPythonTest = function()
  local current_name = vim.fn.expand("%")
  if current_name:match("_test.py$") then
    vim.g.pytestfile = current_name
  end
  if vim.g.pytestfile then
    vim.cmd("!pyrg " .. vim.g.pytestfile)
  else
    print("No python test file set yet")
  end
end

_G.RunClojureTest = function()
  local current_name = vim.fn.expand("%")
  if current_name:match("_test.clj$") then
    local ns = current_name:gsub("./test/", ""):gsub(".clj", ""):gsub("/", "."):gsub("_", "-")
    vim.g.cljtestns = ns
  end
  if vim.g.cljtestns then
    vim.cmd("silent %Eval")
    vim.cmd("RunTests " .. vim.g.cljtestns)
  else
    print("No clojure test namespace set yet")
  end
end

_G.MyGGrep = function(p, ft)
  vim.cmd("exec ':r!git grep -in \"" .. p .. "\" -- " .. ft .. "'")
end

-- Keymaps
local map = vim.keymap.set

map("n", "<C-p>", ":FZF<cr>")
map("n", "gf", "<c-w>gF")
map("n", "<Leader>m", ":!mkdir -p %:h<CR><CR>")
map("n", "<Leader>f", ":s/\\\\015/\\r/g<CR>")
map("n", "<Leader>l", ":%s/#/\\r#/g<CR>:%s/\\\\n//g<CR>")
map("n", "<leader>cc", ":!cat % | xclip -selection clipboard <cr><cr>")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("n", "<Leader>t", ":tabnew<CR>")
map("n", "<Leader>b", ":G blame -w<CR>")
map("n", "L", "<C-w><")
map("n", "H", "<C-w>>")
map("n", "<C-]>", "<C-w><C-]><C-w>T")
map("n", "<Leader>e", ':e <C-R>=expand("%:p:h") . "/" <CR>')
map("v", "<leader>w", ":s/\\s\\+=/ =/<cr>")
map("n", "<Leader>sp", ":normal F(ldt,f)i,  pF(lxx")
map("n", "<Leader>se", ":silent! set spell spelllang=en<CR>")
map("n", "k", "gk")
map("n", "j", "gj")
map("n", "<Enter>", ":nohlsearch<CR><Enter>")

-- Git visual blame mapping using clean Lua
map("v", "gl", function()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local file_path = vim.fn.expand("%:p")
  vim.cmd("!git blame " .. file_path .. " | sed -n " .. start_line .. "," .. end_line .. "p")
end)

map("n", "<leader>gp", ":Ggrepphp ")

-- Finding unit test files (Converted from Vimscript to Lua callbacks)
local function open_test(search, replace)
  local path = vim.fn.expand("%:p")
  path = vim.fn.substitute(path, search, replace, "")
  path = vim.fn.substitute(path, "\\.php", "Test.php", "")
  vim.cmd("vs " .. path)
end

map("n", "<Leader>bu", function() open_test("backend", "backend/test/unit") end)
map("n", "<Leader>au", function() open_test("api", "api/test/unit") end)
map("n", "<Leader>ai", function() open_test("/api", "/api/test/integration") end)
map("n", "<Leader>ad", function() open_test("/api", "/api/test/database") end)
map("n", "<Leader>cu", function() open_test("/colourbox", "/colourbox/tests/unit") end)
map("n", "<Leader>ci", function() open_test("/colourbox", "/colourbox/tests/integration") end)
map("n", "<Leader>cd", function() open_test("/colourbox", "/colourbox/tests/database") end)

-- Insert mode maps
map("i", "é", "(")
map("i", "ï", ")")
map("i", "½", "$")
vim.cmd("iab <expr> dts strftime('%F %T')")

-- Autocommands
local group = vim.api.nvim_create_augroup("MyConfigs", { clear = true })

-- Strip trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  pattern = { "*.php", "*.rb", "*.py", "*.clj", "*.json", "*.sql", "*.yml", "*.js", "*.jsx", "*.css", "*.md", "*.cpp", "*.h", "*.phtml" },
  command = [[%s/\s\+$//e]],
})

-- PHP Specific
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "php",
  callback = function()
    map("n", "<C-c>", ":w<CR>:!/usr/bin/php -l %<CR>", { buffer = true })
    vim.opt_local.omnifunc = "phpcomplete#CompletePHP"
    map("n", "<leader>o", ":lua RunPhpTest()<cr>", { buffer = true })
    map("n", "K", ":!pman <cword><cr>", { buffer = true })
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = group,
  pattern = "*.php",
  command = "silent! !command -v php-cs-fixer > /dev/null && php-cs-fixer fix --rules @PSR12 -q %",
})

-- Two-space indentation languages
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "clojure", "html", "css", "ruby", "cucumber", "json", "yaml", "javascript", "typescript" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.ts = 2
    vim.opt_local.sw = 2
    vim.opt_local.sts = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "markdown",
  command = "setlocal ts=2 sts=2 sw=2 tw=79",
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "python",
  callback = function()
    map("n", "<leader>o", ":lua RunPythonTest()<cr>", { buffer = true })
    vim.opt_local.expandtab = false
  end,
})

-- Custom User Commands
vim.api.nvim_create_user_command("Ggrepphp", function(opts)
  _G.MyGGrep(opts.args, "*.php *.phtml")
  vim.cmd("1")
end, { nargs = "*" })

vim.api.nvim_create_user_command("PhpscStyleFix", "!patch -p0 -ui <(./vendor/bin/phpcs --report=diff --standard=PSR12 --extensions=php %)", {})
