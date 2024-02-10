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

require('lazy').setup({
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require 'custom.config.tokyonight'

      vim.cmd [[colorscheme tokyonight]]
    end,
  },
  {
    'alexghergh/nvim-tmux-navigation',
    config = function()
      local nvim_tmux_nav = require 'nvim-tmux-navigation'

      nvim_tmux_nav.setup {
        disable_when_zoomed = true, -- defaults to false
      }

      vim.keymap.set('n', '<C-h>', nvim_tmux_nav.NvimTmuxNavigateLeft)
      vim.keymap.set('n', '<C-j>', nvim_tmux_nav.NvimTmuxNavigateDown)
      vim.keymap.set('n', '<C-k>', nvim_tmux_nav.NvimTmuxNavigateUp)
      vim.keymap.set('n', '<C-l>', nvim_tmux_nav.NvimTmuxNavigateRight)
      vim.keymap.set('n', '<C-\\>', nvim_tmux_nav.NvimTmuxNavigateLastActive)
      vim.keymap.set('n', '<C-Space>', nvim_tmux_nav.NvimTmuxNavigateNext)
    end,
  },
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'tpope/vim-sleuth',
  'github/copilot.vim',
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require 'custom.config.lualine'
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require 'custom.config.gitsigns'
    end,
  },
  'folke/which-key.nvim',
  {
    'gelguy/wilder.nvim',
    config = function()
      require 'custom.config.wilder'
    end,
    build = function()
      vim.cmd [[let &rtp=&rtp]]
      vim.api.nvim_command 'runtime! plugin/rplugin.vim'
      vim.api.nvim_command ':UpdateRemotePlugins'
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require 'custom.config.null-ls'
    end,
  },
  {
    'MunifTanjim/prettier.nvim',
    config = function()
      require 'custom.config.prettier'
    end,
  },
  'nvim-lua/plenary.nvim',
  {
    'yamatsum/nvim-cursorline',
    config = function()
      require 'custom.config.cursorline'
    end,
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
    },
    config = function()
      require 'custom.config.ufo'
    end,
  },
  {
    'nvim-pack/nvim-spectre',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require 'custom.config.spectre'
    end,
  },
  {
    'stevearc/dressing.nvim',
    opts = {},
    config = function()
      require('dressing').setup()
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },
  {
    'windwp/nvim-ts-autotag',
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require 'custom.config.toggleterm'
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'folke/neodev.nvim',
    },

    config = function()
      require 'custom.config.mason_lsp'
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      require 'custom.config.cmp'
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    config = function()
      require 'custom.config.telescope'
      require 'custom.keymaps.telescope'
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    config = function()
      require 'custom.config.treesitter'
    end,
  },
}, {})

-- Plugins
require 'custom.plugins.yankhighlight'

-- Config
require 'custom.config.autocmd'
require 'custom.config.whichkey'
require 'custom.plugins.globalsearch'
require 'custom.netrw.netrw'

-- Keymaps
require 'custom.keymaps.base'
