#!/bin/sh

run()
{
  if ! pgrep -f "$1"; then
    "$@" &
  fi
}

run setxkbmap -option ctrl:nocaps
run xidlehook --detect-sleep --not-when-audio --timer 1 'dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1/session/self org.freedesktop.login1.Session.SetIdleHint boolean:true' 'dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1/session/auto org.freedesktop.login1.Session.SetIdleHint boolean:false'
run setxkbmap -option ctrl:nocaps && xcape -e 'Caps_Lock=Escape' -t 100
run "${HOME}/.config/picom/picom.sh"
run libinput-gestures-setup start
run rog-control-center
run alacritty
