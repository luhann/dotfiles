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

xrdb -merge ~/.Xresources
xsetroot -cursor_name left_ptr

# lock screen
xset s on
xss-lock -n /usr/libexec/xsecurelock/dimmer -l -- xsecurelock &



case "$2" in
        bspwm)
                export SXHKD_SHELL='/usr/bin/sh'
                /usr/bin/xcalib -d :0 /home/khonsu/desktop/dell_s2721.icc
                /usr/libexec/polkit-kde-authentication-agent-1 &
                exec bspwm
                ;;
        kde)    
                exec startplasma-x11
                ;;
        awesome)
                export DESK_MAN="awesomewm"
                /usr/bin/xcalib -d :0 /home/khonsu/desktop/dell_s2721.icc
                /usr/libexec/polkit-kde-authentication-agent-1 &
                exec awesome
                ;;

        *) 
                export SXHKD_SHELL='/usr/bin/sh'
                /usr/libexec/polkit-kde-authentication-agent-1 &
                exec bspwm
                ;;
esac
