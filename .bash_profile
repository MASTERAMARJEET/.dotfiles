# include .bashrc if it exists
[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"

[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -f  "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

export VISUAL=vim
export EDITOR="$VISUAL"
