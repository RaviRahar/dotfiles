#
# ~/.bash_profile
#

# Autostart startx and hide messages

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1 &> /dev/null
#startx
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc
. "$HOME/.cargo/env"
