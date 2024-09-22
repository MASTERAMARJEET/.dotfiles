bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

git_branch() {
	git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/{\1}/'
}

setopt PROMPT_SUBST
PS1='%b%F{11}%n@%m %{%B%F{111}%}%c %b%F{120}$(git_branch)
%f$ %'


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias dir='dir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias py='python3'
alias lt='ls -rt'
alias lg='lazygit'
alias lz='lazydocker'
alias envon='conda activate'
alias envoff='conda deactivate'
# alias p='pipenv'
alias nosleep='xset s off -dpms'
alias sleep='systemctl suspend'
alias vim='nvim --clean'

## lf config
[ -f ~/.config/lf/lfcd ] && . ~/.config/lf/lfcd
[ -f ~/.config/lf/icons ] && . ~/.config/lf/icons

alias f="lfcd"

# File shortcut definitions.
[ -f ~/.zsh_aliases ] && . ~/.zsh_aliases

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/amar/miniconda3/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
# if [ $? -eq 0 ]; then
# 	eval "$__conda_setup"
# else
# 	if [ -f "/home/amar/miniconda3/etc/profile.d/conda.sh" ]; then
# 		. "/home/amar/miniconda3/etc/profile.d/conda.sh"
# 	else
# 		export PATH="/home/amar/miniconda3/bin:$PATH"
# 	fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<

eval "$(pyenv init -)"


# node version manager (fnm)
eval "$(fnm env)" >/dev/null

