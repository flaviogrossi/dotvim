let g:ale_completion_enabled = 1
let g:ale_completion_delay = 1500
let g:ale_lint_delay = 1500

call plug#begin('~/.vim/plugged')
" Use single quotes for plugin names
Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'sjl/gundo.vim'
Plug 'ervandew/supertab'
Plug 'vim-scripts/matchit.zip'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'nelstrom/vim-visual-star-search'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
" Plug 'vim-scripts/ShowMarks'
Plug 'vim-scripts/LargeFile'
Plug 'vim-scripts/scratch.vim'
" Plug 'jacquesbh/vim-showmarks'
" don't close win when closing buffer
Plug 'moll/vim-bbye'
Plug 'dyng/ctrlsf.vim'
Plug 'tpope/vim-sleuth'
Plug 'sheerun/vim-polyglot'

" lightline
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'

Plug 'vim-scripts/ZoomWin'

" Plug 'scrooloose/syntastic', { 'for': 'python' }
" Plug 'flaviogrossi/pyflakes-vim', { 'for': 'python' }
Plug 'w0rp/ale'
" Plug 'slashmili/alchemist.vim', { 'for': 'elixir' }
" Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'bps/vim-textobj-python', { 'for': 'python' }
" Plug 'hallettj/jslint.vim', { 'for': 'javascript' }
Plug 'wting/rust.vim', { 'for': 'rust' }
Plug 'vim-scripts/LaTeX-Suite-aka-Vim-LaTeX', { 'for': 'tex' }
Plug 'rbonvall/vim-textobj-latex', { 'for': 'tex' }
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }
Plug 'andyl/vim-textobj-elixir', { 'for': 'elixir' }
Plug 'mhinz/vim-mix-format', { 'for': 'elixir' }
Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
Plug 'editorconfig/editorconfig-vim'

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
map <F2> :NERDTreeToggle<CR>

let g:netrw_liststyle=3    " treeview for netrw

let g:ale_elixir_elixir_ls_release = '/home/flavio/src/elixir-ls/release'

" let g:ale_lint_on_text_changed = 'normal'
" let g:ale_lint_on_insert_leave = 1

" let g:ale_linters = {'elixir': ['credo', 'dialyxir', 'elixir-ls']}
let g:ale_linters = {'elixir': ['credo', 'elixir-ls']}

" Close vim on :q if NERDTree is the only opened buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" In NERDTree filelist, ignore some file types
let NERDTreeIgnore = ['\.py[co]$', '__pycache__', '\.o$', '\.lo$', '\.la$']
let NERDTreeHijackNetrw=1  " use nerdtree as split explorer

" let g:SuperTabDefaultCompletionType = 'context'

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

" remap CtrlSF commands
nmap     <leader>f <Plug>CtrlSFPrompt
vmap     <leader>f <Plug>CtrlSFVwordExec
nmap     <leader>n <Plug>CtrlSFCwordPath
nnoremap <leader>t :CtrlSFToggle<CR>
let g:ctrlsf_mapping = {
            \ "popenf"  : "p",
            \ "popen"   : "P",
            \ "next": "n",
            \ "prev": "N",
            \ }

nmap <C-p> <Plug>yankstack_substitute_older_paste
nmap <C-P> <Plug>yankstack_substitute_newer_paste
try
    call yankstack#setup()  " must setup yankstack before remapping Y
catch
endtry
" Make Y behave like C and D
nnoremap Y y$

let g:ctrlp_map = '<c-t>'  " default c-p is already used by yankstack
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard'] " ignore untracked files

let g:LargeFile=5  " large file is when size is > 5MB

" do not set nu or fc behind my back using vim modeline
autocmd BufWinEnter * silent setlocal nonumber foldcolumn=0

" change alchemist default jump to definition
" let g:alchemist_tag_map = 'gd'
" let g:alchemist_tag_stack_map = 'gb'

nnoremap <Leader>r :ALEFindReferences<enter>
nnoremap gd :ALEGoToDefinition<enter>
nnoremap gb <C-o>
nnoremap K :ALEHover<enter>

augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" read local settings if found
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif
