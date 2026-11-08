-- FIXME:
-- `general.no_border_on_floating` was removed. It is replaced below with a
-- floating-window rule that sets `border_size = 0`.
--
-- `decoration.shadow.ignore_window` is no longer a current shadow option and
-- has been dropped.
--
-- `decoration.shadow.render_power` is currently 1..4. The old value 5 is
-- clamped to 4.
--
-- `slidefade` is no longer a valid window animation style. `windowsOut`
-- is changed to `slide`; the separate fade animation still supplies fade.

hl.layer_rule({ match = { namespace = "rofi" }, dim_around = true })
hl.window_rule({ match = { float = true }, border_size = 0 })

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 0,
    },

    animations = {
        enabled = true,
    },

    decoration = {
        dim_inactive = true,
        shadow = {
            enabled = true,
        },
        blur = {
            enabled = true,
        },
    },
})

local function bezier(name, x1, y1, x2, y2)
    hl.curve(name, {
        type = "bezier",
        points = {
            { x1, y1 },
            { x2, y2 },
        },
    })
end

bezier("linear", 0, 0, 0, 0)
bezier("easeOutExpo", 0.19, 1, 0.22, 1)
bezier("easeInExpo", 0.95, 0.05, 0.795, 0.035)
bezier("easeInBack", 0.6, -0.28, 0.735, 0.045)
bezier("easeOutBack", 0.175, 0.885, 0.32, 1.275)
bezier("easeInOutCirc", 0.785, 0.135, 0.15, 0.86)
bezier("easeInOutQuart", 0.77, 0, 0.175, 1)
bezier("easeInOutQuint", 0.86, 0, 0.07, 1)
bezier("easeInOutSine", 0.445, 0.05, 0.55, 0.95)
bezier("easeOutSine", 0.39, 0.575, 0.565, 1)
bezier("bezIn", 0.5, 0.0, 1.0, 0.5)
bezier("bezOut", 0.0, 0.5, 0.5, 1.0)
bezier("overshot", 0.05, 0.9, 0.1, 1.05)
bezier("smoothOut", 0.36, 0, 0.66, -0.56)
bezier("smoothIn", 0.25, 1, 0.5, 1)
bezier("realsmooth", 0.28, 0.29, 0.69, 1.08)

local function anim(leaf, speed, curve, style)
    hl.animation({
        leaf = leaf,
        enabled = true,
        speed = speed,
        curve = curve,
        style = style,
    })
end

anim("windows", 5, "realsmooth", "slide")
anim("windowsOut", 5, "realsmooth", "slide")
anim("windowsMove", 5, "realsmooth", "slide")
anim("border", 5, "realsmooth")
anim("borderangle", 5, "realsmooth")
anim("fade", 5, "realsmooth")
anim("fadeLayers", 5, "realsmooth")
anim("fadeDim", 5, "realsmooth")
anim("fadeSwitch", 5, "realsmooth")
anim("fadeShadow", 5, "realsmooth")
anim("workspaces", 5, "realsmooth", "slidefadevert")
anim("specialWorkspace", 5, "realsmooth", "slidefadevert")
anim("monitorAdded", 5, "realsmooth")

hl.config({
    decoration = {
        rounding = 30,

        active_opacity = 0.75,
        inactive_opacity = 0.75,
        fullscreen_opacity = 0.80,
        dim_strength = 0.1,
        dim_special = 0.2,
        dim_around = 0.4,

        shadow = {
            enabled = true,
            range = 150,
            render_power = 4,
            color = "rgba(1a1a1aaf)",
            offset = { 0, 40 },
            scale = 0.9,
        },

        blur = {
            enabled = true,
            size = 12,
            passes = 4,
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
            special = true,
        },
    },
})
