if not vim.g.vscode then
  -- Setttings for vanilla nvim
  require('core')
  --pcall(require, 'core')
  -- Plugins and their settings
  require('plugins')
  --pcall(require, 'plugins')
end
