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

# Urxvt daemon
# run urxvtd -q -o -f

# Mpv input file
# if [ ! -e /tmp/mpv.fifo ]; then
#     mkfifo /tmp/mpv.fifo
# fi

# Desktop effects
picom --config ~/.config/picom/picom.conf -b

# redshift
# pkill -f '^redshift'
# run redshift -l -33.96:18.47 -b 1.0:0.5

# sxhkd
run sxhkd

# dunst
run dunst

# polybars
pkill -f '^polybar'
polybar top-primary &
polybar top-secondary &

# Network manager tray icon

# Wallpaper
# (Already set to run in rc.lua)
run wallpaper

