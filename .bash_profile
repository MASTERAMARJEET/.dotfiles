[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
[ -f "$HOME/.bash_exports" ] && . "$HOME/.bash_exports"
[ -f  "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
[ -f "/home/amar/software/google-cloud-sdk/path.bash.inc" ] && . "/home/amar/software/google-cloud-sdk/path.bash.inc"

# The next line enables shell command completion for gcloud.
[ -f "/home/amar/software/google-cloud-sdk/completion.bash.inc" ] && . "/home/amar/software/google-cloud-sdk/completion.bash.inc"

if [[ "$(tty)" = "/dev/tty1" ]]; then
	startx
fi
