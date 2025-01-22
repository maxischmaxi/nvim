return {
    'alexghergh/nvim-tmux-navigation',
    config = function()
        local nvim_tmux_nav = require 'nvim-tmux-navigation'
        local bind = function(lhs, rhs)
            vim.keymap.set('n', lhs, rhs, {remap = true, buffer = true})
        end

        nvim_tmux_nav.setup {disable_when_zoomed = true}

        bind('<C-h>', nvim_tmux_nav.NvimTmuxNavigateLeft)
        bind('<C-j>', nvim_tmux_nav.NvimTmuxNavigateDown)
        bind('<C-k>', nvim_tmux_nav.NvimTmuxNavigateUp)
        bind('<C-l>', nvim_tmux_nav.NvimTmuxNavigateRight)

        -- vim.api.nvim_create_autocmd('filetype', {
        --     pattern = 'netrw',
        --     desc = 'Better mappings for netrw',
        --     callback = function()
        --         bind('.', 'gh')
        --         bind('q', ':Lexplore<CR>')
        --
        --         bind('<c-l>', nvim_tmux_nav.NvimTmuxNavigateRight)
        --         bind('<c-h>', nvim_tmux_nav.NvimTmuxNavigateLeft)
        --         bind('<c-j>', nvim_tmux_nav.NvimTmuxNavigateDown)
        --         bind('<c-k>', nvim_tmux_nav.NvimTmuxNavigateUp)
        --     end
        -- })
    end
}
