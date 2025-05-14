if not vim.g.vscode then
    -- Basic settings for vanilla nvim
    require("core")
    -- pcall(require, "core")

    -- Nuanced customizations
    require("custom")
    -- pcall(require, "custom")

    -- Customizations with external dependencies
    require("external")
    -- pcall(require, "external")

    -- Plugins
    require("plugins")
    -- pcall(require, "plugins")

    require("keybindings")
    -- pcall(require, "keybindings")
end
