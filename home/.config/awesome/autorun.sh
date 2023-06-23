#!/bin/sh

run()
{
  if ! pgrep -f "$1"; then
    "$@" &
  fi
}

run setxkbmap -option ctrl:nocaps
# run setxkbmap -option ctrl:nocaps && xcape -e 'Caps_Lock=Escape' -t 100
run "${HOME}/.config/picom/picom.sh"
run alacritty
run xidlehook --detect-sleep --not-when-audio --timer 300 'systemctl suspend' ''
run libinput-gestures-setup start
run rog-control-center
