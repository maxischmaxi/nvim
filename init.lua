local global_options = {
    mapleader = ' ',
    loaded_perl_provider = 0,
    maplocalleader = ' ',
    netrw_keepdir = 1,
    netrw_winsize = 17,
    netrw_banner = '0',
    netrw_sizestyle = 'H',
    netrw_localmkdir = 'mkdir -p',
    netrw_localcopycmd = 'cp -r',
    netrw_localrmdir = 'rm -rf',
    netrw_list_hide = [['\(^\|\s\s\)\zs\.\S\+']]
}

for k, v in pairs(global_options) do vim.g[k] = v end

local o_options = {
    wrap = false,
    expandtab = true,
    hlsearch = true,
    mouse = 'a',
    breakindent = true,
    undofile = true,
    ignorecase = true,
    smartcase = true,
    updatetime = 250,
    timeoutlen = 300,
    completeopt = 'menuone,noselect',
    scrolloff = 12,
    fillchars = {fold = ' '},
    foldmethod = 'indent',
    foldenable = false,
    foldlevel = 99,
    cursorline = false,
    termguicolors = true,
    clipboard = 'unnamedplus',
    tabstop = 4,
    shiftwidth = 4,
    softtabstop = 4,
    autoindent = true,
    smartindent = true
}

for k, v in pairs(o_options) do vim.opt[k] = v end

local wo_options = {number = true, signcolumn = 'yes', relativenumber = false}

for k, v in pairs(wo_options) do vim.wo[k] = v end

vim.diagnostic.config({
    underline = true,
    virtual_text = {source = 'if_many', spacing = 2},
    signs = true,
    update_in_insert = false,
    severity_sort = true
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git', 'clone', '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath
    }
end
vim.opt.rtp:prepend(lazypath)

local set = vim.keymap.set

set('n', 'n', 'nzzzv')
set('n', 'N', 'Nzzzv')
set('n', '<c-d>', '<c-d>zz', {desc = 'Scroll down half screen'})
set('n', '<c-u>', '<c-u>zz', {desc = 'Scroll down half screen'})
set('n', 'º', ':m .+1<CR>==', {silent = true})
set('i', 'º', '<Esc>:m .+1<CR>==', {silent = true})
set('v', 'º', ":m '>+1<CR>gv=gv", {silent = true})
set('n', '∆', ':m .-2<CR>==', {silent = true})
set('i', '∆', '<Esc>:m .-2<CR>==', {silent = true})
set('v', '∆', ":m '<-2<CR>gv=gv", {silent = true})
set('n', '<leader>+', ':exe "vertical resize " . (winwidth(0) * 3/2)<CR>',
    {silent = true})
set('n', '<leader>-', ':exe "vertical resize " . (winwidth(0) * 2/3)<CR>',
    {silent = true})

set('n', '<c-l>', '<c-w><c-l>', {silent = true})
set('n', '<c-h>', '<c-w><c-h>', {silent = true})
set('n', '<c-j>', '<c-w><c-j>', {silent = true})
set('n', '<c-k>', '<c-w><c-k>', {silent = true})

set({'n', 'v'}, '<Space>', '<Nop>', {silent = true})

set('n', 'k', "v:count == 0 ? 'gk' : 'k'", {expr = true, silent = true})
set('n', 'j', "v:count == 0 ? 'gj' : 'j'", {expr = true, silent = true})

set('n', '[d', vim.diagnostic.goto_prev,
    {desc = 'Go to previous diagnostic message'})
set('n', ']d', vim.diagnostic.goto_next,
    {desc = 'Go to next diagnostic message'})
set('n', '<leader>e', vim.diagnostic.open_float,
    {desc = 'Open floating diagnostic message'})
set('n', '<leader>q', vim.diagnostic.setloclist,
    {desc = 'Open diagnostics list'})

-- set('n', '<c-b>', ':Explore<CR>', {silent = true})
set('n', '<c-b>', ':Oil<CR>', {silent = true})

require 'custom.formatting'
require 'custom.hex_to_rgb'
require 'custom.tmux-navigation'
require 'custom.studienarbeit'

require('lazy').setup({
    'tpope/vim-sleuth', require 'custom.autopairs', require 'custom.autotag',
    require 'custom.comment', require 'custom.copilot', require 'custom.flash',
    require 'custom.gitsigns', require 'custom.lsp', require 'custom.nvim-cmp',
    require 'custom.telescope', require 'custom.treesitter',
    require 'custom.dap', require 'custom.fugitive', require 'custom.gleam',
    require 'custom.oil', require 'custom.mdx',
    require 'custom.highlight-colors', require 'custom.lualine',
    require 'custom.tokyonight', require 'custom.conflict-marker'
    -- require 'custom.theme'
}, {})
