#This file contains shortcuts for easy navigation. Should not be run directly.

alias nh='cd ~/.config/nvim && vi init.lua'
alias bs='vi ~/.bashrc'
alias mcmd="matlab -nosplash -nodesktop"
alias tm='vi ~/.tmux.conf'
alias vba='envoff && source ./venv/bin/activate'
alias c='cd $(fd . "/home/amar/" -t d| fzf)'
alias c.='cd $(fd . -t d| fzf)'
alias ch='cd $(fd . "/home/amar/" -t d -H| fzf)'
alias v='vi $(fd . -t f| fzf)'
alias vh='vi $(fd . -t f -H| fzf)'
