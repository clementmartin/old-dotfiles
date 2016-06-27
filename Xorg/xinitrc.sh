#!/bin/bash

include_file /etc/X11/xinit/xinitrc.d/00-start-message-bus.sh

include_file ~/.fehbg

setxkbmap -layout us -option -option ctrl:nocaps -option compose:ralt

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

xset +dpms dpms 0 0 600

xautolock &


ssh-add

exec spectrwm
