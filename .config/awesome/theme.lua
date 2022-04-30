local gears         = require("gears")
local beautiful     = require("beautiful")

beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

beautiful.font          = "NotoSans 9"
-- beautiful.font          = "FiraCode Nerd Font 9"
beautiful.wallpaper = "/usr/share/backgrounds/wallpapers/Naruto.jpg"
beautiful.maximized_hide_border = true
beautiful.fullscreen_hide_border = true
beautiful.gap_single_client = true
beautiful.border_single_client = true
beautiful.useless_gap   = beautiful.xresources.apply_dpi(2)
beautiful.border_width  = beautiful.xresources.apply_dpi(1)

beautiful.bg_normal     = "#222222"
beautiful.bg_focus      = "#83a598"
beautiful.bg_urgent     = "#fabd2f"
beautiful.bg_minimize   = "#444444"
beautiful.bg_systray    = beautiful.bg_normal

beautiful.fg_normal     = "#ebdbb2"
beautiful.fg_focus      = "#282828"
beautiful.fg_urgent     = "#282828"
beautiful.fg_minimize   = "#282828"

beautiful.border_normal = "#222222"
beautiful.border_focus  = "#83a598"
beautiful.border_marked = "#fb246f"

beautiful.taglist_bg_occupied = "#458588"
beautiful.taglist_bg_focus  = beautiful.bg_focus
beautiful.tasklist_bg_focus = beautiful.bg_normal
beautiful.tasklist_fg_focus = beautiful.fg_normal
