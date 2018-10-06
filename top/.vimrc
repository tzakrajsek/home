set autoindent
set expandtab
set softtabstop=4
set shiftwidth=4
set number
set nowrap
set incsearch
set ve=all

" [tomz] pathogen is a package manager for vim despite the scary api
execute pathogen#infect()

syntax on
set background=dark
color tomz
" color desert
set hls

"set guifont=Ubuntu\ Mono\ 10
set guifont=menlo
set errorformat=%f:%l

" Show trailing whitepace and spaces before a tab:
":autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/
"strip whitespace at end of line on save
autocmd BufWritePre * :%s/\s\+$//e

map <F3> :tn<ENTER>
map <F2> :tp<ENTER>

