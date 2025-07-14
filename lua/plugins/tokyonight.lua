return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			on_colors = function(colors) end,
			style = "night",
			cache = true,
			day_brightness = 0.3,
			light_style = "night",
			dim_inactive = true,
			lualine_bold = true,
			plugins = {},
			terminal_colors = false,
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
			on_highlights = function(hl, c)
				hl.Visual = { bg = "#3d59a1", fg = "NONE" }
			end,
		})

		vim.cmd([[ colorscheme tokyonight-night ]])
	end,
}
