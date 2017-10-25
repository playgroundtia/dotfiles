" Use Vim settings, rather than Vi settings
set nocompatible

" Check color support
if (&t_Co > 2 || has("gui_running"))
  " Enable syntax highlighting
  syntax on

  " Enable last used search pattern highlighting
  set hlsearch

  " Enable cursor line highlighting
  set cursorline

  " Enable support for 256 colors
  set t_Co=256

  " Enable overlength line highlighting
  if exists('+colorcolumn')
    set colorcolumn=80
  else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
  endif

  " Enable trailing whitespace hightlighting
  highlight WhitespaceEOL ctermbg=DarkRed
  match WhitespaceEOL /\s\+$/
endif

" Enable mouse support
set mouse=a

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

" Shortcuts
cab W! w!
cab Q! q!
cab Wq wq
cab Wa wa
cab wQ wq
cab WQ wq
cab W w
cab Q q
