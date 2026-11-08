-- FIXME:
-- `bringactivetotop` was deprecated and is not in the current dispatcher API.
-- The cycle binds now use `hl.dsp.window.alter_zorder({ mode = "top" })`.
--
-- `setignoregrouplock` is no longer a dispatcher. Its behavior is preserved
-- with a Lua callback that toggles `binds.ignore_group_lock` at runtime.
--
-- The old overview / hyprexpo plugin binds remain disabled. Re-enable them
-- only after checking the current Lua API for whichever plugin you install.

-- TODO:
-- Lua binds support a `description` flag, shown by `hyprctl binds`. Adding
-- descriptions gradually would turn this file into a searchable keymap.
--
-- TODO:
-- Current binds also support long_press / release / click / drag flags, which
-- may let some of the custom launcher or power binds become harder to trigger
-- accidentally.

--------------------
-- Variables
--------------------

local mainMod = "SUPER"

local terminal = "foot"
local filemanager = "thunar"
local browser = "firefox-developer-edition -P default-release"
local browserwork = "firefox-developer-edition -P Work"
local browserprofiles = "firefox-developer-edition -P"

local menu =
    "rofi -show combi -c $HOME/.config/rofi/config.rasi -modes combi -theme theme-launcher-gruvbox-dark -opacity 90"
local menuemoji =
    "rofi -show emoji -c $HOME/.config/rofi/config.rasi -modes emoji -theme theme-launcher-gruvbox-dark-alt -opacity 90"
local menucalc =
    "rofi -show calc -c $HOME/.config/rofi/config.rasi -modes calc -theme theme-launcher-gruvbox-dark-alt -opacity 90"
local menuclipboard =
    "rofi -show clipboard -c $HOME/.config/rofi/config.rasi -modes clipboard:cliphist-rofi-img -theme theme-launcher-gruvbox-dark-alt -opacity 90"
local menudmenu =
    "rofi -dmenu -c $HOME/.config/rofi/config.rasi -modes clipboard:cliphist-rofi-img -theme theme-launcher-gruvbox-dark-alt -opacity 90"
local menukill = menudmenu .. " -p kill -theme-str 'window {width:60%;}'"
local menukillall = menudmenu .. " -p killall"

local music = "mixtapes"
local flashcard = "anki"

local scripts = "$HOME/.config/hypr/hyprland/scripts"

local keys = function(suffix)
    if suffix == "" then
        return mainMod
    end
    return mainMod .. " + " .. suffix
end

local run = function(cmd)
    return hl.dsp.exec_cmd(cmd)
end

local dispatch = function(action)
    hl.dispatch(action)
end

--------------------
-- Tags
--------------------

hl.bind(keys("I"), hl.dsp.window.tag({ tag = "idletag" }))

---------------------------
-- Program launch binds
---------------------------

hl.bind(keys("SHIFT + D"), run(filemanager))
hl.bind(keys("E"), run(terminal))
hl.bind(keys("SHIFT + S"), run(browser))
hl.bind(keys("SHIFT + W"), run(browserwork))
hl.bind(keys("N"), run(browserprofiles))

hl.bind(keys("R"), run(menu))
hl.bind(keys("V"), run(menuclipboard .. " && " .. scripts .. "/smartpaste"))

-- TODO:
-- Alternative clipboard flow from the old config:
-- cliphist list | rofi ... | cliphist decode | wl-copy && wtype ...

hl.bind(keys("U"), run(menuemoji))
hl.bind(keys("O"), run(menucalc .. " | wl-copy && " .. scripts .. "/smartpaste"))

hl.bind(keys("X"), run("ps -u $USER -o comm | sort -u | " .. menukillall .. " | xargs killall"))

hl.bind(
    keys("SHIFT + X"),
    run(
        [[ps -u $USER -o pid,ppid,command | ]]
            .. menukill
            .. [[ | sed 's/\s*\([0-9]*\)\s*[0-9]*\s*.*/\1/g' | xargs kill -9]]
    )
)

--------------------
-- Screenshot / OCR
--------------------

hl.bind(keys("SHIFT + ALT + S"), run(scripts .. "/screenshot -s"))
hl.bind(keys("SHIFT + CONTROL + S"), run(scripts .. "/screenshot -a"))
hl.bind(keys("C"), run(scripts .. "/screenshot -e"))

-- Preserved exactly from the old config. Its comment said "hindi", but the
-- command actually used German (`-l de`).
hl.bind(keys("SHIFT + C"), run(scripts .. "/screenshot -e -l de"))

--------------------
-- Mouse zoom
--------------------

hl.bind(keys("Z"), run(scripts .. "/mousezoom -t"))
hl.bind(keys("SHIFT + Z"), run(scripts .. "/mousezoom -r"))

--------------------
-- Plugins
--------------------

-- FIXME:
-- hl.bind(keys("SHIFT + GRAVE"), ...) -- old `overview:toggle`
-- hl.bind(keys("GRAVE"), ...)         -- old `hyprexpo:expo, toggle`

--------------------
-- Window controls
--------------------

hl.bind(keys("Q"), hl.dsp.window.close())
hl.bind(keys("SHIFT + Q"), run("hyprctl kill"))

hl.bind(
    keys("F"),
    hl.dsp.window.fullscreen_state({
        internal = 1,
        client = -1,
        action = "toggle",
    })
)

hl.bind(
    keys("SHIFT + F"),
    hl.dsp.window.fullscreen_state({
        internal = 2,
        client = -1,
        action = "toggle",
    })
)

hl.bind(keys("T"), hl.dsp.window.center())

hl.bind(keys("SHIFT + T"), function()
    hl.exec_cmd(scripts .. "/flash")
    dispatch(hl.dsp.window.float({ action = "toggle" }))
    dispatch(hl.dsp.window.center())
end)

hl.bind(keys("CONTROL + T"), function()
    hl.exec_cmd(scripts .. "/flash")
    dispatch(hl.dsp.window.pin({ action = "toggle" }))
end)

--------------------
-- Focus
--------------------

for key, direction in pairs({
    H = "l",
    J = "d",
    K = "u",
    L = "r",
}) do
    hl.bind(keys(key), hl.dsp.focus({ direction = direction }))
end

local function cycle_window(next_window)
    return function()
        dispatch(hl.dsp.window.cycle_next({ next = next_window }))
        dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
    end
end

hl.bind(keys("TAB"), cycle_window(true))
hl.bind(keys("SHIFT + TAB"), cycle_window(false))
hl.bind(keys("semicolon"), cycle_window(true))
hl.bind(keys("apostrophe"), cycle_window(false))

--------------------
-- Groups
--------------------

hl.bind(keys("G"), hl.dsp.group.toggle())
hl.bind(keys("SHIFT + G"), hl.dsp.group.lock({ action = "toggle" }))

hl.bind(keys("CONTROL + G"), function()
    dispatch(hl.dsp.window.move({ out_of_group = true }))
    dispatch(hl.dsp.window.deny_from_group({ action = "toggle" }))
end)

hl.bind(keys("ALT + G"), function()
    local current = hl.get_config("binds.ignore_group_lock")
    hl.config({
        binds = {
            ignore_group_lock = not current,
        },
    })
end)

for key, direction in pairs({
    H = "l",
    J = "d",
    K = "u",
    L = "r",
}) do
    hl.bind(
        keys("SHIFT + " .. key),
        hl.dsp.window.move({
            direction = direction,
            group_aware = true,
        })
    )
end

hl.bind(keys("CONTROL + K"), hl.dsp.group.prev())
hl.bind(keys("CONTROL + J"), hl.dsp.group.next())

--------------------
-- Layout
--------------------

hl.bind(keys("CONTROL + H"), hl.dsp.layout("togglesplit"), { repeating = true })

hl.bind(keys("CONTROL + L"), hl.dsp.layout("swapsplit"), { repeating = true })

--------------------
-- Workspaces
--------------------

hl.bind(keys("SHIFT + semicolon"), hl.dsp.focus({ workspace = "e-1" }))
hl.bind(keys("SHIFT + apostrophe"), hl.dsp.focus({ workspace = "e+1" }))

for i = 1, 9 do
    local workspace = tostring(i)

    hl.bind(keys(workspace), hl.dsp.focus({ workspace = workspace }))

    hl.bind(
        keys("CONTROL + " .. workspace),
        hl.dsp.window.move({
            workspace = workspace,
            follow = true,
        })
    )

    hl.bind(
        keys("SHIFT + " .. workspace),
        hl.dsp.window.move({
            workspace = workspace,
            follow = false,
        })
    )
end

------------------------
-- Special workspaces
------------------------

hl.bind(keys("0"), hl.dsp.workspace.toggle_special("minimized"))
hl.bind(
    keys("SHIFT + 0"),
    hl.dsp.window.move({
        workspace = "special:minimized",
        follow = false,
    })
)
hl.bind(
    keys("CONTROL + 0"),
    hl.dsp.window.move({
        workspace = "special:minimized",
        follow = true,
    })
)

local special_workspaces = {
    A = "flashcard",
    D = "filemanager",
    S = "browser",
    W = "work",
    M = "music",
}

for key, name in pairs(special_workspaces) do
    hl.bind(keys(key), hl.dsp.workspace.toggle_special(name))
    hl.bind(
        keys("ALT + " .. key),
        hl.dsp.window.move({
            workspace = "special:" .. name,
            follow = false,
        })
    )
end

-- Terminal uses SUPER+SHIFT+E for toggling, but SUPER+ALT+E for moving.
hl.bind(keys("SHIFT + E"), hl.dsp.workspace.toggle_special("terminal"))
hl.bind(
    keys("ALT + E"),
    hl.dsp.window.move({
        workspace = "special:terminal",
        follow = false,
    })
)

-- YouTube scratchpad remains disabled because its command was not defined.
hl.bind(keys("Y"), hl.dsp.workspace.toggle_special("youtube"))
hl.bind(
    keys("ALT + Y"),
    hl.dsp.window.move({
        workspace = "special:youtube",
        follow = false,
    })
)

-- When switching workspace, also toggle off a special workspace if active.
hl.bind(keys("ESCAPE"), run(scripts .. "/specialtoggle"))
hl.bind(keys("BRACKETLEFT"), run(scripts .. "/specialtoggle"))

--------------------
-- Monitors
--------------------

hl.bind(keys("P"), hl.dsp.focus({ monitor = "+1" }))
hl.bind(keys("SHIFT + P"), hl.dsp.window.move({ monitor = "+1" }))
hl.bind(keys("CONTROL + P"), hl.dsp.workspace.move({ monitor = "+1" }))

--------------------
-- Switches
--------------------

-- Controlled by systemd using /etc/systemd/logind.conf.
-- TODO:
-- Lua switch binds can be restored later if you want Hyprland itself to
-- manage the lid switch instead of logind.

--------------------
-- Media keys
--------------------

hl.bind(keys("SPACE"), run("playerctl play-pause"))
hl.bind(keys("UP"), run("playerctl next"))
hl.bind(keys("DOWN"), run("playerctl previous"))
hl.bind(keys("LEFT"), run("playerctl position 10-"))
hl.bind(keys("RIGHT"), run("playerctl position 10+"))
hl.bind(keys("COMMA"), run("playerctl position 10-"))
hl.bind(keys("PERIOD"), run("playerctl position 10+"))
hl.bind(keys("SHIFT + COMMA"), run("playerctl previous"))
hl.bind(keys("SHIFT + PERIOD"), run("playerctl next"))

local locked_repeat = { locked = true, repeating = true }
local locked = { locked = true }

hl.bind("XF86AudioRaiseVolume", run(scripts .. "/volume -i 10"), locked_repeat)
hl.bind("XF86AudioLowerVolume", run(scripts .. "/volume -d 10"), locked_repeat)
hl.bind("XF86AudioMute", run(scripts .. "/volume -m"), locked)
hl.bind("XF86AudioMicMute", run(scripts .. "/mic -m"), locked)

hl.bind(keys("XF86AudioRaiseVolume"), run(scripts .. "/mic -i 10"), locked_repeat)
hl.bind(keys("XF86AudioLowerVolume"), run(scripts .. "/mic -d 10"), locked_repeat)

hl.bind("CONTROL + XF86MonBrightnessDown", run(scripts .. "/brightness -e -d 10"), locked_repeat)
hl.bind("CONTROL + XF86MonBrightnessUp", run(scripts .. "/brightness -e -i 10"), locked_repeat)
hl.bind("XF86MonBrightnessDown", run(scripts .. "/brightness -d 1"), locked_repeat)
hl.bind("XF86MonBrightnessUp", run(scripts .. "/brightness -i 1"), locked_repeat)

hl.bind("SHIFT + XF86MonBrightnessDown", run(scripts .. "/brightness -t -d 250"), locked_repeat)
hl.bind("SHIFT + XF86MonBrightnessUp", run(scripts .. "/brightness -t -i 250"), locked_repeat)
hl.bind("SHIFT + XF86AudioMute", run(scripts .. "/brightness -t -off"), locked_repeat)

hl.bind("XF86KbdBrightnessDown", run(scripts .. "/asusctl --kblo"), locked_repeat)
hl.bind("XF86KbdBrightnessUp", run(scripts .. "/asusctl --kbhi"), locked_repeat)

hl.bind("XF86Launch1", run(scripts .. "/asusctl --rog"))
hl.bind("XF86Launch3", run(scripts .. "/asusctl --kbch"), locked)
hl.bind("XF86Launch4", run(scripts .. "/asusctl --pro"))
hl.bind("XF86TouchpadToggle", run(scripts .. "/touchpad"))

--------------------
-- Mouse binds
--------------------

hl.bind(keys("mouse_down"), hl.dsp.focus({ workspace = "e+1" }))
hl.bind(keys("mouse_up"), hl.dsp.focus({ workspace = "e-1" }))

hl.bind(keys("mouse:272"), hl.dsp.window.drag(), { mouse = true })
hl.bind(keys("mouse:273"), hl.dsp.window.resize(), { mouse = true })
hl.bind(keys("SHIFT + mouse:272"), hl.dsp.window.resize(), { mouse = true })

hl.bind("mouse:274", run("playerctl play-pause"))

--------------------
-- Submap helpers
--------------------

local notify = scripts .. "/notify"

local function enter_submap(name)
    return function()
        hl.exec_cmd(notify .. " -s " .. name)
        dispatch(hl.dsp.submap(name))
    end
end

local function reset_submap()
    hl.exec_cmd(notify .. " -s Default")
    dispatch(hl.dsp.submap("reset"))
end

local function exec_and_reset(cmd)
    return function()
        hl.exec_cmd(cmd)
        dispatch(hl.dsp.submap("reset"))
    end
end

local function common_submap_exit(toggle_key)
    hl.bind(keys("Q"), run(terminal))
    hl.bind(toggle_key, reset_submap)
    hl.bind("escape", reset_submap)
    hl.bind("CONTROL + bracketleft", reset_submap)
end

--------------------
-- OCR submap
--------------------

hl.bind(keys("CONTROL + C"), enter_submap("OCR"))

hl.define_submap("OCR", function()
    hl.bind("E", exec_and_reset(scripts .. "/screenshot -e"))
    hl.bind("H", exec_and_reset(scripts .. "/screenshot -e -l hi"))
    hl.bind("D", exec_and_reset(scripts .. "/screenshot -e -l de"))

    common_submap_exit(keys("CONTROL + C"))
    hl.bind("catchall", hl.dsp.submap("reset"))
end)

--------------------
-- TTS submap
--------------------

hl.bind(keys("CONTROL + W"), enter_submap("TTS"))

hl.define_submap("TTS", function()
    hl.bind("E", exec_and_reset(scripts .. "/tts -c"), { repeating = true })
    hl.bind("SHIFT + E", exec_and_reset(scripts .. "/tts -s"))

    hl.bind("H", exec_and_reset(scripts .. "/tts -l hin -c"), { repeating = true })
    hl.bind("SHIFT + H", exec_and_reset(scripts .. "/tts -l hin -s"))

    hl.bind("D", exec_and_reset(scripts .. "/tts -l deu -c"), { repeating = true })
    hl.bind("SHIFT + D", exec_and_reset(scripts .. "/tts -l deu -s"))

    common_submap_exit(keys("CONTROL + W"))
end)

--------------------
-- Translate submap
--------------------

-- FIXME:
-- Screenshot mode was already marked non-working in the old config.

hl.bind(keys("CONTROL + Q"), enter_submap("Translate"))

hl.define_submap("Translate", function()
    hl.bind("E", exec_and_reset(scripts .. "/translate -c"), { repeating = true })
    hl.bind("SHIFT + E", exec_and_reset(scripts .. "/translate -s"))

    hl.bind("H", exec_and_reset(scripts .. "/translate -l hin -c"), { repeating = true })
    hl.bind("SHIFT + H", exec_and_reset(scripts .. "/translate -l hin -s"))

    hl.bind("D", exec_and_reset(scripts .. "/translate -l deu -c"), { repeating = true })
    hl.bind("SHIFT + D", exec_and_reset(scripts .. "/translate -l deu -s"))

    common_submap_exit(keys("CONTROL + Q"))
end)

--------------------
-- Resize submap
--------------------

hl.bind(keys("CONTROL + R"), enter_submap("Resize"))

hl.define_submap("Resize", function()
    hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
    hl.bind("left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
    hl.bind("up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
    hl.bind("down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })

    hl.bind("H", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
    hl.bind("J", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })
    hl.bind("K", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
    hl.bind("L", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })

    common_submap_exit(keys("CONTROL + R"))
end)

--------------------
-- Power submap
--------------------

hl.bind(keys("CONTROL + E"), enter_submap("Power"))

hl.define_submap("Power", function()
    hl.bind("L", exec_and_reset("hyprlock"))
    hl.bind("H", exec_and_reset("systemctl hibernate"))
    hl.bind("K", exec_and_reset("pkill Hyprland || loginctl terminate-user $USER"))
    hl.bind("E", exec_and_reset("systemctl suspend-then-hibernate"))
    hl.bind("S", exec_and_reset("shutdown --no-wall now"))
    hl.bind("P", exec_and_reset("sudo poweroff"))
    hl.bind("R", exec_and_reset("sudo reboot"))

    common_submap_exit(keys("CONTROL + E"))
end)
