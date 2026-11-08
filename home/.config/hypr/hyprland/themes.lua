-- FIXME:
-- `decoration.shadow.render_power` is currently documented as 1..4.
-- The old config used 5, so it is clamped here to 4.

-- TODO:
-- Blur now has selectable variants. The default/current value is `kawase`;
-- newer variants can look quite different but may be much more expensive.
-- Try `variant = "kawase"` explicitly before experimenting with others.

----------------
-- Cursor
----------------

-- hl.on("hyprland.start", function()
--     hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 20")
--     hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme Adwaita")
--     hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size 16")
-- end)

----------------
-- GTK themes
----------------

-- Prefer hl.env("GTK_THEME", "vimix-dark-grey") before server init if needed.

----------------
-- Smart gaps
----------------

hl.workspace_rule({ workspace = "w[tv1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]s[false]" }, border_size = 1 })
hl.window_rule({ match = { float = false, workspace = "f[1]s[false]" }, border_size = 0 })

-- Special workspace borders
hl.workspace_rule({ workspace = "s[true]", border_size = 2 })
hl.window_rule({ match = { workspace = "s[true]" }, border_color = "rgb(d3869b)" })

-- No border on floating windows.
hl.window_rule({ match = { float = true }, border_size = 0 })

hl.config({
    general = {
        gaps_in = 1,
        gaps_out = 2,
        border_size = 1,

        col = {
            active_border = "rgb(8ec07c)",
            inactive_border = "rgba(00000000)",
        },
    },

    group = {
        col = {
            border_active = "rgb(689d6a)",
            border_inactive = "rgba(00000000)",
            border_locked_active = "rgb(f5a8bd)",
            border_locked_inactive = "rgba(00000000)",
        },

        groupbar = {
            gradients = true,
            gradient_rounding = 18,
            round_only_edges = false,
            gradient_round_only_edges = true,
            text_color = "rgb(000000)",

            col = {
                active = "rgb(f5a8bd)",
                inactive = "rgba(b16479cc)",
                locked_active = "rgb(8ec07c)",
                locked_inactive = "rgba(689d6acc)",
            },
        },
    },

    decoration = {
        rounding = 15,

        active_opacity = 1.0,
        inactive_opacity = 1.0,
        fullscreen_opacity = 1.0,
        dim_inactive = false,
        dim_strength = 0.5,
        dim_special = 0.5,
        dim_around = 0.5,

        shadow = {
            enabled = false,
            range = 150,
            render_power = 4,
            color = "rgba(1a1a1aaf)",
            offset = { 0, 40 },
            scale = 0.9,
        },

        blur = {
            enabled = true,
            size = 12,
            passes = 2,
            new_optimizations = true,
            ignore_opacity = true,
            noise = 0.0917,
            brightness = 1.0,
            contrast = 1.0,
            vibrancy = 0.3696,
            vibrancy_darkness = 0.1696,
            popups = true,
            popups_ignorealpha = 0.2,
            xray = false,
            special = false,
        },
    },
})
