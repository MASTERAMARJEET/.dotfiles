[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
[ -f "$HOME/.bash_exports" ] && . "$HOME/.bash_exports"
[ -f  "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

if [[ "$(tty)" = "/dev/tty1" ]]; then
	startx
fi
