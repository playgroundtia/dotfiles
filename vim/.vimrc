" Use Vim settings
set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug-ins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()
" Compatibility
Plug 'tpope/vim-sensible'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tmux-plugins/vim-tmux'
" Appearance
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
" Highlighters
Plug 'ap/vim-css-color'
Plug 'sheerun/vim-polyglot'
Plug 'ntpeters/vim-better-whitespace'
" Linters
Plug 'w0rp/ale'
" File management
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ctrlpvim/ctrlp.vim'
" Git
Plug 'airblade/vim-gitgutter'
" Editing
Plug 'editorconfig/editorconfig-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-multiple-cursors'
Plug 'heavenshell/vim-jsdoc'
" Helpers
Plug 'brooth/far.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-repeat'
Plug 'ervandew/supertab'
Plug 'severin-lemaignan/vim-minimap'
" Code completion
if has('nvim') || ((v:version >= 800) && has("python3"))
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  elseif (v:version >= 800) && has("python3")
    Plug 'Shougo/deoplete.nvim', { 'do': 'if [[ \"$(uname)\" == \"Linux\" ]]; then sudo apt update && sudo apt install -y python3-pip; else brew update && brew reinstall python3; fi; pip3 install neovim' }
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif
  let g:deoplete#enable_at_startup = 1

  " JavaScript
  Plug 'carlitux/deoplete-ternjs', { 'do': 'sudo yarn global add tern --ignore-optional' }
endif
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Faster vim
set lazyredraw
" Always display status line
set laststatus=2
" Enable last used search pattern highlighting
set hlsearch
" Enable cursor line highlighting
set cursorline
" Enable overlength line highlighting
set colorcolumn=80
" Enable trailing whitespace hightlighting
highlight WhitespaceEOL ctermbg=DarkRed
match WhitespaceEOL /\s\+$/
" Enable mouse support
set mouse=a
set ttymouse=xterm2
" Enable line numbers
set number
" Enable case-insensitive search
set ic
" Enable specific configuration for filetypes
filetype plugin indent on
" Set history size
set history=100
" Enable .viminfo
set viminfo='20,\"50
" Set utf-8 encoding
set encoding=utf-8
set fileencoding=utf-8
" Use two spaces as tab
set tabstop=2 shiftwidth=2 expandtab
" Turn backup off
set nobackup
set nowb
set noswapfile
" Auto reload files when they change
set autoread
" Set update interval
set updatetime=100
" :W sudo saves the file
command W w !sudo tee % > /dev/null
" Show matching brackets when text indicator is over them
set showmatch
" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
" Set leader key to ,
let mapleader = ','
" Clipboard
if has('macunix')
  map <leader>c :w !pbcopy<CR>
  map <leader>p :r !pbpaste<CR>
else
  map <leader>c :w !xsel -i -b<CR>
  map <leader>p :r !xsel -p<CR>
endif
" Unsets the "last search pattern" register by hitting return
nnoremap <silent> <CR> :noh<CR><CR>
" Reduce how often you see the "Hit ENTER to continue"
set shortmess=a

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme dracula
let g:airline_theme = 'dracula'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GUI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('gui_running')
  " Font
  if has("gui_macvim")
    " mVim
    set guifont=Hack\ Regular\ Nerd\ Font\ Complete:h10
  else
    " gVim
    set guifont=Hack\ 10
  endif
  " Remove menu bar
  set guioptions-=m
  " Remove toolbar
  set guioptions-=T
  " Remove right scrollbar
  set guioptions-=R
  set guioptions-=r
  " Remove left scrollbar
  set guioptions-=L
  set guioptions-=l
  " Maximize window
  set lines=999
  set columns=999
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug-ins settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" NERDTree
"
" Leader-n to toggle NERDTree
map <leader>n :NERDTreeToggle<CR>
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeDirArrows = 1
let NERDTreeMinimalUI = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden = 1
"
" Airline
"
" Use powerline fonts
let g:airline_powerline_fonts = 1
"
" Airline extensions
"
" Ale extension
let g:airline#extensions#ale#enabled = 1
" Tabs extension
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
"
" NERDCommenter
"
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1
"
" Ale
"
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 1
"
" CtrlP
"
let g:ctrlp_custom_ignore = '\v[\/]\.(git|meteor|node_modules|demeteorized|build)$'
"
" Vim Indent Guides
"
let g:indent_guides_enable_on_vim_startup = 1
"
" Supertab
"
" Use Tab instead of Ctrl-N / Ctrl-P
let g:SuperTabDefaultCompletionType = "<c-n>"
"
" Minimap
"
" Toggle Minimap
map <leader>m :MinimapToggle<CR>
"
" JsDoc
"
" Add JsDoc comment
map <leader>j :JsDoc<CR>
