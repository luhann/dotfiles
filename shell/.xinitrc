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

xrandr --output DisplayPort-0 --primary --mode 2560x1440 --rate 165 --pos 0x0 --rotate normal --output DisplayPort-1 --mode 2560x1440 --rate 165 --left-of DisplayPort-0 --rotate normal

# lock screen
xset s on
xss-lock -n /usr/libexec/xsecurelock/dimmer -l -- xsecurelock &

pipewire &
pipewire-pulse &

case "$2" in
        bspwm)
                export SXHKD_SHELL='/usr/bin/sh'
                /usr/bin/xcalib -d :0 /home/khonsu/desktop/dell_s2721.icc
                /usr/lib/libexec/polkit-kde-authentication-agent-1 &
                exec dbus-run-session bspwm
                ;;
        kde)    
                exec dbus-run-session startplasma-x11
                ;;

        *) 
                export SXHKD_SHELL='/usr/bin/sh'
                /usr/lib/libexec/polkit-kde-authentication-agent-1 &
                exec dbus-run-session bspwm
                ;;
esac
