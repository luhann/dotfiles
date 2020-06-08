#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# exec gnome-session
# exec startkde
# exec startxfce4
export SXHKD_SHELL='/usr/bin/sh'
numlockx &
setxkbmap -option caps:super
# xrandr --output HDMI-A-0 --primary --right-of DisplayPort-0
xrandr --output DisplayPort-0 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-A-0 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --output DVI-D-0 --off --output DVI-D-1 --off
exec dbus-run-session bspwm
