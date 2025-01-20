return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects', 'windwp/nvim-ts-autotag'
    },
    lazy = false,
    config = function()
        vim.defer_fn(function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx',
                    'javascript', 'typescript', 'vimdoc', 'vim', 'bash', 'css'
                },
                sync_install = false,
                ignore_install = {},
                auto_install = true,
                highlight = {enable = true},
                indent = {enable = true},
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<c-space>',
                        node_incremental = '<c-space>',
                        scope_incremental = '<c-s>',
                        node_decremental = '<M-space>'
                    }
                }
            })
        end, 0)
    end,
    build = ':TSUpdate'
}
