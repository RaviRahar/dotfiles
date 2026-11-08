-- TODO:
-- Lua configs can now use `hl.on(...)` callbacks for Hyprland events.
-- That may be useful later when converting dynamic/showoff/plugin config.

-----------------------------
-- SOURCE CONFIGS
-----------------------------

-- Hyprland >= 0.55 uses Lua. `require()` paths are relative to
-- ~/.config/hypr/hyprland.lua, and wildcards are supported.

require("hyprland/init")
require("hyprland/animations")
require("hyprland/themes")

-- Plugins
require("hyprland/plugins/hyprspace")

require("hyprland/keybindings")
require("hyprland/windowrules")
require("hyprland/layouts")
require("hyprland/groups")
require("hyprland/inputdevices")
require("hyprland/autostart")

-- require("hyprland/showoff")
