" Plugins
let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs 
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin(expand('~/.vim/plugged'))

" Color schemes
Plug 'drewtempelmeyer/palenight.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'LunarVim/lunar.nvim'

" Essentials
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'mhinz/vim-startify'

call plug#end()

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
set nocompatible
syntax on
filetype on
filetype plugin on
filetype plugin indent on
set nobackup

"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

"" Map leader to ,
let mapleader=' '

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set showmatch
set history=100
"set smartcase
"set ignorecase

set fileformats=unix,dos,mac

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

" session management
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

let no_buffers_menu=1

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
set ruler
set number
set cursorline
"set cursorcolumn

" Color
set background=dark
set term=xterm-256color
set t_Co=256
set t_ut=
"let g:solarized_termcolors=256 " required for solarized
colorscheme gruvbox

" Better command line completion 
set wildmenu
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" mouse support
set mouse=a
set mousemodel=popup

" Status line
set statusline=
set statusline+=\ %F\ %M\ %Y\ %R
set statusline+=%=
set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%
set laststatus=2

"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" google/vim-codefmt
"call glaive#Install()
"Glaive codefmt google_java_executable="java -jar /usr/local/bin/google-java-format-1.16.0-all-deps.jar"
