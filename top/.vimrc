set autoindent
set expandtab
set softtabstop=4
set shiftwidth=4
set number
set nowrap

syntax on
set background=dark
color tomz

set guifont=Ubuntu\ Mono\ 10
set errorformat=%f:%l

" Show trailing whitepace and spaces before a tab:
:autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

map <F3> :tn<ENTER>
map <F2> :tp<ENTER>

" Find tags file if possible
python << END_PY
import vim
import os

mypath=os.getcwd()
while 1:
    checktags = os.path.join(mypath, "tags")
    if os.path.exists(checktags):
        vim.command("set tags=" + checktags)
        break
    # Go to the parent directory, stopping if we hit the root
    newpath = os.path.dirname(mypath)
    if newpath == mypath or newpath == "/usr2":
        break
    mypath = newpath
END_PY


"syntax on
"colorscheme tomz
"set ruler
"set number
"set tabstop=4
"set shiftwidth=4
"set noautoindent
"set expandtab
"
"highlight ExtraWhitespace ctermbg=red guibg=red
""strip whitespace at end of line on save
"autocmd BufWritePre * :%s/\s\+$//e
"match ExtraWhitespace /\s\+\%#\@<!$/
