return {
	"cjodo/convert.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<leader>cv", "<cmd>ConvertAll<CR>", mode = { "n", "v" }, desc = "Convert all of a specified unit" },
	},
}
