vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.opt.scrolloff = 20
vim.opt.fillchars = { fold = ' ' }
vim.opt.foldmethod = 'indent'
vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.o.hlsearch = false
vim.wo.number = true
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require 'custom.config.autocmd'
require 'custom.netrw.netrw'
require 'custom.plugins.yankhighlight'
require 'custom.keymaps.base'

require('lazy').setup({
  'nvim-lua/plenary.nvim',
  'windwp/nvim-ts-autotag',
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'tpope/vim-sleuth',
  'github/copilot.vim',
  require 'custom.plugins.treesitter',
  require 'custom.plugins.tokyonight',
  require 'custom.plugins.tmux-navigation',
  require 'custom.plugins.lualine',
  require 'custom.plugins.gitsigns',
  require 'custom.plugins.wilder',
  require 'custom.plugins.null-ls',
  require 'custom.plugins.prettier',
  require 'custom.plugins.cursorline',
  require 'custom.plugins.ufo',
  require 'custom.plugins.spectre',
  require 'custom.plugins.dressing',
  require 'custom.plugins.autopairs',
  require 'custom.plugins.toggleterm',
  require 'custom.plugins.lsp-config',
  require 'custom.plugins.nvim-cmp',
  require 'custom.plugins.telescope',
  'folke/which-key.nvim',
}, {})

require 'custom.config.whichkey'
