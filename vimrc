call plug#begin('~/.vim/plugged')
" Use single quotes for plugin names
Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'vim-scripts/matchit.zip'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'nelstrom/vim-visual-star-search'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'vim-scripts/LargeFile'
Plug 'vim-scripts/scratch.vim'
" don't close win when closing buffer
Plug 'moll/vim-bbye'

call plug#end()

let mapleader = "\<Space>"

set nobackup  " do not keep a backup file
set showcmd   " display incomplete commands
set tabstop=4
set shiftwidth=4
set tabstop=4
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
map <F2> :NERDTreeToggle<CR>

" Close vim on :q if NERDTree is the only opened buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" In NERDTree filelist, ignore some file types
let NERDTreeIgnore = ['\.py[co]$', '__pycache__', '\.o$']

let g:SuperTabDefaultCompletionType = 'context'

nmap <C-p> <Plug>yankstack_substitute_older_paste
nmap <C-P> <Plug>yankstack_substitute_newer_paste
try
    call yankstack#setup()  " must setup yankstack before remapping Y
catch
endtry
" Make Y behave like C and D
nnoremap Y y$

let g:ctrlp_map = '<c-t>'  " default c-p is already used by yankstack

let g:LargeFile=5  " large file is when size is > 5MB

augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" read local settings if found
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif
