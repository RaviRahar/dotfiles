-- FIXME:
-- `merge_groups_on_groupbar = true` only takes effect when
-- `merge_groups_on_drag = true` as well. Your old config has the latter
-- disabled, so groupbar merging remains effectively disabled here.

-- TODO:
-- `group.groupbar.disable_when_only = true` hides the tab bar when a group
-- contains only one window. `groupbar.blur` is also available now.

hl.config({
    group = {
        auto_group = true,
        insert_after_current = true,
        focus_removed_window = true,
        drag_into_group = 2,
        merge_groups_on_drag = false,
        merge_groups_on_groupbar = true,
        merge_floated_into_tiled_on_groupbar = false,
        group_on_movetoworkspace = false,

        groupbar = {
            enabled = true,
            -- disable_when_only = true,
            font_family = "FiraCode Nerd Font",
            font_size = 14,
            height = 20,
            indicator_height = 0,
            stacked = false,
            priority = 3,
            render_titles = true,
            scrolling = true,
            -- blur = true,
        },
    },
})
