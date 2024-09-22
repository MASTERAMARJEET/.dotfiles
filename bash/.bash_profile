[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
[ -f "$HOME/.bash_exports" ] && . "$HOME/.bash_exports"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# The next line updates PATH for the Google Cloud SDK.
[ -f "/home/amar/software/google-cloud-sdk/path.bash.inc" ] && . "/home/amar/software/google-cloud-sdk/path.bash.inc"

# The next line enables shell command completion for gcloud.
[ -f "/home/amar/software/google-cloud-sdk/completion.bash.inc" ] && . "/home/amar/software/google-cloud-sdk/completion.bash.inc"

if [[ "$(tty)" = "/dev/tty1" ]]; then
	startx
fi
