""""""""""""""""""""""""""""""
" Regular vim settings!
""""""""""""""""""""""""""""""

" Turn off compatability mode
set nocompatible

" Turn on the mouse
set mouse=a

" Turn off menus in gvim
set guioptions-=m
set guioptions-=T
set guioptions-=r

" Turn on colors
filetype on
syntax on
set termguicolors " Use gui colors, true colors, in the terminal
set background=dark

" Font
set guifont=Inconsolata\ for\ Powerline\ 12

" Turn on line numbering
set number

" Set the Leader
let mapleader=","

" History
set hidden
set history=1000

" Reload vimrc
map <leader>r :source ~/.vimrc<CR>

" Folding is evil
set nofoldenable

" Indentation
filetype indent on
filetype plugin indent on
set wrap " Do wrap lines
set tabstop=2 " A tab is two spaces
set shiftwidth=2
set autoindent " Always auto indent
set expandtab " tabs are spaces
set showmatch " show matching parenthesis
set ignorecase " ignore case when searching
set smartcase " unless it has a captial in it
set smarttab " do the right thing, tabs

" Backspace over everything
set backspace=indent,eol,start

" Set the wildmenu on
set wildmenu
set encoding=utf-8

" Search Options
set hlsearch " highlight searchs
set incsearch " do it incrementally

""""""""""
"" Plugins

" If we don't have it, install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'rust-lang/rust.vim'
Plug 'w0rp/ale'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'reedes/vim-pencil'
Plug 'dhruvasagar/vim-table-mode'
Plug 'posva/vim-vue'
Plug 'janko-m/vim-test'
Plug 'jparise/vim-graphql'
Plug 'mattn/emmet-vim'
Plug 'adborden/vim-notmuch-address'

call plug#end()

runtime! macros/matchit.vim

" Gruvbox configuration
colorscheme gruvbox

" Airline
let g:airline_powerline_fonts = 1

" FZF
let g:fzf_buffers_jump = 1 " Jump to the existing window if possible
map <leader>t :Files<CR>
map <leader>b :Buffers<CR>
map <leader>j :BTags<CR>
map <leader>J :Tags<CR>
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
map <leader>s :Rg 

" HTML tag completion
" imap ,h/ </<C-X><C-O><C-X>

" Ripgrep instead of ag
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Rainbow Parenthesis Always
au VimEnter * RainbowParentheses

" Pencil
let g:pencil#wrapModeDefault = 'soft'
let g:pencil#textwidth = 74
let g:pencil#joinspaces = 0
let g:pencil#cursorwrap = 1
let g:pencil#conceallevel = 3
let g:pencil#concealcursor = 'c'
let g:pencil#softDetectSample = 20
let g:pencil#softDetectThreshold = 130

augroup pencil
   autocmd!
   autocmd filetype markdown,mkd call pencil#init()
augroup END

" Lists - local and quick
map <leader>l :lopen<CR>
map <leader>q :copen<CR>

" Rust
let g:rustfmt_autosave = 1

" Ale
let g:ale_fixers = {
      \ 'javascript': ['eslint'],
      \ 'typescript': ['eslint'],
      \ 'vue': ['eslint'],
      \ 'css': ['prettier']
      \}
let g:ale_fix_on_save = 1

