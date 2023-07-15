#!/bin/sh

run()
{
  if ! pgrep -f "$1"; then
    "$@" &
  fi
}

run xset r rate 200 25
run setxkbmap -option ctrl:nocaps
# run setxkbmap -option ctrl:nocaps && xcape -e 'Caps_Lock=Escape' -t 100
run "${HOME}/.config/picom/picom.sh"
run alacritty
# xautolock -time 10 -locker "dm-tool lock; dbus-send --system --print-reply --dest='org.freedesktop.UPower' /org/freedesktop/UPower org.freedesktop.UPower.Suspend"
run xautolock -time 10 -locker "systemctl suspend"
run libinput-gestures-setup start
run rog-control-center
# xset -q
# sudo kbdrate -r 10.9 -d 250
