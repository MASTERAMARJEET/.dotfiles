syntax on

filetype plugin indent on

set encoding=utf8
set spelllang=en_us
set noerrorbells
set noshowmode
set hidden
set scrolloff=8
set nu
set nornu
set nowrap
set ruler
set smartcase
set noswapfile
set nobackup
set nowritebackup
set updatetime=200
set signcolumn=yes
set undodir=~/.config/nvim/undodir
set undofile
set nohlsearch
set incsearch
set cmdheight=1
set splitbelow
set splitright
set listchars=tab:→\ ,trail:¬
" set listchars=tab:↦\ ,trail:¬
" set listchars=tab:»\ ,trail:¬
set list
set colorcolumn=80,100
set cursorline
set wildignore+=*/node_modules/*

" Tabs and indentation
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set autoindent
autocmd Filetype python setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd Filetype sh setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd Filetype markdown setlocal wrap linebreak
autocmd Filetype tex setlocal noexpandtab spell wrap linebreak

autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" Folding
set foldmethod=indent
set foldlevel=5

" Trim trailing whitespaces
autocmd FileType c,cpp,python autocmd BufWritePre <buffer> %s/\s\+$//e

let mapleader=","
let c_gnu=1
let g:python_highlight_all=1

let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall


" Clear cmd line message
function! s:empty_message(timer)
  if mode() ==# 'n'
    echon ''
  endif
endfunction

augroup cmd_msg_cls
    autocmd!
    autocmd CmdlineLeave :  call timer_start(100, funcref('s:empty_message'))
augroup END
