[ -f "$HOME/.zsh_exports" ] && . "$HOME/.zsh_exports"
[[ -f "$HOME/.zshrc" && "$OSTYPE" == "linux-gnu" ]] && . "$HOME/.zshrc"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"


# The next line updates PATH for the Google Cloud SDK.
[ -f "/home/amar/software/google-cloud-sdk/path.zsh.inc" ] && . "/home/amar/software/google-cloud-sdk/path.zsh.inc"

# The next line enables shell command completion for gcloud.
[ -f "/home/amar/software/google-cloud-sdk/completion.zsh.inc" ] && . "/home/amar/software/google-cloud-sdk/completion.zsh.inc"

if [[ "$(tty)" = "/dev/tty1" && "$OSTYPE" == "linux-gnu" ]]; then
	startx
fi

[ -f "/opt/homebrew/bin/brew" ] && eval "$(/opt/homebrew/bin/brew shellenv)"
