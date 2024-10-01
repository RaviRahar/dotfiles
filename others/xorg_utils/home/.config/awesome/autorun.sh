#!/bin/sh

run()
{
  if ! pgrep "${1}*"; then
    echo "$@" >> ${HOME}/MYmy
    "$@" &
  fi
}

run xset r rate 200 25
run setxkbmap -option ctrl:nocaps
# run setxkbmap -option ctrl:nocaps && xcape -e 'Caps_Lock=Escape' -t 100
run "${HOME}/.config/picom/picom.sh"
run alacritty
# xautolock -time 10 -locker "dm-tool lock; dbus-send --system --print-reply --dest='org.freedesktop.UPower' /org/freedesktop/UPower org.freedesktop.UPower.Suspend"
# run xautolock -time 10 -locker "systemctl suspend"
# auto lock the screen
# run xautolock -detectsleep -time 10 -locker \"i3lock -i /usr/share/backgrounds/wallpapers/Naruto.jpg\"
run xss-lock --transfer-sleep-lock -- i3lock --nofork --show-failed-attempts --ignore-empty-password --tiling -i /usr/share/backgrounds/wallpapers/Naruto.png
run i3lock --nofork --show-failed-attempts --ignore-empty-password --tiling -i /usr/share/backgrounds/wallpapers/Naruto.png
run libinput-gestures-setup start
run rog-control-center
# xset -q
# sudo kbdrate -r 10.9 -d 250
