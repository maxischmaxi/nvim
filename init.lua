vim.g.mapleader = ' '
vim.opt.colorcolumn = "80"
vim.g.maplocalleader = ' '
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.opt.scrolloff = 99
vim.opt.fillchars = { fold = ' ' }
vim.opt.foldmethod = 'indent'
vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.opt.cursorline = true
vim.o.hlsearch = false
vim.wo.number = true
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.signcolumn = 'yes'
vim.wo.relativenumber = false
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true
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

local uv = vim.loop

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    if vim.env.TMUX_PLUGIN_MANAGER_PATH then
      uv.spawn(vim.env.TMUX_PLUGIN_MANAGER_PATH .. '/tmux-window-name/scripts/rename_session_windows.py', {})
    end
  end,
})

require 'custom.keymaps'

require('lazy').setup({
  'tpope/vim-fugitive',
  -- 'tpope/vim-rhubarb',
  'tpope/vim-sleuth',
  require 'custom.oil',
  require 'custom.flash',
  require 'custom.treesitter',
  require 'custom.copilot',
  require 'custom.tmux-navigation',
  require 'custom.lualine',
  -- require 'custom.gitsigns',
  -- require 'custom.prettier',
  require 'custom.flutter-tools',
  require 'custom.lsp-config',
  require 'custom.dressing',
  require 'custom.nvim-cmp',
  require 'custom.autotag',
  require 'custom.telescope',
  -- require 'custom.neoscroll',
  require 'custom.comment',
  require 'custom.autopairs',
  require 'custom.colorscheme',
  require 'custom.format-on-save',
  -- require 'custom.error-lens',
  -- require 'custom.whichkey',
}, {})
