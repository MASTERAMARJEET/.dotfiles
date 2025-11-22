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


# bun completions
[ -s "~/.bun/_bun" ] && source "~/.bun/_bun"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/amar/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/amar/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/amar/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/amar/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/amar/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

