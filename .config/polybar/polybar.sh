#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Launch polybar
polybar top -c $HOME/.config/polybar/config.ini &
