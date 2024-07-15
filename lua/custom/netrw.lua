local g = vim.g
local autocmd = vim.api.nvim_create_autocmd

local options_append = {
  netrw_keepdir = 1,
  netrw_winsize = 17,
  netrw_banner = '0',
  netrw_sizestyle = 'H',
  netrw_liststyle = 3,
  netrw_localmkdir = 'mkdir -p',
  netrw_localcopycmd = 'cp -r',
  netrw_localrmdir = 'rm -rf',
  netrw_list_hide = [['\(^\|\s\s\)\zs\.\S\+']],
}

for k, v in pairs(options_append) do
  g[k] = v
end

local keyset = vim.keymap.set
keyset('n', '<C-b>', ':Explore<CR>', { silent = true })

autocmd('filetype', {
  pattern = 'netrw',
  desc = 'Better mappings for netrw',
  callback = function()
    local nvim_tmux_nav = require 'nvim-tmux-navigation'

    local bind = function(lhs, rhs)
      vim.keymap.set('n', lhs, rhs, { remap = true, buffer = true })
    end

    bind('.', 'gh')
    bind('q', ':Lexplore<CR>')
    bind('l', nvim_tmux_nav.NvimTmuxNavigateRight)
    bind('h', nvim_tmux_nav.NvimTmuxNavigateLeft)
    bind('j', nvim_tmux_nav.NvimTmuxNavigateDown)
    bind('k', nvim_tmux_nav.NvimTmuxNavigateUp)

    bind('<c-l>', nvim_tmux_nav.NvimTmuxNavigateRight)
    bind('<c-h>', nvim_tmux_nav.NvimTmuxNavigateLeft)
    bind('<c-j>', nvim_tmux_nav.NvimTmuxNavigateDown)
    bind('<c-k>', nvim_tmux_nav.NvimTmuxNavigateUp)
    bind('<c-\\>', nvim_tmux_nav.NvimTmuxNavigateLastActive)
    bind('<c-space>', nvim_tmux_nav.NvimTmuxNavigateNext)
  end,
})
