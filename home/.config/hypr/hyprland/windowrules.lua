-- FIXME:
-- The old `special:youtube` workspace used `$youtubenogpu`, but that variable
-- is not defined anywhere in the active config. The rule is left disabled
-- below. Define a command first if you still use that scratchpad.
--
-- FIXME:
-- `windowrulev2` no longer exists as a separate Lua API. Both old
-- `windowrule` and `windowrulev2` rules are expressed with `hl.window_rule()`.

-- TODO:
-- Layer rules can now use `no_screen_share = true`. That can be useful for
-- notification layers if you do not want notification contents appearing in
-- recordings / screen sharing. It is intentionally not enabled here.

--------------------
-- Window rules
--------------------

hl.window_rule({ match = { tag = "idletag" }, idle_inhibit = "always" })
hl.window_rule({ match = { fullscreen_state_internal = 2 }, idle_inhibit = "fullscreen" })
hl.window_rule({ match = { class = "^(FreeTube|firefox-developer-edition)$" }, fullscreen_state = "0 2" })

--------------------
-- Scratchpads
--------------------

local flashcard = "anki"
local filemanager = "thunar"
local browser = "firefox-developer-edition -P default-release"
local browserwork = "firefox-developer-edition -P Work"
local terminal = "foot"
local music = "mixtapes"
local youtube = "freetube"
local youtubenogpu = "freetube --disable-gpu" -- define this first

hl.workspace_rule({ workspace = "special:flashcard", on_created_empty = flashcard, persistent = false })
hl.workspace_rule({ workspace = "special:filemanager", on_created_empty = filemanager, persistent = false })
hl.workspace_rule({ workspace = "special:browser", on_created_empty = browser, persistent = false })
hl.workspace_rule({ workspace = "special:terminal", on_created_empty = terminal, persistent = false })
hl.workspace_rule({ workspace = "special:work", on_created_empty = browserwork, persistent = false })
hl.workspace_rule({ workspace = "special:youtube", on_created_empty = youtube, persistent = false })
hl.workspace_rule({ workspace = "special:music", on_created_empty = music, persistent = false })

hl.window_rule({ match = { workspace = "special:terminal", class = "^(foot)$" }, float = true })
hl.window_rule({ match = { class = "^(thunar)$", title = "negative:^(.* - Thunar)$" }, float = true })

--------------------
-- Size / position
--------------------

-- hl.window_rule({ match = { float = true }, size = { 600, 380 } })
-- hl.window_rule({ match = { float = true }, center = true })

hl.window_rule({
    match = {
        float = true,
        class = "negative:^(xviix64.exe|ltspice.exe)$",
    },
    size = { 600, 380 },
    center = true,
})


local function size_rule(class, width, height, extra_match)
    local match = { class = class }
    if extra_match then
        for k, v in pairs(extra_match) do
            match[k] = v
        end
    end

    hl.window_rule({ match = match, size = { width, height } })
end

size_rule("^(anki)$", 1000, 800)
size_rule("^(firefox-developer-edition)$", 800, 600, { workspace = "special:youtube" })
size_rule("^(firefox-developer-edition)$", 1000, 800, { title = "negative:^(Picture-in-Picture|Library|Opening .*)$" })
size_rule("^(foot)$", 1000, 800)
size_rule("^(FreeTube)$", 1000, 800)
size_rule("^(org.gnome.Calendar)$", 1000, 800)
size_rule("^(rog-control-center)$", 1000, 800)
size_rule("^(mpv)$", 800, 600, { workspace = "special:music" })
size_rule("^(ls.bloomee.musicplayer)$", 800, 600, { workspace = "special:music" })
size_rule("^(com.pocoguy.Muse)$", 1000, 800)
size_rule("^(bloomee)$", 1000, 800)
size_rule("^(engrampa)$", 800, 600)
size_rule("^(xdg-desktop-portal-gtk)$", 800, 600)

hl.window_rule({ match = { class = "^(rog-control-center)$" }, rounding = 5 })

--------------------
-- Opacity
--------------------

hl.window_rule({ match = { class = "^(imv|mpv)$" }, opaque = true })
hl.window_rule({ match = { class = "^(nl.hjdskes.gcolor3)$" }, opaque = true })
hl.window_rule({ match = { class = "^(org.kde.polkit-kde-authentication-agent-1)$" }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(polkit-gnome-authentication-agent-1)$" }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^([tT]hunar)$" }, opacity = "0.80 0.80" })

--------------------
-- Floating windows
--------------------

local function float_rule(class, extra_match)
    local match = { class = class }
    if extra_match then
        for k, v in pairs(extra_match) do
            match[k] = v
        end
    end

    hl.window_rule({ match = match, float = true })
end

float_rule("^(com.pocoguy.Muse)$")
float_rule("^(nl.hjdskes.gcolor3)$")
float_rule("^(ls.bloomee.musicplayer)$")
float_rule("^(imv|mpv)$")
float_rule("^(engrampa)$")
float_rule("^(org.gnome.Calendar)$")

float_rule("^(org.mozilla.Thunderbird)$", {
    initial_class = "^(org.mozilla.Thunderbird)$",
    initial_title = "^( )$",
})

hl.window_rule({
    match = {
        class = "negative:^(org.mozilla.Thunderbird)$",
        initial_class = "^(org.mozilla.Thunderbird)$",
    },
    float = true,
})

float_rule("^(rog-control-center)$")
float_rule("^(blender)$", { initial_title = "^(Blender)$", title = "^(Blender Info Log)$" })
float_rule("^(blender)$", { initial_title = "^(Blender)$", title = "^(Blender Preferences)$" })
float_rule("^(org.kde.dolphin)$", { title = "^(Progress Dialog — Dolphin)$" })
float_rule("^(org.kde.dolphin)$", { title = "^(Copying — Dolphin)$" })

float_rule("^(firefox)$", { title = "^(Picture-in-Picture)$" })
float_rule("^(firefox-developer-edition)$", { title = "^(Picture-in-Picture)$" })
float_rule("^(firefox)$", { title = "^(Library)$" })
float_rule("^(firefox-developer-edition)$", { title = "^(Library)$" })
float_rule("^(firefox)$", { title = "^(Opening .*)$" })
float_rule("^(firefox-developer-edition)$", { title = "^(Opening .*)$" })

float_rule("^(kitty)$", { title = "^(top)$" })
float_rule("^(kitty)$", { title = "^(btop)$" })
float_rule("^(kitty)$", { title = "^(htop)$" })

for _, class in ipairs({
    "^(vlc)$",
    "^(kvantummanager)$",
    "^(qt5ct)$",
    "^(qt6ct)$",
    "^(nwg-look)$",
    "^(org.kde.ark)$",
    "^(pavucontrol)$",
    "^(blueman-manager)$",
    "^(nm-applet)$",
    "^(nm-connection-editor)$",
    "^(org.kde.polkit-kde-authentication-agent-1)$",
    "^(Signal)$",
    "^(com.github.rafostar.Clapper)$",
    "^(app.drey.Warp)$",
    "^(net.davidotek.pupgui2)$",
    "^(yad)$",
    "^(eog)$",
    "^(io.github.alainm23.planify)$",
    "^(io.gitlab.theevilskeleton.Upscaler)$",
    "^(com.github.unrud.VideoDownloader)$",
    "^(io.gitlab.adhami3310.Impression)$",
    "^(io.missioncenter.MissionCenter)$",
    "^(xdg-desktop-portal-gtk)$",
}) do
    float_rule(class)
end

-----------------------------
-- xwayland-videobridge
-----------------------------

local videobridge = "^(xwaylandvideobridge)$"

hl.window_rule({ match = { class = videobridge }, opacity = "0.0 override" })
hl.window_rule({ match = { class = videobridge }, no_anim = true })
hl.window_rule({ match = { class = videobridge }, no_initial_focus = true })
hl.window_rule({ match = { class = videobridge }, max_size = { 1, 1 } })
hl.window_rule({ match = { class = videobridge }, no_blur = true })
hl.window_rule({ match = { class = videobridge }, no_focus = true })

--------------------
-- Layer rules
--------------------

hl.layer_rule({ match = { namespace = "rofi" }, blur = true })
hl.layer_rule({ match = { namespace = "waybar" }, above_lock = 1 })
hl.layer_rule({ match = { namespace = "rofi" }, ignore_alpha = 0 })
hl.layer_rule({ match = { namespace = "rofi" }, dim_around = true })

for _, namespace in ipairs({
    "notifications",
    "swaync-notification-window",
    "swaync-control-center",
}) do
    hl.layer_rule({ match = { namespace = namespace }, blur = true })

    hl.layer_rule({
        match = { namespace = namespace },
        ignore_alpha = 0,

        -- TODO:
        -- no_screen_share = true,
    })
end

hl.layer_rule({ match = { namespace = "logout_dialog" }, blur = true })
