#!/usr/bin/env sh

# Terminate already running bar instances
killall -q picom

# Launch polybar
picom --experimental-backends --config $HOME/.config/picom/picom.conf &
