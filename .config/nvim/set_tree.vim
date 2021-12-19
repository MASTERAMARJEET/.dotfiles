" <----------NERDTree settings--------->

" autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeWinPos = "right"

noremap <C-n> :NERDTreeToggle<CR>

" <----------nerdtree-git-plugin settings--------->
let g:NERDTreeGitStatusConcealBrackets = 1
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'M',
                \ 'Staged'    :'+',
                \ 'Untracked' :'U',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✕',
                \ 'Dirty'     :'⌾',
                \ 'Ignored'   :'⊘',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }
