[ -f "$HOME/.zsh_exports" ] && . "$HOME/.zsh_exports"
[ -f "$HOME/.zshrc" ] && . "$HOME/.zshrc"
[ -f  "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
[ -f "/home/amar/software/google-cloud-sdk/path.zsh.inc" ] && . "/home/amar/software/google-cloud-sdk/path.zsh.inc"

# The next line enables shell command completion for gcloud.
[ -f "/home/amar/software/google-cloud-sdk/completion.zsh.inc" ] && . "/home/amar/software/google-cloud-sdk/completion.zsh.inc"

if [[ "$(tty)" = "/dev/tty1" && "$OSTYPE" == "linux-gnu" ]]; then
	startx
fi
