local g = vim.g
local autocmd = vim.api.nvim_create_autocmd

local options_append = {
  netrw_keepdir = 1,
  netrw_winsize = 17,
  --netrw_banner = '0',
  netrw_localmkdir = 'mkdir -p',
  netrw_localcopycmd = 'cp -r',
  netrw_localrmdir = 'rm -rf',
  netrw_list_hide = [['\(^\|\s\s\)\zs\.\S\+']],
}

for k, v in pairs(options_append) do
  g[k] = v
end

autocmd('filetype', {
  pattern = 'netrw',
  desc = 'Better mappings for netrw',
  callback = function()
    local nvim_tmux_nav = require 'nvim-tmux-navigation'

    local bind = function(lhs, rhs)
      vim.keymap.set('n', lhs, rhs, { remap = true, buffer = true })
    end

    bind('H', 'u')
    bind('h', '-^')
    bind('l', '<CR>')
    bind('.', 'gh')

    bind('<TAB>', 'mf')
    bind('<S-TAB>', 'mF')
    bind('<leader><TAB>', 'mu')

    bind('ff', '%:w<CR>:buffer #<CR>')
    bind('fa', 'd')
    bind('fr', 'R')
    bind('fd', 'D')
    bind('fc', 'mc')
    bind('fC', 'mtmc')
    bind('fx', 'mm')
    bind('fX', 'mtmm')
    bind('fe', 'mx')
    bind('fm', ':echo "Marked files:\n" . join(netrw#Expose("netrwmarkfilelist"), "\n")<CR>')
    bind('ft', ':echo "Target: " . netrw#Expose("netrwmftgt")<CR>')

    bind('q', ':Lexplore<CR>')

    bind('<c-l>', nvim_tmux_nav.NvimTmuxNavigateRight)
    bind('<c-h>', nvim_tmux_nav.NvimTmuxNavigateLeft)
    bind('<c-j>', nvim_tmux_nav.NvimTmuxNavigateDown)
    bind('<c-k>', nvim_tmux_nav.NvimTmuxNavigateUp)
    bind('<c-\\>', nvim_tmux_nav.NvimTmuxNavigateLastActive)
    bind('<c-space>', nvim_tmux_nav.NvimTmuxNavigateNext)
  end,
})
