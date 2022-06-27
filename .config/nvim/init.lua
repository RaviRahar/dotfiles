if not vim.g.vscode then
  -- Setttings for vanilla nvim
  pcall(require, 'core')
  -- Plugins and their settings
  pcall(require, 'plugins')
end
