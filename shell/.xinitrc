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

# xrandr --output eDP-1 --scale 1.25x1.25
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
xrandr --output eDP-1 --set "PRIME Synchronization" 1

xrdb -merge ~/.Xresources
xsetroot -cursor_name left_ptr

# lock screen
xset s on
xss-lock -n /usr/libexec/xsecurelock/dimmer -l -- xsecurelock &

setxkbmap us -variant colemak_dh -option caps:super
xcape -e 'Shift_L=parenleft;Shift_R=parenright'

case "$2" in
        bspwm)
                export SXHKD_SHELL='/usr/bin/sh'
                /usr/lib64/libexec/polkit-kde-authentication-agent-1 &
                exec bspwm
                ;;
        kde)    
                exec startplasma-x11
                ;;
        awesome)
                /usr/lib64/libexec/polkit-kde-authentication-agent-1 &
                exec awesome
                ;;

        *) 
                export SXHKD_SHELL='/usr/bin/sh'
                /usr/lib64/libexec/polkit-kde-authentication-agent-1 &
                exec bspwm
                ;;
esac
