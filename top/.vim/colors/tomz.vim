" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file
" Maintainer:	Ron Aaron <ronaharon@yahoo.com>
" Last Change:	2003 May 02

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "tomz"

" syn region hereDoc start="<<\z(\I\i*\)" end="^\z1$"

hi Normal	guifg=Lightgrey	guibg=black
hi Comment	term=bold	ctermfg=DarkGrey	ctermbg=Black		guifg=DarkGrey
hi Constant	term=underline	ctermfg=White		guifg=White
hi Special	term=bold	ctermfg=DarkMagenta	guifg=DarkMagenta
hi Identifier 	term=underline	cterm=bold			ctermfg=Cyan guifg=cyan
hi Statement 	term=bold	ctermfg=Grey gui=bold	guifg=#aa4444
hi PreProc	term=underline	ctermbg=Black    ctermfg=LightRed    guifg=lightred
hi Type		term=underline	ctermfg=White	guifg=white gui=bold
hi Function	term=bold	ctermfg=White guifg=White
hi Repeat	term=underline	ctermfg=White		guifg=white
hi Operator     ctermfg=grey
hi Ignore	ctermfg=black	guifg=bg
hi Error	term=reverse 	ctermbg=Red ctermfg=White guibg=Red guifg=White
hi Todo		term=standout 	ctermbg=Yellow ctermfg=Black guifg=Blue guibg=Yellow
hi LineNr			ctermfg=DarkGrey guifg=DarkGrey
hi hereDoc	term=underline	ctermfg=Brown		guifg=Magenta

hi IncSearch	guifg=slategrey guibg=khaki
hi Search	guibg=peru guifg=wheat

hi IncSearch	cterm=NONE ctermfg=yellow ctermbg=green
hi Search	cterm=NONE ctermfg=grey ctermbg=blue

" Common groups that link to default highlighting.
" You can specify other highlighting easily.
hi link String	Constant
hi link Character	Constant
hi link Number	Constant
hi link Boolean	Constant
hi link Float		Number
hi link Conditional	Repeat
hi link Label		Statement
hi link Keyword	Statement
hi link Exception	Statement
hi link Include	PreProc
hi link Define	PreProc
hi link Macro		PreProc
hi link PreCondit	PreProc
hi link StorageClass	Type
hi link Structure	Type
hi link Typedef	Type
hi link Tag		Special
hi link SpecialChar	Special
hi link Delimiter	Special
hi link SpecialComment Special
hi link Debug		Special