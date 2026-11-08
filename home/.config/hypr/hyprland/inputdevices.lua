-- TODO:
-- `input.follow_mouse_threshold` can add a small dead-zone before pointer
-- movement refocuses another window if accidental focus changes bother you.

local touchpadStatus = true

hl.config({
    input = {
        kb_layout = "us, us, de, in, in",
        kb_variant = ", intl, nodeadkeys, , bolnagri",
        kb_model = "",
        kb_rules = "",
        kb_options = "grp:alt_caps_toggle",

        -- resolve_binds_by_sym = true,

        follow_mouse = 1,
        mouse_refocus = true,
        sensitivity = 0,

        touchpad = {
            natural_scroll = true,
            disable_while_typing = touchpadStatus,
        },
    },
})

hl.device({
    name = "asue120d:00-04f3:31fb-touchpad",
    enabled = touchpadStatus,
})
