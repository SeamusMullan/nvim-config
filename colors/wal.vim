" Special
let g:color0  = '#0b0d04'
let g:color1  = '#7D8656'
let g:color2  = '#8FAD07'
let g:color3  = '#ADCE18'
let g:color4  = '#CAE458'
let g:color5  = '#B7BE99'
let g:color6  = '#E7F6A2'
let g:color7  = '#f1f5df'
let g:color8  = '#a8ab9c'
let g:color9  = '#7D8656'
let g:color10 = '#8FAD07'
let g:color11 = '#ADCE18'
let g:color12 = '#CAE458'
let g:color13 = '#B7BE99'
let g:color14 = '#E7F6A2'
let g:color15 = '#f1f5df'

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name="wal"

" Set highlights
hi Normal       guifg=#f1f5df guibg=#0b0d04
hi NonText      guifg=#a8ab9c
hi Comment      guifg=#a8ab9c
hi Constant     guifg=#ADCE18
hi String       guifg=#8FAD07
hi Identifier   guifg=#CAE458
hi Function     guifg=#CAE458
hi Statement    guifg=#B7BE99
hi PreProc      guifg=#E7F6A2
hi Type         guifg=#E7F6A2
hi Special      guifg=#f1f5df
hi Underlined   guifg=#CAE458 gui=underline
hi Error        guifg=#7D8656 guibg=#0b0d04
hi Todo         guifg=#0b0d04 guibg=#ADCE18
hi LineNr       guifg=#a8ab9c
hi CursorLineNr guifg=#f1f5df
hi Visual       guibg=#a8ab9c
hi Pmenu        guifg=#f1f5df guibg=#a8ab9c
hi PmenuSel     guifg=#0b0d04 guibg=#CAE458
