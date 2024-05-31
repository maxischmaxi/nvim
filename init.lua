vim.g.mapleader = ' '
vim.opt.colorcolumn = "80"
vim.g.maplocalleader = ' '
vim.o.wrap = true
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
vim.wo.relativenumber = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true
vim.o.language = 'en_US'
vim.diagnostic.config({
  underline = true,
})

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

-- require 'custom.netrw'
-- require 'custom.yankhighlight'
require 'custom.keymaps'
require 'custom.rebase'

require('lazy').setup({
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'tpope/vim-sleuth',
  require 'custom.copilot',
  require 'custom.treesitter',
  require 'custom.tmux-navigation',
  require 'custom.lualine',
  -- require 'custom.gitsigns',
  require 'custom.prettier',
  -- require 'custom.cursorline',
  require 'custom.lsp-config',
  require 'custom.nvim-cmp',
  require 'custom.telescope',
  -- require 'custom.trouble',
  -- require 'custom.vim-apm',
  -- require 'custom.git-blame',
  require 'custom.comment',
  require 'custom.autopairs',
  require 'custom.toggleterm',
  -- require 'custom.visual-multi',
  -- require 'custom.leap',
  require 'custom.oil',
  -- require 'custom.codeium',
  require 'custom.colorscheme',
  -- require 'custom.rust-tools',
  -- require 'custom.chatgpt',
  -- require 'custom.git-conflict',
  require 'custom.format-on-save',
  require 'custom.whichkey',
}, {})
