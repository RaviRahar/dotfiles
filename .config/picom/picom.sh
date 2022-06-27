#!/usr/bin/env sh

# Terminate already running instances
killall -q picom

# Launch picom
picom --experimental-backends --config $HOME/.config/picom/picom.conf &
