"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Environment
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:uname = substitute(system('uname'), '[[:cntrl:]]', '', 'g')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.dotfiles/vim/autoload/plug.vim'))
  silent execute '!curl -fLo ~/.dotfiles/vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Compatibility
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'tpope/vim-sensible'
Plug 'rstacruz/vim-opinion'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tmux-plugins/vim-tmux'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Themes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'morhetz/gruvbox'
Plug 'shinchu/lightline-gruvbox.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'jszakmeister/vim-togglecursor'
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'
Plug 'lilydjwg/colorizer'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Languages support
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'sheerun/vim-polyglot'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Linters
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'w0rp/ale'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File management
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ctrlpvim/ctrlp.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Git
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Windows and buffers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'artnez/vim-wipeout', { 'on': 'Wipeout' }
Plug 'simeji/winresizer', { 'on': 'WinResizerStartResize' }
Plug 'vim-scripts/ZoomWin', { 'on': 'ZoomWin' }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'heavenshell/vim-jsdoc', { 'on': 'JsDoc' }
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Clipboard
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'svermeulen/vim-easyclip'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/neoyank.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Helpers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'brooth/far.vim', { 'on': ['Far', 'Farundo', 'Farp', 'Farundo'] }
Plug 'editorconfig/editorconfig-vim'
Plug 'kristijanhusak/vim-carbon-now-sh'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-repeat'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'myusuf3/numbers.vim'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Unset the LAST SEARCH PATTERN register by hitting return
nnoremap <silent> <CR> :noh<CR><CR>
" Enable cursor line highlighting
set cursorline
" Enable overlength line highlighting
set colorcolumn=80
" Disable mouse
set mouse=
if !has('nvim')
  set ttymouse=
endif
" Set update interval
set updatetime=100
" No annoying sounds
set noerrorbells visualbell t_vb=
augroup mute_sounds
  autocmd GUIEnter * set visualbell t_vb=
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Aliases
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set leader key to ,
let g:mapleader = ','
" Copy to / from external clipboard
if s:uname ==# 'Darwin'
  map <leader>y :w !pbcopy<CR>
  map <leader>p :r !pbpaste \| sed 's/^ *//;s/ *$//'<CR>
elseif s:uname ==# 'Linux'
  map <leader>y :w !xsel -i -b<CR>
  map <leader>p :r !xsel -p \| sed 's/^ *//;s/ *$//'<CR>
endif
" Use F5 to switch buffers
nnoremap <F5> :buffers<CR>:buffer<Space>
" Use F6 to vertically split the current window and select a buffer
nnoremap <F6> :vsplit<CR>:buffers<CR>:buffer<Space>
" Use F7 to horizontally split the current window and select a buffer
nnoremap <F7> :split<CR>:buffers<CR>:buffer<Space>
" Reload settings
nmap <Leader>s :source $MYVIMRC<CR>
" Edit settings
nmap <Leader>v :e $MYVIMRC<CR>
" Disable arrow keys
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>
" Open with Atom
nnoremap <leader>a :execute "!atom " . expand("%") . ":" . line(".") \| redraw!<CR>
" Open with Visual Studio Code
nnoremap <leader>c :execute "!code --goto " . expand("%") . ":" . line(".") \| redraw!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme / GUI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme gruvbox
set background=dark

if has('gui_running')
  if s:uname ==# 'Darwin'
    " Font
    set guifont=Hack\ Regular\ Nerd\ Font\ Complete:h10
  elseif s:uname ==# 'Linux'
    " Font
    set guifont=Hack\ 10
  endif

  " Remove menu
  set guioptions=
  " Maximize window
  set lines=999 columns=999
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle NERDTree
map <leader>n :NERDTreeToggle<CR>
" Close vim if the only window left open is NERDTree
augroup nerdtree
  autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END
" Automatically remove a buffer when a file is being deleted via a context menu
let g:NERDTreeAutoDeleteBuffer = 1
" Disable display of the 'Bookmarks' label
let g:NERDTreeMinimalUI = 1
" Close the tree window after opening a file
let g:NERDTreeQuitOnOpen = 1
" Display hidden files by default
let g:NERDTreeShowHidden = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lightline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
  \ 'colorscheme': 'gruvbox',
\ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDCommenter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ale
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Never lint on change
let g:ale_lint_on_text_changed = 'never'
" Lint on save
let g:ale_lint_on_save = 1
" Fix on save
let g:ale_fix_on_save = 1
" Lint on enter
let g:ale_lint_on_enter = 1
" Compatible linters
let g:ale_linters = {
  \ 'python': ['flake8', 'pylint'],
  \ 'javascript': ['eslint'],
  \ 'typescript': ['tslint'],
  \ 'vue': ['eslint'],
  \ 'vim': ['vint'],
\ }
" Compatible fixers
let g:ale_fixers = {
  \ 'html': ['prettier'],
  \ 'scss': ['prettier'],
  \ 'css': ['prettier'],
  \ 'javascript': ['prettier', 'eslint'],
  \ 'typescript': ['prettier', 'tslint'],
  \ 'vue': ['prettier', 'eslint'],
  \ 'python': ['black'],
\ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ignore files and folders
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|node_modules)$',
  \ 'file': '\v\.(gitkeep|log|gif|jpg|jpeg|png|psd|DS_Store|)$'
\ }
" Show hidden files
let g:ctrlp_show_hidden = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" JsDoc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle JsDoc
map <leader>j :JsDoc<CR>
" Enable ECMASCript 6 support
let g:jsdoc_enable_es6 = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Multiple Cursors
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quit from multicursor mode
let g:multi_cursor_quit_key = '<Esc>'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EasyMotion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable default mappings
let g:EasyMotion_do_mapping = 0
" Jump to anywhere
nmap f <Plug>(easymotion-overwin-f)
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Carbon.now.sh
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Query params
let g:carbon_now_sh_options = 't=dracula&ln=true&fm=Hack'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Winresizer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle WinResizerStartResize
map <leader>r :WinResizerStartResize<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Easyclip
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Place the cursor at the end
let g:EasyClipAlwaysMoveCursorToEndOfPaste = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" WinResizer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle WinResizer
map <leader>r :WinResizerStartResize<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ZoomWin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle ZoomWin
map <leader>z :ZoomWin<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !exists('g:ycm_semantic_triggers')
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Incsearch
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
