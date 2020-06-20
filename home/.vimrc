""""""""""""""""""""""""""""""
" Regular vim settings!
""""""""""""""""""""""""""""""

" Set the font in a gui
if has("gui_running") 
  set guifont=Fira\ Code\ 14
endif

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
let g:gruvbox_material_background = 'medium'

" Font
"set guifont=Inconsolata\ for\ Powerline\ 12

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

" Display messages
set cmdheight=1
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Clipboard
set clipboard=unnamed,unnamedplus

""""""""""
"" Plugins

" If we don't have it, install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:polyglot_disabled = ['graphql', 'rust', 'vue']

call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf.vim'
" Plug 'morhetz/gruvbox'
Plug 'gruvbox-material/vim', {'as': 'gruvbox-material'}
Plug 'vim-airline/vim-airline'
Plug 'junegunn/rainbow_parentheses.vim'
" Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'rust-lang/rust.vim'
" Plug 'w0rp/ale'
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
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'sheerun/vim-polyglot'

call plug#end()

runtime! macros/matchit.vim

" Gruvbox configuration
colorscheme gruvbox-material

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'gruvbox_material'
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#extensions#branch#enabled = 1


" FZF
let g:fzf_buffers_jump = 0 " don't Jump to the existing window if possible
map <leader>t :Files<CR>
map <leader>b :Buffers<CR>
map <leader>j :BTags<CR>
map <leader>J :Tags<CR>
" map <leader>d :NERDTreeToggle<CR>
map <leader>d :CocCommand explorer<CR>
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

" Markdown
let g:vim_markdown_conceal = 0

" Rust
let g:rustfmt_autosave = 1

"""""
" COC

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

let g:coc_explorer_global_presets = {
      \ 'floating': {
      \   'position': 'floating',
      \   'floating-position': 'left-center',
      \   'floating-width': 50,
      \ }
      \}
