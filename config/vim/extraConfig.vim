" Basics
set history=100
filetype plugin on
filetype indent on
set autoread
syntax on
set ruler

" Tabs
set noautoindent
set shiftwidth=4
set softtabstop=4
set expandtab

" Completion
set wildmode=longest,list,full
set wildmenu
set wildignore=*.o,*~,*.pyc,*.javac
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
set path+=**

" Linum
set number
set numberwidth=4
set relativenumber

" Search
set ignorecase
set smartcase
set nohlsearch

" Clipboard
set clipboard+=unnamedplus

" Remove annoying sounds
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" No backups or swap files
set nobackup
set noswapfile
set nowb

" Line wrap
set wrap

" Colors
colorscheme nord
let g:lightline = {
    \ 'colorscheme': 'nord',
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' }
    \ }
set laststatus=2
set noshowmode
