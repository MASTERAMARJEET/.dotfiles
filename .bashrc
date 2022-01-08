# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# enabling vi mode in vim
set -o vi
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# when using kitty, set the $TERMINFO correctly
if [[ "$TERM" == "xterm-kitty" ]]; then
  export TERMINFO="/usr/share/terminfo/"
fi


# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=no
    fi
fi

# This function gets the git branch (if any)
git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/{\1}/'
}

# Auto activate conda environments
conda_auto_env() {
  if [ -e "environment.yml" ]; then
    ENV_NAME=$(head -n 1 environment.yml | cut -f2 -d ' ')
    # Check if you are already in the environment
    if [[ $CONDA_PREFIX != *$ENV_NAME* ]]; then
      # Try to activate environment
      conda activate $ENV_NAME &>/dev/null
    fi
  fi
}

# Auto activate pipenv environments
auto_pipenv() {
  # ENV_NAME=$(pipenv --venv | awk -F'[/-]' '{print $(NF-1)}')
  if [ -e "Pipfile" ]
  then
    if [[ $PIPENV_ACTIVE != 1 ]]
    then
        pipenv shell && clear
    elif [[ $CONDA_PREFIX != '' ]]
    then
        while [[ $CONDA_PREFIX != '' ]]
        do
            conda deactivate
        done
    fi
  fi
}

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[1;38;5;111m\]\W\[\033[0;38;5;120m\] $(git_branch)\[\033[00m\]\n\$ '
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[1;38;5;13m\]\u@\h: \W\[\033[0;38;5;50m\] $(git_branch)\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\[\033[1;38;5;111m\]\W\[\033[0;38;5;120m\] $(git_branch)\[\033[00m\]\n\$ '
    # PS1='${debian_chroot:+($debian_chroot)}\W $(git_branch)\$ '
    # PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W $(git_branch)\$ '
fi
unset color_prompt force_color_prompt

# overwriting the PS1 to instead use powerline format
# source ~/powerline.sh

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias cls='clear'
alias py='python3'
alias lt='ls -rt'
alias up='sudo apt update && sudo apt upgrade'
alias lg='lazygit'
alias envon='conda activate'
alias envoff='conda deactivate'
alias p='pipenv'

# export PROMPT_COMMAND="conda_auto_env;$PROMPT_COMMAND"
export PROMPT_COMMAND="auto_pipenv;$PROMPT_COMMAND"

## Adding stuff to PATH
export PATH=/usr/bin/latex:$PATH
export PATH=/home/amar/.local/bin:$PATH
# setting up ANDROID paths
export ANDROID_HOME=$HOME/Android
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/tools/bin:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
# ANDROID SDK
export ANDROID_SDK_ROOT=$ANDROID_HOME
export PATH=$ANDROID_SDK_ROOT:$PATH
# fixing sdkmanager error by adding alias
alias sdkman="sdkmanager"
alias avdman="avdmanager"

# adding gradle to PATH
export PATH=/opt/gradle/gradle-6.8.3/bin:$PATH

# adding flutter to PATH
export FLUTTER=$HOME/Codes/not_my_repo/flutter
export PATH=$FLUTTER/bin:$PATH
alias fltr="flutter"
alias frun="flutter run --enable-software-rendering"
alias fapk="flutter build apk --split-per-abi"

# adding conda to PATH
# export PATH="/home/amar/miniconda3/bin:$PATH"  # commented out by conda initialize

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

## lf config
# lf icon definitions.
if [ -f ~/.config/lf/lfcd ]; then
    . ~/.config/lf/lfcd
fi
if [ -f ~/.config/lf/icons ]; then
    . ~/.config/lf/icons
fi
alias f="lfcd"

# File shortcut definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

xhost local:amar > /dev/null

# >>> nvm setup >>>
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# <<< nvm setup >>>


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/amar/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/amar/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/amar/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/amar/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
. "$HOME/.cargo/env"

# pipenv setup
eval "$(_PIPENV_COMPLETE=bash_source pipenv)"


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION