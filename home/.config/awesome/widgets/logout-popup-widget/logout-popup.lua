local awful = require("awful")
local capi = { keygrabber = awful.keygrabber }
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local awesomebuttons = require("widgets/awesome-buttons.awesome-buttons")

local HOME_DIR = os.getenv("HOME")
local WIDGET_DIR = HOME_DIR .. "/.config/awesome/widgets/logout-popup-widget"

local w = wibox({
    bg = beautiful.fg_normal,
    max_widget_size = 800,
    ontop = true,
    height = 600,
    width = 1000,
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 8)
    end,
})

local action = wibox.widget({
    text = " ",
    widget = wibox.widget.textbox,
})

local phrase_widget = wibox.widget({
    align = "center",
    widget = wibox.widget.textbox,
})

local function create_button(icon_name, action_name, bg_color, fg_color, label_color, onclick, icon_size, icon_margin)
    local button = awesomebuttons.with_icon({
        type = "basic",
        icon = icon_name,
        bg_color = bg_color,
        fg_color = fg_color,
        icon_size = icon_size,
        icon_margin = icon_margin,
        onclick = function()
            onclick()
            w.visible = false
            capi.keygrabber.stop()
        end,
    })
    action:set_markup('<span size="15000"> Power Off (p) </span>')
    button:connect_signal("mouse::enter", function()
        -- action:set_markup('<span color="' .. label_color .. '">' .. action_name .. '</span>')
        action:set_markup('<span color="' .. label_color .. '" size="15000">' .. action_name .. "</span>")
    end)

    -- button:connect_signal("mouse::leave", function()
    --     action:set_markup('<span size="15000"> </span>')
    -- end)

    return button
end

local function launch(args)
    args = args or {}

    local bg_color = args.bg_color or beautiful.bg_normal
    local icon_bg_color = args.icon_bg_color or beautiful.bg_focus
    local icon_fg_color = args.icon_bg_color or beautiful.fg_normal
    local text_color = args.text_color or beautiful.fg_normal
    local label_color = args.label_color or beautiful.fg_normal
    local phrases = args.phrases or { "Goodbye!" }
    local icon_size = args.icon_size or 50
    local icon_margin = args.icon_margin or 50

    local onlogout = args.onlogout or function()
        awesome.quit()
    end
    local onlock = args.onlock or function()
        awful.spawn.with_shell("dm-tool lock")
    end
    local onreboot = args.onreboot or function()
        awful.spawn.with_shell("systemctl --no-wall reboot")
    end
    local onhibernate = args.onhibernate
        or function()
            awful.spawn.with_shell("systemctl --no-wall hibernate")
        end
    local onpoweroff = args.onpoweroff or function()
        awful.spawn.with_shell("shutdown --no-wall now")
    end

    w:set_bg(bg_color)
    if #phrases > 0 then
        phrase_widget:set_markup(
            '<span color="' .. text_color .. '" size="20000">' .. phrases[math.random(#phrases)] .. "</span>"
        )
    end

    w:setup({
        {
            phrase_widget,
            {
                {
                    create_button(
                        "log-out",
                        "Log Out (k)",
                        icon_bg_color,
                        icon_fg_color,
                        label_color,
                        onlogout,
                        icon_size,
                        icon_margin
                    ),
                    create_button(
                        "lock",
                        "Lock (l)",
                        icon_bg_color,
                        icon_fg_color,
                        label_color,
                        onlock,
                        icon_size,
                        icon_margin
                    ),
                    create_button(
                        "refresh-cw",
                        "Reboot (r)",
                        icon_bg_color,
                        icon_fg_color,
                        label_color,
                        onreboot,
                        icon_size,
                        icon_margin
                    ),
                    create_button(
                        "moon",
                        "Hibernate (h)",
                        icon_bg_color,
                        icon_fg_color,
                        label_color,
                        onhibernate,
                        icon_size,
                        icon_margin
                    ),
                    create_button(
                        "power",
                        "Power Off (p)",
                        icon_bg_color,
                        icon_fg_color,
                        label_color,
                        onpoweroff,
                        icon_size,
                        icon_margin
                    ),
                    id = "buttons",
                    spacing = 30,
                    layout = wibox.layout.fixed.horizontal,
                },
                valign = "center",
                layout = wibox.container.place,
            },
            {
                action,
                halign = "center",
                layout = wibox.container.place,
            },
            spacing = 100,
            layout = wibox.layout.fixed.vertical,
        },
        id = "a",
        shape_border_width = 1,
        valign = "center",
        layout = wibox.container.place,
    })

    w.screen = mouse.screen
    w.visible = true

    awful.placement.centered(w)
    capi.keygrabber.run(function(_, key, event)
        if event == "release" then
            return
        end
        if key then
            if key == "Escape" or key == "q" then
                phrase_widget:set_text("")
                capi.keygrabber.stop()
                w.visible = false
            elseif key == "p" then
                onpoweroff()
            elseif key == "r" then
                onreboot()
            elseif key == "h" then
                onhibernate()
            elseif key == "l" then
                onlock()
            elseif key == "k" then
                onlogout()
            end

            if key == "Escape" or string.match("qprhkl", key) then
                phrase_widget:set_text("")
                capi.keygrabber.stop()
                w.visible = false
            end
        end
    end)
end

local function widget(args)
    local icon = args.icon or WIDGET_DIR .. "/power.svg"

    local res = wibox.widget({
        {
            {
                image = icon,
                widget = wibox.widget.imagebox,
            },
            margins = 4,
            layout = wibox.container.margin,
        },
        layout = wibox.layout.fixed.horizontal,
    })

    res:buttons(gears.table.join(awful.button({}, 1, function()
        if w.visible then
            phrase_widget:set_text("")
            capi.keygrabber.stop()
            w.visible = false
        else
            launch(args)
        end
    end)))

    return res
end

return {
    launch = launch,
    widget = widget,
}
