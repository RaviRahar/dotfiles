if not vim.g.vscode then
    -- Settings for vanilla nvim
    require("core")
    -- pcall(require, "core")
    -- Plugins and their settings
    require("extras")
    -- pcall(require, "extras")
end
