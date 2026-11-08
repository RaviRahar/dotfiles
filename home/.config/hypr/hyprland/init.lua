-- FIXME:
-- `general.hover_icon_on_border` is now a boolean. The old numeric value `15`
-- belongs to `general.extend_border_grab_area`, so the old intent is preserved
-- with `extend_border_grab_area = 15` and `hover_icon_on_border = true`.
--
-- `misc.exit_window_retains_fullscreen` changed from bool to an integer mode.
-- The old `true` behavior maps to mode `1`.

-- TODO:
-- If this session is launched with UWSM, move environment variables out of
-- Hyprland and into ~/.config/uwsm/env and ~/.config/uwsm/env-hyprland.
--
-- TODO:
-- Hyprland now supports ecosystem permissions. Consider enabling
-- `ecosystem.enforce_permissions` only after explicitly allowing the plugins /
-- screencopy tools you actually use.

----------------
-- MONITORS
----------------

hl.monitor({
    output = "",
    mode = "2560x1440@60",
    position = "0x0",
    scale = 1.6,
})

-- Used to mirror:
-- hl.monitor({
--     output = "DP-9",
--     mode = "highres",
--     position = "auto",
--     scale = 1.6,
--     mirror = "eDP-1",
-- })

for _, output in ipairs({ "DP-1", "DP-2", "DP-9", "DP-10", "DP-11" }) do
    hl.monitor({
        output = output,
        mode = "highres",
        position = "auto-left",
        scale = 1.333333,
    })
end

-----------------------------
-- ENVIRONMENT VARIABLES
-----------------------------

-- Applications
hl.env("XCURSOR_THEME", "Adwaita")
hl.env("XCURSOR_SIZE", "16")
hl.env("HYPRCURSOR_THEME", "Adwaita")
hl.env("HYPRCURSOR_SIZE", "16")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("MOZ_DISABLE_RDD_SANDBOX", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
-- Optional
-- hl.env("CUDA_DISABLE_PERF_BOOST", "1")

-- Toolkits
-- hl.env("GDK_SCALE", "2")
hl.env("GTK_USE_PORTAL", "1")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_SCALE_FACTOR", "1")
-- hl.env("QT_STYLE_OVERRIDE", "kvantum")

-- XDG
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")

-- Nvidia
-- hl.env("GBM_BACKEND", "nvidia-drm")
-- hl.env("NVD_BACKEND", "direct")
-- hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
-- hl.env("LIBVA_DRIVER_NAME", "nvidia")
-- hl.env("__GL_GSYNC_ALLOWED", "1")
-- hl.env("__GL_VRR_ALLOWED", "1")
-- Don't Use
-- hl.env("__NV_PRIME_RENDER_OFFLOAD", "1")

local home = os.getenv("HOME") or ""
-- hl.env("AQ_DRM_DEVICES", home .. "/.config/hypr/gpu/cardamd")
hl.env("AQ_DRM_DEVICES", home .. "/.config/hypr/gpu/cardamd:" .. home .. "/.config/hypr/gpu/cardnvidia")

----------------
-- CONFIG
----------------

hl.config({
    debug = {
        suppress_errors = false,
        -- error_position = 0,
        -- error_limit = 5,
        vfr = true,
    },

    cursor = {
        no_hardware_cursors = 2,
        hide_on_key_press = false,
        inactive_timeout = 3,
        sync_gsettings_theme = true,
        zoom_factor = 1,
        zoom_rigid = true,
        enable_hyprcursor = true,
        use_cpu_buffer = 2,
    },

    xwayland = {
        force_zero_scaling = true,
    },

    general = {
        resize_on_border = true,
        extend_border_grab_area = 15,
        hover_icon_on_border = true,
        allow_tearing = false,
        no_focus_fallback = true,
    },

    gestures = {
        workspace_swipe_distance = 150,
        workspace_swipe_min_speed_to_force = 95,
        workspace_swipe_cancel_ratio = 0.3,
        workspace_swipe_forever = true,
        workspace_swipe_create_new = true,
    },

    binds = {
        movefocus_cycles_fullscreen = true,
        disable_keybind_grabbing = false,
        workspace_back_and_forth = true,
        allow_workspace_cycles = true,
        workspace_center_on = 1,
        hide_special_on_workspace_change = true,

        -- TODO:
        -- The removed `setignoregrouplock` dispatcher has a static equivalent:
        -- ignore_group_lock = true,
    },

    misc = {
        vrr = 1,
        middle_click_paste = false,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        force_default_wallpaper = 0,
        animate_manual_resizes = true,
        animate_mouse_windowdragging = false,
        enable_swallow = false,
        -- swallow_regex = "^(Alacritty|kitty|foot|FreeTube)$",
        -- swallow_exception_regex = "[[]]",
        exit_window_retains_fullscreen = 1,
        close_special_on_empty = true,
        on_focus_under_fullscreen = 1,
        key_press_enables_dpms = true,
        mouse_move_enables_dpms = true,
        focus_on_activate = false,
        lockdead_screen_delay = 1000,
        enable_anr_dialog = true,
        anr_missed_pings = 3,
    },

    ecosystem = {
        no_update_news = false,
        no_donation_nag = true,

        -- TODO:
        -- enforce_permissions = true,
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

-- TODO:
-- Hyprland now has a native live pinch-to-cursor zoom gesture:
hl.gesture({
    fingers = 2,
    direction = "pinch",
    action = "cursor_zoom",
    zoom_level = 2,
    mode = "live",
})
