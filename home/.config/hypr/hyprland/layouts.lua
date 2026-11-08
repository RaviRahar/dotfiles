-- TODO:
-- Hyprland now also ships `scrolling` and `monocle` layouts. You can try one
-- globally by changing `general.layout`, or per-workspace with a workspace rule.

hl.config({
    general = {
        layout = "dwindle",
    },

    dwindle = {
        preserve_split = true,
        force_split = 1,
        -- smart_split = false,
    },

    master = {
        new_status = "master",
        orientation = "right",
        new_on_top = true,
        -- mfact = 0.565, -- old note: ~80 chars wide for center
        slave_count_for_center_master = 0,
    },
})
