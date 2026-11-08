-- FIXME:
-- Hyprspace is still maintained, but its current upstream build pins
-- Hyprland v0.55.0. There is also an open upstream issue reporting that
-- Hyprspace fails to build against Hyprland v0.56.0.
--
-- If you are running Hyprland 0.56.x, keep this disabled until Hyprspace
-- catches up (or until you have a known-compatible Hyprspace revision).
--
-- FIXME:
-- Hyprpm loads enabled plugins only after `hyprpm reload`. Lua plugin config
-- must be evaluated while the plugin is loaded. Because your old Hyprspace
-- config was entirely commented out, this file stays disabled too.
--
-- When you decide to enable it, make sure Hyprspace is already loaded before
-- this file is evaluated (or reload the Hyprland config after `hyprpm reload`).

-- TODO:
-- Hyprspace now exposes `exitKey`. Its default is Escape; setting it explicitly
-- can be useful if you want a different overview-only exit key.
--
-- TODO:
-- `showSpecialWorkspace = true` may be especially useful with your scratchpad
-- setup, since you use several special workspaces.
--
-- TODO:
-- For a more "overview is a workspace switcher" feel, experiment with:
--     autoScroll   = true
--     switchOnDrop = true
--     exitOnSwitch = true
--
-- TODO:
-- `reverseSwipe = true` reverses Hyprspace's swipe direction if the default
-- gesture direction feels backwards.

-- Preserve the old state: the complete Hyprspace block was commented out.
local enabled = false

if enabled then
    -- Current Hyprland plugin docs recommend guarding plugin configuration
    -- so an unloaded plugin does not produce config errors.
    if hl.plugin.Hyprspace ~= nil then
        hl.config({
            plugin = {
                overview = {
                    ----------------
                    -- Colors
                    ----------------

                    -- panelColor = "...",
                    -- panelBorderColor = "...",
                    -- workspaceActiveBackground = "...",
                    -- workspaceInactiveBackground = "...",

                    workspaceActiveBorder = "rgb(8ec07c)",
                    workspaceInactiveBorder = "rgba(00000000)",

                    -- dragAlpha = 0.85,
                    disableBlur = false,

                    ----------------
                    -- Layout
                    ----------------

                    panelHeight = 200,

                    -- panelBorderWidth = 1,
                    -- onBottom = false,

                    workspaceMargin = 15,

                    -- reservedArea = 0,

                    workspaceBorderSize = 4,
                    centerAligned = true,

                    -- hideBackgroundLayers = false,
                    -- hideTopLayers = false,
                    -- hideOverlayLayers = false,
                    -- hideRealLayers = false,

                    drawActiveWorkspace = true,

                    ----------------
                    -- Gap override
                    ----------------

                    -- NOTE:
                    -- `gapsIn` / `gapsOut` only matter when `overrideGaps`
                    -- is enabled.
                    --
                    -- overrideGaps = true,
                    gapsIn = 2,
                    gapsOut = 5,

                    -- `affectStrut = false` also disables overrideGaps.
                    -- affectStrut = true,

                    ----------------
                    -- Animation
                    ----------------

                    -- overrideAnimSpeed = 1.0,

                    ----------------
                    -- Behavior
                    ----------------

                    -- autoDrag = false,
                    -- autoScroll = true,
                    -- exitOnClick = true,
                    -- switchOnDrop = true,
                    -- exitOnSwitch = true,

                    showNewWorkspace = false,
                    showEmptyWorkspace = false,

                    -- TODO:
                    -- You use several special workspaces. This is worth trying
                    -- once Hyprspace is enabled.
                    -- showSpecialWorkspace = true,

                    disableGestures = true,

                    -- reverseSwipe = false,

                    -- TODO:
                    -- Current Hyprspace supports an explicit overview exit key.
                    -- exitKey = "Escape",
                },
            },
        })
    end
end
