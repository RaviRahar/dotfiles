-- TODO:
-- Lua animations now support spring curves in addition to cubic Beziers:
-- hl.curve("softSpring", {
--     type = "spring",
--     mass = 1,
--     stiffness = 70,
--     dampening = 10,
-- })

hl.config({ animations = { enabled = false } })

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

-- FIXME:
-- Original:
--     spec.curve = curve
-- Hyprland's Lua animation API requires the curve type to be explicit:
-- use `bezier = "name"` for Bézier curves or `spring = "name"` for springs.
-- Every curve used below is a Bézier, so this helper sets `spec.bezier`.

local function anim(leaf, enabled, speed, bezier, style)
    local spec = {
        leaf = leaf,
        enabled = enabled,
    }

    if enabled then
        spec.speed = speed
        spec.bezier = bezier

        if style ~= nil then
            spec.style = style
        end
    end

    hl.animation(spec)
end

anim("windows", true, 3, "easeOutBack", "popin 70%")
anim("windowsOut", true, 3, "easeInBack", "slide")
anim("windowsMove", true, 3, "easeOutBack", "slide")
anim("border", true, 3, "default")
anim("borderangle", true, 3, "default")
anim("fade", false)
anim("layers", true, 2, "realsmooth", "fade")
anim("fadeLayers", true, 2, "realsmooth")
anim("fadeOut", true, 2, "realsmooth")
anim("workspaces", true, 3, "easeInOutCirc", "slidevert")
anim("specialWorkspace", true, 3, "easeInOutCirc", "slidefadevert")
anim("monitorAdded", true, 5, "realsmooth")
