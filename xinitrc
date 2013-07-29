xset s off
xset -dpms
setxkbmap dk
xmodmap ~/.Xmodmap
xrdb -load ~/.Xresources
exec awesome
