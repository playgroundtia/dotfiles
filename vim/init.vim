""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Encoding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
scriptencoding utf-8

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
Plug 'danilo-augusto/vim-afterglow'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline-themes'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'jszakmeister/vim-togglecursor'
Plug 'lilydjwg/colorizer'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'RRethy/vim-illuminate'
Plug 'inside/vim-search-pulse'
Plug 'vim-scripts/CursorLineCurrentWindow'

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
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-vinegar'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Git
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Windows and buffers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'artnez/vim-wipeout', { 'on': 'Wipeout' }
Plug 'simeji/winresizer', { 'on': 'WinResizerStartResize' }
Plug 'vim-scripts/ZoomWin', { 'on': 'ZoomWin' }
Plug 'vim-scripts/bufexplorer.zip', { 'on': 'BufExplorer' }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'heavenshell/vim-jsdoc', { 'on': 'JsDoc' }
Plug 'mbbill/undotree'
Plug 'roxma/vim-paste-easy'
Plug 'sickill/vim-pasta'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
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
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'brooth/far.vim', { 'on': ['Far', 'Farundo', 'Farp', 'Farundo'] }
Plug 'ervandew/supertab'
Plug 'editorconfig/editorconfig-vim'
Plug 'kristijanhusak/vim-carbon-now-sh'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-repeat'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'myusuf3/numbers.vim'
Plug 'majutsushi/tagbar'

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

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set timeoutlen=500
if has('gui_macvim')
  augroup macvim
    autocmd GUIEnter * set vb t_vb=
  augroup END
endif

" Use ripgrep over grep if avaiable
if executable('rg')
  set grepprg=rg\ --color=never
endif

" Store the undo files in a seperate place
if has('persistent_undo')
  try
    set undodir='~/.dotfiles/vim/undodir'
    set undofile
  catch
  endtry
endif

" Set leader key to ,
let g:mapleader = ','

" Disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Use Unix as the standard file type
set fileformats=unix,dos,mac

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Clipboard
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('clipboard')
  set clipboard^=unnamed,unnamedplus
elseif s:uname ==# 'Darwin'
  map <leader>y :w !pbcopy<CR>
  map <leader>p :r !pbpaste<CR>
elseif s:uname ==# 'Linux'
  map <leader>y :w !xsel -i -b<CR>
  map <leader>p :r !xsel -p<CR>
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Terminal
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists('$TMUX')
  if has('nvim')
      set termguicolors
  else
      set term=screen-256color
  endif
endif

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM ==# 'gnome-terminal'
    set t_Co=256
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Aliases
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Source vimrc
nmap <Leader>s :source $MYVIMRC<CR>

" Edit vimrc
nmap <Leader>v :edit $MYVIMRC<CR>

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
command W w !sudo tee % > /dev/null

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme / GUI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
  colorscheme gruvbox
  let g:airline_theme='gruvbox'
catch
  colorscheme desert
  let g:airline_theme='desert'
endtry
set background=dark

if has('gui_running')
  if s:uname ==# 'Darwin'
    set guifont=Hack\ Regular\ Nerd\ Font\ Complete:h10
  elseif s:uname ==# 'Linux'
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

" Ignore folders and files
let g:NERDTreeIgnore = [
\ '^\.git$[[dir]]',
\ '^node_modules$[[dir]]',
\ '^dist$[[dir]]',
\ '^build$[[dir]]'
\ ]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Netrw
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
let g:netrw_localrmdir='rm -rf'
let g:netrw_list_hide = &wildignore

" Toggle netrw
let g:NetrwIsOpen=0
function! ToggleNetrw()
  if g:NetrwIsOpen
    let l:buffer = bufnr('$')
    while (l:buffer >= 1)
      if (getbufvar(l:buffer, '&filetype') ==# 'netrw')
        silent exe 'bwipeout ' . l:buffer
      endif
      let l:buffer-=1
    endwhile
    let g:NetrwIsOpen=0
  else
    let g:NetrwIsOpen=1
    silent Lexplore
  endif
endfunction
nnoremap <leader>e :call ToggleNetrw()<CR>

" Fix 'buffers of netrw don’t get closed'
augroup netrw
  autocmd FileType netrw setl bufhidden=delete
augroup END
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use powerline fonts
let g:airline_powerline_fonts = 1

" Tabs extension
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

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

" Airline extension
let g:airline#extensions#ale#enabled = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ignore files and folders
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|node_modules|dist)$',
  \ 'file': '\v\.(gitkeep|log|gif|jpg|jpeg|png|psd|DS_Store|)$'
\ }

" Show hidden files
let g:ctrlp_show_hidden = 1

" Disable per-session caching
let g:ctrlp_use_caching = 0

" Ripgrep
if executable('rg')
  " Use ripgrep in CtrlP for listing files
  let g:ctrlp_user_command = 'rg %s --files --hidden --follow --color=never --glob "!.git/*"'
else
  " Use grep in CtrlP, but skip files inside .gitignore
  let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
endif

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
" Deoplete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:deoplete#enable_at_startup = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Incsearch
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tagbar
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>t :TagbarToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Undotree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>u :UndotreeToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BufExplorer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>o :BufExplorer<CR>
