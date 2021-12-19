" <----------Remaps---------->


" Disabling the arrow-keys in normal mode
nnoremap <Down> <Nop>
nnoremap <Up> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Right> <Nop>

" Copy paste shortcuts
noremap <leader>y "+y
noremap <leader>p "+p
noremap <A-Up> YP
noremap <A-Down> Yp
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Remaps for pre-reserved keys and easy navigation
noremap <leader>v <C-V>
nnoremap <leader>t :tabnew
nnoremap <leader>b :split term://bash<CR> :resize 6<CR>
map <leader>m <C-w>
:tnoremap <Esc> <C-\><C-n>
:tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
:tnoremap <C-h> <C-\><C-N><C-w>h
:tnoremap <C-j> <C-\><C-N><C-w>j
:tnoremap <C-k> <C-\><C-N><C-w>k
:tnoremap <C-l> <C-\><C-N><C-w>l
:inoremap <C-h> <C-\><C-N><C-w>h
:inoremap <C-j> <C-\><C-N><C-w>j
:inoremap <C-k> <C-\><C-N><C-w>k
:inoremap <C-l> <C-\><C-N><C-w>l
:nnoremap <C-h> <C-w>h
:nnoremap <C-j> <C-w>j
:nnoremap <C-k> <C-w>k
:nnoremap <C-l> <C-w>l

" Surround selection with ()
:vnoremap ,s( c()<Esc>Pl%
:vnoremap ,s" c""<Esc>Pl

" Code folding.
noremap <C-f> zM
noremap <C-g> zR
noremap zz zA

" NERDCommentor remaps
nnoremap <leader>c :call nerdcommenter#Comment('n', 'Toggle')<CR>
vnoremap <leader>c :call nerdcommenter#Comment('x', 'Toggle')<CR>

" Floaterm remaps
nnoremap <leader>nt :FloatermNew<CR>
nnoremap <leader>ng :FloatermNew --height=0.8 --width=0.8 lazygit<CR>
nnoremap <leader>np :FloatermNew python<CR>
nnoremap <leader>ni :FloatermNew ipython<CR>

""" Misc.
" save and source
nnoremap <C-s> :w %<CR> :so %<CR>
" aliasing : to ; as ; is frequently used
nnoremap ; :
" Correct spelling
inoremap <M-l> <c-g>u<Esc>[s1z=`]a<c-g>u
" Better Tabing
vnoremap < <gv
vnoremap > >gv
" nnoremap <M-j> :tabnew /home/amar/.config/nvim/UltiSnips/tex.snippets<CR>
