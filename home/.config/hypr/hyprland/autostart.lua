-- FIXME:
-- The old `sleep 10; hyprctl keyword "debug:suppress_errors" 0` line used the
-- hyprlang runtime-keyword interface. `debug.suppress_errors = false` is
-- already set in init.lua, so that startup workaround is no longer needed.

-- TODO:
-- `hl.exec_cmd()` is asynchronous. There is no need to add `&` / `disown`.
-- For long-lived daemons with native user units (e.g. hyprpaper), systemd
-- user services are another clean option.

hl.on("hyprland.start", function()
    hl.exec_cmd("pidof hyprlock || hyprlock")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hyprsunset")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpm reload")

    -- hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("sleep 30; rog-control-center")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")

    -- hl.exec_cmd([[systemctl --user start xsettingsd.service && echo "Xft.dpi: 188" | xrdb -merge && xprop -root -format _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 2]])

    hl.exec_cmd("dunst")
    hl.exec_cmd("easyeffects --gapplication-service")
    hl.exec_cmd("libinput-gestures")
    hl.exec_cmd([[batsignal -b -e -p -d 10 -c 15 -w 20 -f 0 -D "notify-send -t 2000 'Battery is Dangerously Low' 'System will hibernate in 2 mins'; sleep 120; systemctl hibernate"]])
    hl.exec_cmd("a2ln")
    -- hl.exec_cmd([[tor -f "$HOME/.config/tor/.torrc"]])

    -- hl.exec_cmd("$HOME/.local/bin/anki-serve")
end)
