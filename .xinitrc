
# Down scale to a lower resolution
xrandr --output eDP-1 --mode 1600x900

xmodmap ~/.Xmodmap
exec awesome
# exec qtile start
