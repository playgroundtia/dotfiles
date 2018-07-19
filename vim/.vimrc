" Use Vim settings
set nocompatible

""""""""""
" Plug-ins
""""""""""
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
Plug 'elzr/vim-json'
Plug 'sheerun/vim-polyglot'
" Linters
Plug 'vim-syntastic/syntastic'
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
" Helpers
Plug 'brooth/far.vim'
Plug 'ervandew/supertab'
" Code completion
if has('nvim') || ((v:version >= 800) && has("python3"))
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  elseif (v:version >= 800) && has("python3")
    Plug 'Shougo/deoplete.nvim', { 'do': 'if [[ \"$(uname)\" == \"Linux\" ]]; then sudo apt update && sudo apt install -y python3-pip; else brew update && brew install python3; fi; pip3 install neovim' }
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif
  let g:deoplete#enable_at_startup = 1

  " JavaScript
  Plug 'carlitux/deoplete-ternjs', { 'do': 'sudo yarn global add tern --ignore-optional' }
endif
call plug#end()

""""""""""""""
" Vim settings
""""""""""""""
" Theme
colorscheme dracula
let g:airline_theme = 'dracula'
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

"""""
" GUI
"""""
if has('gui_running')
  " Font
  set guifont=Hack\ 10
  " Remove menu bar
  set guioptions-=m
  " Remove toolbar
  set guioptions-=T
  " Remove right-hand scroll bar
  set guioptions-=R
  set guioptions-=r
  " Remove left-hand scroll bar
  set guioptions-=L
  set guioptions-=l
endif

"""""""""""""""""""
" Plug-ins settings
"""""""""""""""""""
" NERDTree
map <C-\> :NERDTreeToggle<CR>
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeDirArrows = 1
let NERDTreeMinimalUI = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden = 1
" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
set lazyredraw
set laststatus=2
" NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1
" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
" CtrlP
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git'
