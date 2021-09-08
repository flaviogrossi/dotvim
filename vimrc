call plug#begin('~/.vim/plugged')
" Use single quotes for plugin names

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'nelstrom/vim-visual-star-search'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'vim-scripts/LargeFile'
Plug 'scrooloose/nerdtree'

Plug 'moll/vim-bbye'   " delete buffers (close files) without closing your windows
Plug 'tpope/vim-sleuth'  " Heuristically set buffer options
Plug 'sheerun/vim-polyglot'  " vim language pack

" lightline
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'

" fuzzy file finder
Plug 'ctrlpvim/ctrlp.vim'

" save a yank stack to allow pasting old text
Plug 'maxbrunsfeld/vim-yankstack'

Plug 'vim-scripts/ZoomWin'

Plug 'editorconfig/editorconfig-vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" lang specific
" add the 'e' text object in elixir
Plug 'andyl/vim-textobj-elixir', { 'for': 'elixir' }

" maybe use
" Plug 'dyng/ctrlsf.vim'
" Plug 'vim-scripts/scratch.vim'
" Plug 'sjl/gundo.vim'

call plug#end()

let mapleader = "\<Space>"

set nobackup  " do not keep a backup file
set showcmd   " display incomplete commands
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set scrolloff=3
set hidden
set ttyfast
set gdefault  " replace every occurence in a line by default
set textwidth=79
set formatoptions=cqj
set splitright " open new vsplit to the right
set splitbelow " open new split at the bottom
set switchbuf=useopen  " if a buffer is already opened, switch to it
set confirm  " don't abort commands, ask me
set clipboard=unnamed,unnamedplus  " yank to system clipboard
set listchars=tab:▸\ ,trail:␣
set list
set hlsearch
set shortmess+=a  " use [+], [RO], [w] for modified, read-only, ...
set wildignore+=*.so,*.swp,*.zip,*.pyc,*/.svn/*,*/.git/*,*/.hg/*
set wildmode=longest:list,full
if exists('+colorcolumn')
    let cc_range = []
    for i in range(1, 999)
        let cc_range += ["+".i]
    endfor
    let &colorcolumn=join(cc_range, ",")
endif
highlight Pmenu ctermbg=green cterm=bold " set completion menu color and style
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline " underline errors
highlight ColorColumn ctermbg=235
highlight Search cterm=NONE ctermfg=grey ctermbg=95

" no errorbell
set noeb vb t_vb=

" Remap esc
map! òò <C-c>
vmap òò <Esc>
nmap <CR> :
vmap <CR> :
" toggle hybrid numbering
nnoremap <silent><leader>n :set invrelativenumber invnumber<Esc>
" 'a when a is a mark goes to mark line. ` goes to mark line & column
" " ` is more useful but harder to type, so swap them
nnoremap ' `
nnoremap ` '

let g:netrw_liststyle=3    " treeview for netrw

" Close vim on :q if NERDTree is the only opened buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" In NERDTree filelist, ignore some file types
let NERDTreeIgnore = ['\.py[co]$', '__pycache__', '\.o$', '\.lo$', '\.la$']
let NERDTreeHijackNetrw=1  " use nerdtree as split explorer


" configure ctrlp plugin
let g:ctrlp_map = '<c-t>'  " default c-p is already used by yankstack
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard'] " ignore untracked files


" configure lightline plugin
set noshowmode
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
  \ }


" configure yankstack
nmap <C-p> <Plug>yankstack_substitute_older_paste
nmap <C-P> <Plug>yankstack_substitute_newer_paste
try
    call yankstack#setup()  " must setup yankstack before remapping Y
catch
endtry

" Make Y behave like C and D
nnoremap Y y$

let g:LargeFile=5  " large file is when size is > 5MB

" do not set nu or fc behind my back using vim modeline
autocmd BufWinEnter * silent setlocal nonumber foldcolumn=0

""""" coc.nvim configuration

" use system node to avoid version managed by node manager
let g:coc_node_path = '/usr/bin/node'

" use tab for completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gb <C-o>

" Use K to show documentation in preview window.
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

""""" end coc.nvim configuration


augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" read local settings if found
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif
