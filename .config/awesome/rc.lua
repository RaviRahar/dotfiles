-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears         = require("gears")
local awful         = require("awful")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local menubar       = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.autofocus")

-------------------------------------------------------------
-------------------------------------------------------------
-- Error handling
-------------------------------------------------------------
-------------------------------------------------------------
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end

-- Run garbage collector regularly to prevent memory leaks
gears.timer {
       timeout = 30,
       autostart = true,
       callback = function() collectgarbage() end
}

-------------------------------------------------------------
-------------------------------------------------------------
-- Autostart applications
-------------------------------------------------------------
-------------------------------------------------------------
awful.spawn.with_shell(
    'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
    'xrdb -merge <<< "awesome.started:true";' ..

    -- list each of your autostart commands, followed by ; inside single quotes, followed by ..
    'setxkbmap -option ctrl:nocaps && xcape -e "Caps_Lock=Escape" -t 100;' ..
    '$HOME/.config/picom/picom.sh;' ..
    'xfce4-power-manager --daemon;' ..
    'alacritty;' ..
--    'firefox;' ..
    'dex --environment Awesome --autostart --search-paths "$XDG_CONFIG_DIRS/autostart:$XDG_CONFIG_HOME/autostart"'
)


-------------------------------------------------------------
-------------------------------------------------------------
-- Variable definitions
-------------------------------------------------------------
-------------------------------------------------------------
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"
awful.layout.layouts = {
    awful.layout.suit.tile.left,
    awful.layout.suit.max,
    awful.layout.suit.tile.bottom,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.floating,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.corner.nw,
}

-------------------------------------------------------------
-------------------------------------------------------------
-- Theme
-------------------------------------------------------------
-------------------------------------------------------------
beautiful.init(gears.filesystem.get_themes_dir() .. "custom/theme.lua")

beautiful.font          = "NotoSans 10"
-- beautiful.font          = "FiraCode Nerd Font 5"
beautiful.wallpaper = "/usr/share/backgrounds/wallpapers/Naruto.jpg"
beautiful.maximized_hide_border = true
beautiful.fullscreen_hide_border = true
beautiful.gap_single_client = true
beautiful.border_single_client = true
beautiful.useless_gap   = beautiful.xresources.apply_dpi(3)
beautiful.border_width  = beautiful.xresources.apply_dpi(1)

beautiful.bg_normal     = "#222222"
beautiful.bg_focus      = "#83a598"
beautiful.bg_urgent     = "#fabd2f"
beautiful.bg_minimize   = "#444444"
beautiful.bg_systray    = "#689d6a"

beautiful.fg_normal     = "#ebdbb2"
beautiful.fg_focus      = "#282828"
beautiful.fg_urgent     = "#282828"
beautiful.fg_minimize   = "#282828"

beautiful.border_normal = "#222222"
beautiful.border_focus  = "#83a598"
beautiful.border_marked = "#fb246f"

beautiful.taglist_bg_occupied = "#458588"
beautiful.taglist_bg_focus    = beautiful.bg_focus
beautiful.taglist_bg_urgent   = beautiful.bg_urgent
beautiful.tasklist_bg_focus   = beautiful.bg_normal
beautiful.tasklist_fg_focus   = beautiful.fg_normal

-------------------------------------------------------------
-------------------------------------------------------------
-- Awesomebar
-------------------------------------------------------------
-------------------------------------------------------------
-- Dependencies for awesomebar
local assault           = require("widgets/battery-widget/assault")
local wifi_widget       = require("widgets/wifi-widget/wireless")  -- uses io.popen
-- local wifi_widget       = require("widgets/wifi-widget/wifi")    -- does not use io.popen
local brightness_widget = require("widgets/brightness-widget.brightness")
local volume_widget     = require('widgets/volume-widget.volume')
local net_speed_widget  = require("widgets/net-speed-widget.net-speed")
local logout_popup = require("widgets/logout-popup-widget.logout-popup")

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
-- local mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
local myseparator          = wibox.widget.textbox("  ")
local mytagseparator       = wibox.widget.textbox('<span font="notosans 16" foreground="#458588" background="#222222"></span>')
local mynetspeedseparator  = wibox.widget.textbox('<span font="notosans 16" foreground="#b16286" background="#222222"></span>')
local mynetworkseparator   = wibox.widget.textbox('<span font="notosans 16" foreground="#83a598" background="#b16286"></span>')
local mybrightnesseparator = wibox.widget.textbox('<span font="notosans 16" foreground="#d3869b" background="#83a598"></span>')
local mysoundseparator     = wibox.widget.textbox('<span font="notosans 16" foreground="#83a598" background="#d3869b"></span>')
local mybatteryseparator   = wibox.widget.textbox('<span font="notosans 16" foreground="#fabd2f" background="#83a598"></span>')
local mydateseparator      = wibox.widget.textbox('<span font="notosans 16" foreground="#282828" background="#fabd2f"></span>')
local mytimeseparator      = wibox.widget.textbox('<span font="notosans 16" foreground="#ebdbb2" background="#282828"></span>')
local mymenuseparator      = wibox.widget.textbox('<span font="notosans 16" foreground="#689d6a" background="#ebdbb2"></span>')

local mywifi          = wifi_widget{interface="wlp3s0"}
local mylogoutmenu    = logout_popup.widget{}
local mysound         = volume_widget{ device = 'default' }
local mybrightness    = brightness_widget{type = 'icon_and_text', fg="#282828"}
local mytextclockdate = wibox.widget.textclock('<span foreground="#ebdbb2"> %a %b %d </span>')
local mytextclocktime = wibox.widget.textclock('<span foreground="#282828"> %H:%M:%S </span>', "1")
local mynetspeed      = net_speed_widget{width=70}
local mybattery       = assault({
   battery = "BAT1",
   adapter = "ACAD",
   font = "NotoSans 14",
   width = 40, -- width of battery
   height = 18, -- height of battery
   bolt_width = 10, -- width of charging bolt
   bolt_height = 7, -- height of charging bolt
   stroke_width = 1, -- width of battery border
   normal_color   = "#282828", -- color to draw the battery when it's discharging
   critical_color = "#fb246f", -- color to draw the battery when it's at critical level
   charging_color = "#83a598" -- color to draw the battery when it's charging
})

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, false)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- padding between window and monitor
    s.padding = {
        left = beautiful.xresources.apply_dpi(0),
        right = beautiful.xresources.apply_dpi(0),
        top = beautiful.xresources.apply_dpi(0),
        bottom = beautiful.xresources.apply_dpi(0)
    }

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.noempty or awful.widget.taglist.filter.selected,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.focused,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mypanel = awful.wibar({ position = "top", screen = s, height="25", width="100%", opacity="0.8" })

    -- Add widgets to the wibox
    s.mypanel:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            -- mylauncher,
            wibox.widget.background(myseparator, "#458588"),
            s.mytaglist,
            s.mypromptbox,
            mytagseparator,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            -- mykeyboardlayout,
            mynetspeedseparator,
            wibox.widget.background(mynetspeed, "#b16286"),
            mynetworkseparator,
            wibox.widget.background(myseparator, "#83a598"),
            wibox.widget.background(mywifi, "#83a598"),
            wibox.widget.background(myseparator, "#83a598"),
            wibox.widget.background(myseparator, "#83a598"),
            mybrightnesseparator,
            wibox.widget.background(myseparator, "#d3869b"),
            wibox.widget.background(mybrightness, "#d3869b"),
            wibox.widget.background(myseparator, "#d3869b"),
            wibox.widget.background(myseparator, "#d3869b"),
            mysoundseparator,
            wibox.widget.background(myseparator, "#83a598"),
            wibox.widget.background(mysound, "#83a598"),
            wibox.widget.background(myseparator, "#83a598"),
            wibox.widget.background(myseparator, "#83a598"),
            mybatteryseparator,
            wibox.widget.background(myseparator, "#fabd2f"),
            wibox.widget.background(mybattery, "#fabd2f"),
            wibox.widget.background(myseparator, "#fabd2f"),
            wibox.widget.background(myseparator, "#fabd2f"),
            mydateseparator,
            wibox.widget.background(myseparator, "#282828"),
            wibox.widget.background(mytextclockdate, "#282828"),
            wibox.widget.background(myseparator, "#282828"),
            wibox.widget.background(myseparator, "#282828"),
            mytimeseparator,
            wibox.widget.background(myseparator, "#ebdbb2"),
            wibox.widget.background(mytextclocktime, "#ebdbb2"),
            wibox.widget.background(myseparator, "#ebdbb2"),
            mymenuseparator,
            wibox.widget.systray(),
            wibox.widget.background(myseparator, "#689d6a"),
            wibox.widget.background(mylogoutmenu, "#689d6a"),
            wibox.widget.background(myseparator, "#689d6a"),
        },
    }
end)


awful.screen.connect_for_each_screen(function(s)
    s.mytasklist_bottom = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.allscreen,
        buttons = tasklist_buttons
      }
    s.mypanel_tasklist = awful.wibar({ position = "bottom", screen = s, height="25", width="99%", opacity="0.8" })
    s.mypanel_tasklist:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
        },
        s.mytasklist_bottom, -- Middle widget 
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
        },
    }
    s.mypanel_tasklist.visible = false 
end)
-------------------------------------------------------------
-------------------------------------------------------------
-- Keybindings
-------------------------------------------------------------
-------------------------------------------------------------
--local my_hotkeys_popup = hotkeys_popup.widget.new({ width = 2400, height = 1200 })
globalkeys = gears.table.join(

    -- Not in any Group

    -- Media Keybindings
    --awful.key({}, "XF86AudioRaiseVolume", function() os.execute("pactl set-sink-volume @DEFAULT_SINK@ +10%") end),
    --awful.key({}, "XF86AudioLowerVolume", function() os.execute("pactl set-sink-volume @DEFAULT_SINK@ -10%") end),
    --awful.key({}, "XF86AudioMute", function() os.execute("pactl set-sink-mute @DEFAULT_SINK@ toggle") end),
    awful.key({}, "XF86AudioRaiseVolume", function() volume_widget:inc(10) end),
    awful.key({}, "XF86AudioLowerVolume", function() volume_widget:dec(10) end),
    awful.key({}, "XF86AudioMute", function() volume_widget:toggle() end),
    awful.key({}, "XF86AudioMicMute", function() os.execute("pactl set-source-mute @DEFAULT_SOURCE@ toggle") end),
    awful.key({}, "XF86AudioPlay", function () awful.spawn("playerctl play-pause") end),
    awful.key({}, "XF86AudioStop", function () awful.spawn("playerctl stop") end),
    awful.key({}, "XF86AudioNext", function () awful.spawn("playerctl next") end),
    awful.key({}, "XF86AudioPrev", function () awful.spawn("playerctl previous") end),
    --awful.key({}, "XF86MonBrightnessUp", function () awful.spawn("light -A 5") end),
    --awful.key({}, "XF86MonBrightnessDown", function () awful.spawn("light -U 5") end),
    awful.key({}, "XF86MonBrightnessUp", function () brightness_widget:inc(5) end),
    awful.key({}, "XF86MonBrightnessDown", function () brightness_widget:dec(5) end),
    awful.key({}, "XF86Launch3", function ()  awful.spawn("asusctl led-mode -n") end),
    awful.key({}, "XF86Launch4", function ()  awful.spawn("asusctl profile -n") end),

    -- Launcher Group
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey,         },            "r",     function () awful.spawn.with_shell("rofi -show combi -c $HOME/.config/rofi/config.rasi -theme launcher-theme.rasi", awful.rules.rules) end,
              {description = "run prompt", group = "launcher"}),
    awful.key({ modkey, "Shift" },            "r",     function () awful.spawn.with_shell("rofi -show combi -c $HOME/.config/rofi/config.rasi -theme dmenu-theme.rasi", awful.rules.rules) end,
              {description = "run prompt dmenu theme", group = "launcher"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"}),

    awful.key({ modkey, }, "c", function() awful.spawn(terminal .. " --class nmtui -e nmtui-connect", awful.rules.rules ) end,
              {description="Launch NMTUI", group="launcher"}),
    awful.key({ modkey, }, "e", function() awful.spawn("nemo", awful.rules.rules ) end,
              {description="Launch Nemo", group="launcher"}),
    awful.key({ modkey, }, "n", function() awful.spawn("nvim", awful.rules.rules ) end,
              {description="Launch Neovim", group="launcher"}),
    awful.key({ modkey, }, "o", function() awful.spawn("emacsclient -nc", awful.rules.rules ) end,
              {description="Launch Emacs", group="launcher"}),
    awful.key({ modkey, "Shift" }, "p", function() logout_popup.launch() end, 
              {description = "Show logout screen", group = "launcher"}),
    awful.key({ modkey, }, "s", function() awful.spawn("firefox-developer-edition", awful.rules.rules ) end,
              {description="Launch Browser", group="launcher"}),

    -- Screenshot Group
    awful.key({ }, "XF86Launch1", function() awful.spawn.with_shell("maim -u -s -m 10 " .. 
              "$HOME/Pictures/Screenshots/screenshot-$(date +%Y-%m-%d_%H-%M-%S).png") end,
              {description="Take Screenshots of custom area", group="Screenshot"}),
    awful.key({ "Shift" }, "XF86Launch1", function() awful.spawn.with_shell("maim -u -m 10 " .. 
              "$HOME/Pictures/Screenshots/screenshot-$(date +%Y-%m-%d_%H-%M-%S).png") end,
              {description="Take Screenshots", group="Screenshot"}),
    awful.key({ modkey, "Shift" }, "XF86Launch1", function() awful.spawn.with_shell("maim -u -m 10 -i " .. 
              "$(xdotool getactivewindow) $HOME/Pictures/Screenshots/screenshot-$(date +%Y-%m-%d_%H-%M-%S).png") end,
              {description="Take Screenshots of active x-window", group="Screenshot"}),

    -- Awesome Group
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Control" }, "h",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey, "Control"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey, "Control" }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "awesome"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "awesome"}),
    awful.key({ modkey, "Control" }, "t", 
              function ()
              myscreen = awful.screen.focused()
              myscreen.mypanel_tasklist.visible = not myscreen.mypanel_tasklist.visible
              end,
              {description = "toggle awesomebar tasklist", group = "awesome"}),

    --awful.key({ modkey, "Control" }, "x",
    --          function ()
    --              awful.prompt.run {
    --                prompt       = "Run Lua code: ",
    --                textbox      = awful.screen.focused().mypromptbox.widget,
    --                exe_callback = awful.util.eval,
    --                history_path = awful.util.get_cache_dir() .. "/history_eval"
    --              }
    --          end,
    --          {description = "lua execute prompt", group = "awesome"}),

    -- Layout Group
    awful.key({ modkey, "Shift"   }, "h",
              function () 
              awful.layout.inc(-1)
              notification = naughty.notify({
                      text   = "Layout " .. mouse.screen.selected_tag.layout.name,
                      timeout = 1,
              })
              end,
              {description = "select previous", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l", 
              function () 
              awful.layout.inc(1)
              notification = naughty.notify({
                      text   = "Layout " .. mouse.screen.selected_tag.layout.name,
                      timeout = 1,
              })
              end,
              {description = "select next", group = "layout"}),

    -- Tag Group
    awful.key({ modkey,           }, "h",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "l",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
    --awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
    --          {description = "increase master width factor", group = "layout"}),
    --awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
    --          {description = "decrease master width factor", group = "layout"}),
    --awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
    --          {description = "increase the number of master clients", group = "layout"}),
    --awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
    --          {description = "decrease the number of master clients", group = "layout"}),
    --awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
    --          {description = "increase the number of columns", group = "layout"}),
    --awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
    --          {description = "decrease the number of columns", group = "layout"}),

    -- Client Group
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Shift" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
              function ()
                  awful.client.focus.history.previous()
                  if client.focus then
                      client.focus:raise()
                  end
              end,
              {description = "go back", group = "client"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
              function (c)
                  c.fullscreen = false
                  local client_maximized = c.maximized
                  local any_maximized = false
                  for _, cl in ipairs(mouse.screen.selected_tag:clients()) do
                    if cl.maximized then
                          any_maximized = true
                      end
                  end
                  if any_maximized then
                      for _, cl in ipairs(mouse.screen.selected_tag:clients()) do
                          if cl.window ~= c.window then
                              cl.maximized = false
                          end
                      end
                  end
                  c.maximized = not client_maximized
                  c:raise()
              end ,
              {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Shift" }, "f",
              function (c)
                  c.maximized_vertical = not c.maximized_vertical
                  c:raise()
              end ,
              {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Control"   }, "f",
              function (c)
                  c.maximized_horizontal = not c.maximized_horizontal
                  c:raise()
              end ,
              {description = "(un)maximize horizontally", group = "client"}),
    awful.key({ modkey,           }, "m",
              function (c)
                  c.maximized = false
                  local client_fullscreen = c.fullscreen
                  local any_fullscreen = false
                  for _, cl in ipairs(mouse.screen.selected_tag:clients()) do
                      if cl.fullscreen then
                          any_fullscreen = true
                      end
                  end
                  if any_fullscreen then
                      for _, cl in ipairs(mouse.screen.selected_tag:clients()) do
                          if cl.window ~= c.window then
                              cl.fullscreen = false
                          end
                      end
                  end
                  c.fullscreen = not client_fullscreen
                  c:raise()
              end,
              {description = "toggle fullscreen", group = "client"}),
--    awful.key({ modkey,           }, "n", function (c) c.minimized = true end,
--              {description = "minimize", group = "client"}),
--    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
--              {description = "move to screen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Shift" }, "s",      function (c) c.sticky = not c.sticky  end,
              {description = "toggle sticky", group="client"}),
    awful.key({ modkey,         }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey, "Shift" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"})
)

-- Bind all key numbers to tags.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

-- Mouse keys
clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)


root.keys(globalkeys)

-------------------------------------------------------------
-------------------------------------------------------------
-- Rules for different windows
-------------------------------------------------------------
-------------------------------------------------------------
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
          "nmtui"
        },

        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "Nemo",
          "OWASP ZAP",
          "burp-StartBurp",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        } 
      }, properties = { floating = true,  placement = awful.placement.no_overlap+awful.placement.no_offscreen+awful.placement.centered }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    -- Set applications to always map on the tag named "2" on screen 1.
     { rule_any = { 
        class = {
         "OWASP ZAP",
         "burp-StartBurp",
        },
       },
       properties = { screen = 1, tag = "6" } },
}

-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-------------------------------------------------------------
-------------------------------------------------------------
-- Titlebar
-------------------------------------------------------------
-------------------------------------------------------------
-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.minimizebutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-------------------------------------------------------------
-------------------------------------------------------------
-- Enable sloppy focus, so that focus follows mouse.
-------------------------------------------------------------
-------------------------------------------------------------
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-------------------------------------------------------------
-------------------------------------------------------------
-- Keep mouse on focused window
-- copied https://bitbucket.org/grumph/home_config/src/afdeb425c2cdfee045d3d91f250129d8036a1f53/.config/awesome/mouse_follow_focus.lua
-------------------------------------------------------------
-------------------------------------------------------------
function is_client_on_current_tag(c)
   for _, mouse_tag in ipairs(mouse.screen.selected_tags) do
      for _, client_tag in ipairs(c:tags()) do
         if client_tag == mouse_tag then
            return true
         end
      end
   end
   return false
end

function move_mouse_to_client(c, skip_mouse_check)
   c = c or client.focus
   local mcc = mouse.current_client


   if mcc ~= nil                                     -- disable for toolbars clicks
      and (skip_mouse_check
              or (not mouse.is_left_mouse_button_pressed
                     and c ~= mcc                    -- disable when mouse is already inside client
      ))
      and is_client_on_current_tag(c)
      and c.type == "normal"
   then
      gears.timer({
            timeout = 0.1,
            autostart = true,
            callback = function() awful.placement.centered(mouse, {parent=c})  end,
            single_shot = true,
      })
   end
end

local next_focused_client_gets_mouse = false

client.connect_signal("swapped",
                      function(c1, c2) -- , is_source)
                         if client.focus ~= c1 then
                            move_mouse_to_client(c2, true)
                         end
                      end
)

screen.connect_signal("tag::history::update",
                      function()
                         next_focused_client_gets_mouse = true
                      end
)

client.connect_signal("raised",
                      function(c)
                         move_mouse_to_client(c)
                      end
)

client.connect_signal("focus",
                      function(c)
                         if next_focused_client_gets_mouse then
                            move_mouse_to_client(c, true)
                            next_focused_client_gets_mouse = false
                         end
                      end
)
