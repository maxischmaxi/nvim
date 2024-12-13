vim.g.mapleader = ' '
vim.opt.colorcolumn = "120"
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
vim.opt.termguicolors = true
vim.diagnostic.config({
  underline = true,
})

vim.g.loaded_perl_provider = 0

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

vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', '<c-d>', '<c-d>zz', { desc = 'Scroll down half screen' })
vim.keymap.set('n', '<c-u>', '<c-u>zz', { desc = 'Scroll down half screen' })
vim.keymap.set('n', 'º', ':m .+1<CR>==', { silent = true })
vim.keymap.set('i', 'º', '<Esc>:m .+1<CR>==', { silent = true })
vim.keymap.set('v', 'º', ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('n', '∆', ':m .-2<CR>==', { silent = true })
vim.keymap.set('i', '∆', '<Esc>:m .-2<CR>==', { silent = true })
vim.keymap.set('v', '∆', ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set('n', '<leader>+', ':exe "vertical resize " . (winwidth(0) * 3/2)<CR>', { silent = true })
vim.keymap.set('n', '<leader>-', ':exe "vertical resize " . (winwidth(0) * 2/3)<CR>', { silent = true })

vim.keymap.set('n', '<c-l>', '<c-w><c-l>', { silent = true })
vim.keymap.set('n', '<c-h>', '<c-w><c-h>', { silent = true })
vim.keymap.set('n', '<c-j>', '<c-w><c-j>', { silent = true })
vim.keymap.set('n', '<c-k>', '<c-w><c-k>', { silent = true })

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

require('lazy').setup({
  'tpope/vim-sleuth',
  require 'custom.colorscheme',
  require 'custom.oil',
  require 'custom.flash',
  require 'custom.treesitter',
  require 'custom.copilot',
  require 'custom.tmux-navigation',
  require 'custom.lualine',
  require 'custom.lsp-config',
  -- require 'custom.dressing',
  require 'custom.nvim-cmp',
  require 'custom.autotag',
  require 'custom.autopairs',
  require 'custom.telescope',
  -- require 'custom.tailwindcss',
  require 'custom.comment',
  -- require 'custom.floatterm',
  require 'custom.format-on-save',
  require 'custom.gitsigns',
  -- require 'custom.neoformat',
  require 'custom.prettier',
}, {})
