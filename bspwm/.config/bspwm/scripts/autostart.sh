#!/usr/bin/env bash
# ---
# Use "run program" to run it only if it is not already running
# Use "program &" to run it regardless
# ---
# NOTE: This script runs with every restart of AwesomeWM
# If you would like to run a command *once* on login,
# you can use ~/.xprofile

function run {
    if ! pgrep $1 > /dev/null ;
    then
        $@ &
    fi
}

# Music
# run mpd
# (Alternatively, enable the mpd service so mpd runs on login)

# Emacs daemon
#run emacs --daemon

# Load terminal colorscheme and settings
xrdb ~/.Xresources
xsetroot -cursor_name left_ptr

# Urxvt daemon
# run urxvtd -q -o -f

# Mpv input file
# if [ ! -e /tmp/mpv.fifo ]; then
#     mkfifo /tmp/mpv.fifo
# fi

# Desktop effects
run picom --config ~/.config/picom/picom.conf

# redshift
pkill -f '^redshift'
run redshift -l 33.5:18.2 -b 1.0:0.6

# sxhkd
run sxhkd

# dunst
run dunst

# polybars
pkill -f '^polybar'
polybar top-primary &
polybar top-secondary &

# Enable numlock on login
# Required numlockx to be installed
# run numlockx

# Network manager tray icon
# run nm-applet

# Kill redshift processes
# pkill redshift

# Wallpaper
# (Already set to run in rc.lua)
run wal -q -i ~/onedrive/wallpapers/
