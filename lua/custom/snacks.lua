return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = {enabled = true},
        dashboard = {enabled = false},
        explorer = {enabled = false},
        ---@class snacks.indent.Config
        ---@field enabled? boolean
        indent = {animate = {enabled = false}},
        input = {enabled = false},
        picker = {enabled = false},
        notifier = {enabled = false},
        quickfile = {enabled = false},
        scope = {enabled = false},
        scroll = {enabled = false},
        statuscolumn = {enabled = false},
        words = {enabled = false}
    },
    keys = {
        -- {"<leader>sf", function() Snacks.picker.files() end, desc = "Files"}
    }
}
