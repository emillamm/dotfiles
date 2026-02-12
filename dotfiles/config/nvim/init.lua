-- Leader keys (must be set before loading plugins)
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Options
vim.opt.makeprg = './.make'
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.hidden = false
vim.opt.number = true
vim.opt.relativenumber = true

-- Bootstrap mini.nvim and mini.deps
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.uv.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

require('mini.deps').setup({ path = { package = path_package } })

-- Load modules
require('colors').setup(MiniDeps.add)
require('plugins')
require('keymaps')
