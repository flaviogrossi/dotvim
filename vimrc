" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'kien/ctrlp.vim'
Bundle 'hallettj/jslint.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'klen/rope-vim'
" Bundle 'scrooloose/syntastic'
Bundle 'derekwyatt/vim-scala'
Bundle 'sjl/gundo.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'ervandew/supertab'
"Bundle 'vim-scripts/YankRing.vim'
Bundle 'maxbrunsfeld/vim-yankstack'
Bundle 'vim-scripts/LaTeX-Suite-aka-Vim-LaTeX'
Bundle 'kevinw/pyflakes-vim'
Bundle 'davidhalter/jedi-vim'

" My Bundles here:
"

filetype plugin indent on     " required!
"
" Brief help
" original repos on github
" Bundle 'tpope/vim-fugitive'
" Bundle 'Lokaltog/vim-easymotion'
" vim-scripts repos
" Bundle 'L9'
" Bundle 'FuzzyFinder'
" non github repos
" Bundle 'git://git.wincent.com/command-t.git'
" ...
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed.


" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup		" do not keep a backup file
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab       " replace tabs with spaces
set softtabstop=4
set wildmenu
set wildmode=longest:full
set scrolloff=3		" keep 3 lines below and above cursor when scrolling
set hidden 		" allow to switch between unsaved buffers

set ttyfast

set gdefault  " replace every occurence in a line by default

set textwidth=80

set splitright     " open new vsplit to the right
set splitbelow     " open new split at the bottom

set switchbuf=useopen   " if a buffer is already opened, switch to it

set confirm  " don't abort commands, ask me

" hi ColorColumn guibg=lightgrey
if v:version > 703
    set colorcolumn=+1     " colora la colonna textwidth+1
endif

map ,rn :set invrelativenumber<Esc>  " toggle relativenumber with <leader>-rn

highlight Pmenu ctermbg=green cterm=bold " set completion menu color and style

" Close vim on :q if NERDTree is the only opened buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

map <F2> :NERDTreeToggle<CR>
map <F3> :e `pwd`<CR>

map <F4> :!make<CR>
map! <F4> :!make<CR>
map <F5> :silent !make view<CR>
map! <F5> :silent !make view<CR>

map <F9> :ls<CR>:b

let NERD_c_alt_style=1  " c default comments
let NERDSpaceDelims=1   " add space after comments

" disable latex auto folding
let g:Tex_AutoFolding = 0
let g:tex_flavor='latex'

let g:yankring_persist = 0
let g:yankring_history_dir = '$HOME/.vim/'

let g:SuperTabDefaultCompletionType = 'context'

" disble higlight of search results until next search
map <F8> :nohlsearch<CR>

" map Esc to a more convenient key
map! òò <C-c>
" map! òò <Esc>
vmap òò <Esc>

nmap <C-p> <Plug>yankstack_substitute_older_paste
nmap <C-P> <Plug>yankstack_substitute_newer_paste
call yankstack#setup()  " must setup yankstack before remapping Y
" Make Y behave like C and D
nnoremap Y y$

nmap <CR> :
vmap <CR> :

set shortmess+=a	" use [+], [RO], [w] for modified, read-only, ...
set laststatus=2	" always show statusline

" 'a when a is a mark goes to mark line. ` goes to mark line & column
" ` is more useful but harder to type, so swap them
nnoremap ' `
nnoremap ` '

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" move easily between tabs
map <S-Right> <Esc>:tabnext<CR>
map <S-Left> <Esc>:tabprevious<CR>
imap <S-Right> <Esc>:tabnext<CR>
imap <S-Left> <Esc>:tabprevious<CR>

" move easily between buffers
map <M-Right> <Esc>:bn<CR>
map <M-Left> <Esc>:bp<CR>
imap <M-Right> <Esc>:bn<CR>
imap <M-Left> <Esc>:bp<CR>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" ctrlp
set runtimepath^=~/.vim/bundle/ctrlp
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*/.svn/*,*/.git/*,*/.hg/*
let g:ctrlp_map = '<c-t>'  " default c-p is already used by yankring

" Syntastic
let g:syntastic_check_on_open=0
let g:syntastic_enable_signs=0
let g:ctrlp_custom_ignore = { 'dir':  '\v[\/](tags|branches)$' }
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': ['python', 'javascript'] }


" disable annoying numbering and foldcolumn on ydin files
autocmd BufWinEnter *.py silent setlocal nonumber foldcolumn=0
autocmd BufWinEnter *.tac silent setlocal nonumber foldcolumn=0
autocmd BufWinEnter *.js silent setlocal nonumber foldcolumn=0
autocmd BufWinEnter *.thrift silent setlocal nonumber foldcolumn=0
autocmd BufWinEnter *.css silent setlocal nonumber foldcolumn=0
 
