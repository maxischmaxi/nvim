return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("cyberdream").setup({
      transparent = false,
      italic_comments = true,
      borderless_telescope = false,
      terminal_colors = true,
    })

    vim.cmd [[colorscheme cyberdream]]
  end,
}

-- return {
--   "folke/tokyonight.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require('tokyonight').setup({
--       style = "night",
--       transparent = true,
--       styles = {
--         sizdebars = "transparent",
--         float = "transparent",
--       },
--       on_highlights = function(hl, colors)
--         hl.CursorLineNr = {
--           fg = colors.yellow,
--           bg = colors.bg_highlight
--         }
--         hl.CursorLine = {
--           bg = colors.bg_highlight
--         }
--       end,
--     })
--
--     vim.cmd [[
--     " colorscheme tokyonight
--     highlight Visual guibg=#33467C
--     ]]
--   end,
-- }
