#!/bin/bash

declare -l time
declare -l level
declare -l timeInMins

case "$1" in
-w)
    level="Warning"
    level="${2:=300}"
    ;;
-c)
    level="Critical"
    level="${2:=120}"
    ;;
-d)
    level="Danger"
    level="${2:=60}"
    ;;
esac

timeInMins=$((${2} / 60))
/usr/bin/notify-send "$level" "Battery low! Going into hibernation in under ${timeInMins} mins"
/usr/bin/sleep ${time}
/usr/bin/systemctl hibernate
