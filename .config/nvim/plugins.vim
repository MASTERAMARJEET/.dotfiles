" <---------Plugins---------->

call plug#begin('~/.config/nvim/plugged')

" Plug 'jremmen/vim-ripgrep'
" Plug 'vim-utils/vim-man'

" GIT SUPPORT
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'

" CODE EASY
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'
Plug 'sirver/ultisnips'
Plug 'tpope/vim-surround'
Plug 'AndrewRadev/tagalong.vim'

" AUTOCOMPLETE
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" HELPER WINDOWS
Plug 'preservim/nerdtree'
Plug 'voldikss/vim-floaterm'
Plug 'https://github.com/kien/ctrlp.vim'
" Plug 'Shougo/vimfiler.vim'

" ASTHETICS
Plug 'vim-airline/vim-airline'
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons'

" THEMES
" Plug 'morhetz/gruvbox'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
" Plug 'cocopon/iceberg.vim'
Plug 'ghifarit53/tokyonight-vim'
" Plug 'ayu-theme/ayu-vim'
" Plug 'drewtempelmeyer/palenight.vim'
" Plug 'sonph/onehalf', { 'rtp': 'vim' }

" WEB DEV
Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
" Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
" Plug 'jparise/vim-graphql'

" LATEX
Plug 'lervag/vimtex'
" Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
" Plug 'lervag/vimtex', {'tag': 'v1.6'}

" PYTHON
Plug 'vim-python/python-syntax'

" FLUTTER
Plug 'dart-lang/dart-vim-plugin'
call plug#end()

