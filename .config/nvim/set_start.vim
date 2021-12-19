" <----------Setup for startify------------>
let g:startify_lists = [
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']                    },
          \ { 'type': 'files',     'header': ['   Recent']                       },
          \ { 'type': 'dir',       'header': ['   Current Directory '.getcwd()] },
          \ ]
let g:startify_bookmarks = [
            \ { 'n': '~/.config/nvim/init.vim' },
            \ { 'b': '~/.bashrc' },
            \ ]

