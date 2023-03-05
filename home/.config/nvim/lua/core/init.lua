-- vim.g.did_load_filetypes = 1
local disable_distribution_plugins = function()
    vim.g.did_load_fzf = 1
    vim.g.did_load_gtags = 1
    vim.g.did_load_gzip = 1
    vim.g.did_load_tar = 1
    vim.g.did_load_tarPlugin = 1
    vim.g.did_load_zip = 1
    vim.g.did_load_zipPlugin = 1
    vim.g.did_load_getscript = 1
    vim.g.did_load_getscriptPlugin = 1
    vim.g.did_load_vimball = 1
    vim.g.did_load_vimballPlugin = 1
    vim.g.did_load_matchit = 1
    vim.g.did_load_matchparen = 1
    vim.g.did_load_2html_plugin = 1
    vim.g.did_load_logiPat = 1
    vim.g.did_load_rrhelper = 1
    vim.g.did_load_netrw = 1
    vim.g.did_load_netrwPlugin = 1
    vim.g.did_load_netrwSettings = 1
    vim.g.did_load_netrwFileHandlers = 1
end

local leader_map = function()
    vim.g.mapleader = ";"
    vim.keymap.set("n", " ", "", { noremap = true })
    vim.keymap.set("v", " ", "", { noremap = true })
end

local function check_conda()
    local venv = os.getenv("CONDA_PREFIX")
    if venv then
        vim.g.python3_host_prog = venv .. "/bin/python"
    end
end

local function load_core()
    disable_distribution_plugins()
    leader_map()
    require("core.customs")
    require("core.defaults")
    check_conda()
end

load_core()
