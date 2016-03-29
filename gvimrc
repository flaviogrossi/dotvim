colorscheme mydesert

highlight Pmenu guibg=darkcyan gui=bold  " set completion menu color and style

" remove toolbar, menu and scrollbars
setlocal guioptions-=T
setlocal guioptions-=m
setlocal guioptions-=r
setlocal guioptions-=L

set mousemodel=popup    " for right-click menu on bad spelled words

setlocal guioptions+=c  " don't use graphic dialogs

" start with as many lines as possible (vertically maximized)
" set lines=999
au GUIEnter * set lines=999 columns=90

" highlight current line
set cursorline

set guifont=DejaVu\ Sans\ Mono\ 9
