-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- Dependencies for awesomebar
local assault = require("widgets/battery_widget/assault")
local net_widgets = require("widgets/net_widgets")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_themes_dir() .. "custom/theme.lua")
beautiful.init("~/.config/awesome/themes/custom/theme.lua")

beautiful.maximized_hide_border = true
beautiful.fullscreen_hide_border = true
beautiful.gap_single_client = false
beautiful.border_single_client = false

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    -- awful.layout.suit.max,
    -- awful.layout.suit.floating,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

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
-- mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
local myseparator         = wibox.widget.textbox("  ")
local mytagseparator      = wibox.widget.textbox('<span font="notosans 16" foreground="#83a598" background="#222222"></span>')
local mynetspeedseparator = wibox.widget.textbox('<span font="notosans 16" foreground="#b16286" background="#222222"></span>')
local mynetworkseparator  = wibox.widget.textbox('<span font="notosans 16" foreground="#83a598" background="#b16286"></span>')
local mybrightneseparator = wibox.widget.textbox('<span font="notosans 16" foreground="#d3869b" background="#83a598"></span>')
local mysoundseparator    = wibox.widget.textbox('<span font="notosans 16" foreground="#83a598" background="#d3869b"></span>')
local mybatteryseparator  = wibox.widget.textbox('<span font="notosans 16" foreground="#fabd2f" background="#b16286"></span>')
--local mybatteryseparator  = wibox.widget.textbox('<span font="notosans 16" foreground="#fabd2f" background="#83a598"></span>')
local mydateseparator     = wibox.widget.textbox('<span font="notosans 16" foreground="#282828" background="#fabd2f"></span>')
local mytimeseparator     = wibox.widget.textbox('<span font="notosans 16" foreground="#ebdbb2" background="#282828"></span>')
local mymenuseparator     = wibox.widget.textbox('<span font="notosans 16" foreground="#689d6a" background="#ebdbb2"></span>')

local mytextclockdate     = wibox.widget.textclock('<span foreground="#ebdbb2"> %a %b %d </span>')
local mytextclocktime     = wibox.widget.textclock('<span foreground="#282828"> %H:%M:%S </span>', "1")
local mybattery           = assault({
   width = 25, -- width of battery
   height = 10, -- height of battery
   bolt_width = 10, -- width of charging bolt
   bolt_height = 7, -- height of charging bolt
   stroke_width = 1, -- width of battery border
   normal_color   = "#ebdbb2", -- color to draw the battery when it's discharging
   critical_color = "#fb246f", -- color to draw the battery when it's at critical level
   charging_color = "#83a598" -- color to draw the battery when it's charging
})

local mynet_wireless = net_widgets.wireless({interface="wlp6s0"})
local mynet_wired = net_widgets.indicator({
    interfaces  = {"enp7s0"},
    timeout     = 5
})

---- Show different prefixes when charging on AC
--ac_prefix = {
--    { 11, "  " },
--    { 25, "  " },
--    { 50, "  " },
--    { 75, "  " },
--    {100, "  " }
--},
--
---- Show a visual indicator of charge level when on battery power
--battery_prefix = {
--    { 11, "  " },
--    { 25, "  " },
--    { 50, "  " },
--    { 75, "  " },
--    {100, "  " }
--}

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
        left = beautiful.xresources.apply_dpi(5),
        right = beautiful.xresources.apply_dpi(5),
        top = beautiful.xresources.apply_dpi(5),
        bottom = beautiful.xresources.apply_dpi(5)
    }

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    -- s.mylayoutbox = awful.widget.layoutbox(s)
    -- s.mylayoutbox:buttons(gears.table.join(
    --                      awful.button({ }, 1, function () awful.layout.inc( 1) end),
    --                      awful.button({ }, 3, function () awful.layout.inc(-1) end),
    --                     awful.button({ }, 4, function () awful.layout.inc( 1) end),
    --                     awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height="20", width="99%", opacity="0.8" })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            -- mylauncher,
            s.mytaglist,
            s.mypromptbox,
            wibox.widget.background(myseparator, "#83a598"),
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            -- mykeyboardlayout,
            wibox.widget.background(mynet_wired, "#b16286"),
            wibox.widget.background(mynet_wireless, "#b16286"),
            wibox.widget.background(myseparator, "#b16286"),
            --mynetworkseparator,
            --mybrightneseparator,
            --mysoundseparator,
            mybatteryseparator,
            wibox.widget.background(mybattery, "#fabd2f"),
            wibox.widget.background(myseparator, "#fabd2f"),
            mydateseparator,
            wibox.widget.background(mytextclockdate, "#282828"),
            mytimeseparator,
            wibox.widget.background(mytextclocktime, "#ebdbb2"),
            --mymenuseparator,
            wibox.widget.systray(),
            -- s.mylayoutbox,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}


globalkeys = gears.table.join(

    -- Custom Keybindings
      -- Launch Apps
    awful.key({ modkey, }, "o", function() awful.spawn("emacsclient -nc", awful.rules.rules ) end,
              {description="Launch Emacs", group="Custom"}),
    awful.key({ modkey, }, "n", function() awful.spawn("nvim", awful.rules.rules ) end,
              {description="Launch Neovim", group="Custom"}),
    awful.key({ modkey, }, "s", function() awful.spawn("firefox", awful.rules.rules ) end,
              {description="Launch Firefox", group="Custom"}),
    awful.key({ modkey, }, "e", function() awful.spawn("nemo", awful.rules.rules ) end,
              {description="Launch Nemo", group="Custom"}),
    awful.key({ modkey, }, "c", function() awful.spawn(terminal .. " --class nmtui -e nmtui-connect", awful.rules.rules ) end,
              {description="Launch NMTUI", group="Custom"}),
      -- Screenshots
    awful.key({ }, "Print", function() awful.spawn.with_shell("maim -u -m 10 $HOME/Pictures/Screenshots/screenshot-$(date +%Y-%m-%d_%H-%M-%S).png") end,
              {description="Take Screenshots", group="Custom"}),
    awful.key({ "Shift" }, "Print", function() awful.spawn.with_shell("maim -u -s -m 10 $HOME/Pictures/Screenshots/screenshot-$(date +%Y-%m-%d_%H-%M-%S).png") end,
              {description="Take Screenshots of custom area", group="Custom"}),
    awful.key({ modkey, "Shift" }, "Print", function() awful.spawn.with_shell("maim -u -m 10 -i $(xdotool getactivewindow) $HOME/Pictures/Screenshots/screenshot-$(date +%Y-%m-%d_%H-%M-%S).png") end,
              {description="Take Screenshots of active x-window", group="Custom"}),
      -- Power Shortcuts
    awful.key({ modkey, "Shift" }, "p", function() awful.spawn("systemctl poweroff") end),
    awful.key({ modkey, "Control" }, "p", function() awful.spawn("systemctl reboot") end),
    awful.key({ modkey, "Shift", "Control" }, "p", function() awful.spawn("dm-tool switch-to-greeter") end),

    -- Media Keybindings
    awful.key({}, "XF86AudioRaiseVolume", function() os.execute("pactl set-sink-volume @DEFAULT_SINK@ +10%") end),
    awful.key({}, "XF86AudioLowerVolume", function() os.execute("pactl set-sink-volume @DEFAULT_SINK@ -10%") end),
    awful.key({}, "XF86AudioMute", function() os.execute("pactl set-sink-mute @DEFAULT_SINK@ toggle") end),
    awful.key({}, "XF86AudioMicMute", function() os.execute("pactl set-source-mute @DEFAULT_SOURCE@ toggle") end),
    awful.key({}, "XF86AudioPlay", function () awful.spawn("playerctl play-pause") end),
    awful.key({}, "XF86AudioStop", function () awful.spawn("playerctl stop") end),
    awful.key({}, "XF86AudioNext", function () awful.spawn("playerctl next") end),
    awful.key({}, "XF86AudioPrev", function () awful.spawn("playerctl previous") end),
    awful.key({}, "XF86MonBrightnessUp", function () awful.spawn("light -A 5") end),
    awful.key({}, "XF86MonBrightnessDown", function () awful.spawn("light -U 5") end),

    -- Other Keybindings
    awful.key({ modkey, "Control" }, "h",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "h",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "l",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

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
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Shift" }, "c", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Control"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

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
    awful.key({ modkey, "Shift"   }, "h", function () awful.layout.inc(1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
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

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "m",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Shift" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "f",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "f",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "f",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"}),

    -- Sticky window
    awful.key({ modkey, "Shift" }, "s",      function (c) c.sticky = not c.sticky                  end,
              {description="toggle sticky", group="client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
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
                  end),
                  --{description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
                  --{description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end),
                  --{description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end)
                  --{description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

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

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
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
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
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
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            --awful.titlebar.widget.stickybutton   (c),
            --awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            --layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- copied https://bitbucket.org/grumph/home_config/src/afdeb425c2cdfee045d3d91f250129d8036a1f53/.config/awesome/mouse_follow_focus.lua


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

-- Autostart applications
awful.spawn.with_shell("$HOME/.config/picom/picom.sh", awful.rules.rules)
awful.spawn.with_shell("xfce4-power-manager --daemon", awful.rules.rules)
awful.spawn.with_shell("playerctld daemon", awful.rules.rules)
awful.spawn.with_shell("setxkbmap -option ctrl:nocaps && xcape -e 'Caps_Lock=Escape' -t 100", awful.rules.rules)
awful.spawn.once(terminal, awful.rules.rules)
--awful.spawn.once("firefox", awful.rules.rules)
