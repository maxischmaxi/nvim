-- return {
--   "catppuccin/nvim",
--   name = "catppuccin",
--   priority = 1000,
--   config = function()
--     vim.cmd.colorscheme "catppuccin"
--   end,
-- }

return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require('tokyonight').setup({
      style = "night",
      transparent = true,
      styles = {
        sizdebars = "transparent",
        float = "transparent",
      },
      on_highlights = function(hl, colors)
        hl.CursorLineNr = {
          fg = colors.yellow,
          bg = colors.bg_highlight
        }
        hl.CursorLine = {
          bg = colors.bg_highlight
        }
      end,
    })

    vim.cmd [[
    colorscheme tokyonight
    highlight Visual guibg=#33467C
    ]]
  end,
}


-- return {
--   'sainnhe/sonokai',
--   lazy = false,
--   priority = 1000,
--   config = function()
--     -- Optionally configure and load the colorscheme
--     -- directly inside the plugin declaration.
--     vim.g.sonokai_enable_italic = true
--     vim.cmd.colorscheme('sonokai')
--   end
-- }


-- return {
--   "bluz71/vim-moonfly-colors",
--   name = "moonfly",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.cmd [[colorscheme moonfly]]
--   end,
-- }
