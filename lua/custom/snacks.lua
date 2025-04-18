return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = {enabled = true},
        dashboard = {enabled = true},
        explorer = {enabled = false},
        ---@class snacks.indent.Config
        ---@field enabled? boolean
        indent = {animate = {enabled = false}},
        input = {enabled = false},
        picker = {enabled = true},
        notifier = {enabled = true},
        quickfile = {enabled = true},
        scope = {enabled = true},
        scroll = {enabled = false},
        statuscolumn = {enabled = false},
        words = {enabled = false}
    }
}
