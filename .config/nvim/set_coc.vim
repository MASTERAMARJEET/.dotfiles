" <----------Coc Setup---------->
" all the settings are saved in ~/.config/nvim/plugged/coc_setup.vim

" FUNCTIONS
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#float#has_float() == 0 && CocHasProvider('hover') == 1)
    silent call CocActionAsync('doHover')
  else
    echon ''
  endif
endfunction

function! s:show_hover_doc()
  silent call timer_start(500, 'ShowDocIfNoDiagnostic')
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" EXTENSIONS
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \'coc-scssmodules',
  \'coc-marketplace',
  \'coc-json',
  \'coc-vimtex',
  \'coc-python',
  \'coc-flutter',
  \'coc-clangd',
  \ ]
" add peritter and eslint to extension list if present in local node_modules
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif
if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
" autocmd CursorHoldI * silent call <SID>show_hover_doc()
" autocmd CursorHold * silent call <SID>show_hover_doc()


" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <silent> <leader>rn <Plug>(coc-rename)

" Toggle error messages
nmap <leader>et :ToggleError<CR>

" Show error list
nnoremap <silent> <leader>el :CocList diagnostics<cr>
nmap <silent> <leader>en <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>ep <Plug>(coc-diagnostic-next)

" list of symbols in the project
nnoremap <silent> <leader>sm :CocList -I symbols<cr>

" perform code actions
nmap <leader>do <Plug>(coc-codeaction)

" Formatting selected code.
xmap <leader>f  :Format<CR>
nmap <leader>f  :Format<CR>

" Sort the imports
nmap <leader>si :SortImport<CR>

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType py, c, cpp setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 SortImport :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add :ToggleError command to toggle error messages current buffer.
command! -nargs=0 ToggleError :call CocAction('diagnosticToggle')

