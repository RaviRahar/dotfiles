# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs

if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  /usr/bin/Hyprland >.hyprland.log.txt 2>.hyprland.err.txt
fi
