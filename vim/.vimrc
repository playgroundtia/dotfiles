" Use Vim settings
set nocompatible

" Plug
call plug#begin()
" Compatibility
Plug 'tpope/vim-sensible'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tmux-plugins/vim-tmux'
" Appearance
Plug 'dracula/vim', { 'as': 'dracula' }
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

" Set swap files directory
set directory=/tmp

" Set backup files directory
set backupdir=/tmp

" Auto reload files when they change
set autoread

" Set update interval
set updatetime=100

" GUI
colorscheme dracula
let g:airline_theme = 'dracula'
set guifont=Hack\ 10

" NERDTree
map <C-\> :NERDTreeToggle<CR>
autocmd VimEnter * if !argc() | NERDTree | endif
autocmd BufEnter * if !argc() | NERDTreeMirror | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
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

" Vim-javascript
let g:javascript_plugin_jsdoc = 1

" Vim-jsx
let g:jsx_ext_required = 1
let g:javascript_plugin_ngdoc = 1

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
