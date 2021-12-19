""""""""""""""""""""""""""""""""""""""""
" settings for pangloss/vim-javascript "
""""""""""""""""""""""""""""""""""""""""

let g:javascript_plugin_jsdoc = 1

augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END


""""""""""""""""""""""""""""""""""""""""""""
" settings for peitalin/vim-jsx-typescript "
""""""""""""""""""""""""""""""""""""""""""""

" set filetypes as typescriptreact
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

" JSX Tag colors

" dark red
hi tsxTagName guifg=#E06C75
hi tsxComponentName guifg=#E06C75
hi tsxCloseComponentName guifg=#E06C75
" orange
hi tsxCloseString guifg=#F99575
hi tsxCloseTag guifg=#F99575
hi tsxCloseTagName guifg=#F99575
hi tsxAttributeBraces guifg=#F99575
hi tsxEqual guifg=#F99575
" yellow
hi tsxAttrib guifg=#F8BD7F cterm=italic

" JSX Generics

" light-grey
hi tsxTypeBraces guifg=#999999
" dark-grey
hi tsxTypes guifg=#666666

" Others
hi ReactState guifg=#C176A7
hi ReactProps guifg=#D19A66
hi ApolloGraphQL guifg=#CB886B
hi Events ctermfg=204 guifg=#56B6C2
" hi ReduxKeywords ctermfg=204 guifg=#C678DD
" hi ReduxHooksKeywords ctermfg=204 guifg=#C176A7
hi WebBrowser ctermfg=204 guifg=#56B6C2
hi ReactLifeCycleMethods ctermfg=204 guifg=#D19A66
