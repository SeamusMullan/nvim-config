" Special
let g:color0  = '#04111B'
let g:color1  = '#54A963'
let g:color2  = '#D9EC52'
let g:color3  = '#08A396'
let g:color4  = '#72BFB1'
let g:color5  = '#09D1B1'
let g:color6  = '#59D4BA'
let g:color7  = '#7fe7dd'
let g:color8  = '#58a19a'
let g:color9  = '#54A963'
let g:color10 = '#D9EC52'
let g:color11 = '#08A396'
let g:color12 = '#72BFB1'
let g:color13 = '#09D1B1'
let g:color14 = '#59D4BA'
let g:color15 = '#7fe7dd'

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name="wal"

" Set highlights
hi Normal       guifg=#7fe7dd guibg=#04111B
hi NonText      guifg=#58a19a
hi Comment      guifg=#58a19a
hi Constant     guifg=#08A396
hi String       guifg=#D9EC52
hi Identifier   guifg=#72BFB1
hi Function     guifg=#72BFB1
hi Statement    guifg=#09D1B1
hi PreProc      guifg=#59D4BA
hi Type         guifg=#59D4BA
hi Special      guifg=#7fe7dd
hi Underlined   guifg=#72BFB1 gui=underline
hi Error        guifg=#54A963 guibg=#04111B
hi Todo         guifg=#04111B guibg=#08A396
hi LineNr       guifg=#58a19a
hi CursorLineNr guifg=#7fe7dd
hi Visual       guibg=#58a19a
hi Pmenu        guifg=#7fe7dd guibg=#58a19a
hi PmenuSel     guifg=#04111B guibg=#72BFB1
