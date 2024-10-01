# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# User specific environment and startup programs

if [ -z "${WAYLAND_DISPLAY}" ] && [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec /usr/bin/Hyprland >.hyprland.log.txt 2>.hyprland.err.txt
fi

if [ -z "${CUSTOM_X_VAR}" ] && [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 9 ]; then
  # you can add any desired commands related to the specific session inside the if-statement too.
  # export XAUTHORITY="$XDG_RUNTIME_DIR/xauthority"
  export CUSTOM_X_VAR="notnull"
  exec startx >.startx.log.txt 2>.startx.err.txt
fi
