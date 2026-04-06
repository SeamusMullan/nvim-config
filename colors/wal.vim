" Special
let g:color0  = '#101111'
let g:color1  = '#53676A'
let g:color2  = '#76817E'
let g:color3  = '#2F728D'
let g:color4  = '#2B97B9'
let g:color5  = '#64979D'
let g:color6  = '#96ACAC'
let g:color7  = '#cddbda'
let g:color8  = '#8f9998'
let g:color9  = '#53676A'
let g:color10 = '#76817E'
let g:color11 = '#2F728D'
let g:color12 = '#2B97B9'
let g:color13 = '#64979D'
let g:color14 = '#96ACAC'
let g:color15 = '#cddbda'

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name="wal"

" Set highlights
hi Normal       guifg=#cddbda guibg=#101111
hi NonText      guifg=#8f9998
hi Comment      guifg=#8f9998
hi Constant     guifg=#2F728D
hi String       guifg=#76817E
hi Identifier   guifg=#2B97B9
hi Function     guifg=#2B97B9
hi Statement    guifg=#64979D
hi PreProc      guifg=#96ACAC
hi Type         guifg=#96ACAC
hi Special      guifg=#cddbda
hi Underlined   guifg=#2B97B9 gui=underline
hi Error        guifg=#53676A guibg=#101111
hi Todo         guifg=#101111 guibg=#2F728D
hi LineNr       guifg=#8f9998
hi CursorLineNr guifg=#cddbda
hi Visual       guibg=#8f9998
hi Pmenu        guifg=#cddbda guibg=#8f9998
hi PmenuSel     guifg=#101111 guibg=#2B97B9
