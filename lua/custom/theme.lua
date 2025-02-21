return {
    "catppuccin/nvim",
    name = "catppuccin",
    dependencies = {"echasnovski/mini.statusline"},
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                notify = false,
                mini = {enabled = true, indentscope_color = ""}
            }
        })
        require("mini.statusline").setup()
        vim.cmd.colorscheme "catppuccin"
    end
}
