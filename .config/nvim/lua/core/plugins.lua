local packer = {}

function packer:packer_check()
  local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  end
end

function packer:packer_load_plugins()
  return require('packer').startup(
    function(use)
      -- Plugins
      use 'wbthomason/packer.nvim'


      if packer_bootstrap then
          require('packer').sync()
      end
    end)
end



function packer:packer_autocompile()

  vim.api.nvim_exec([[
  augroup PackerAutoCompile
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]], false)

end


packer:packer_check()
packer:packer_load_plugins()
packer:packer_autocompile()

return packer
