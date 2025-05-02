return {
	"echasnovski/mini.files",
	version = "*",
	config = function()
		require("mini.files").setup({
			mappings = {
				go_in_plus = "<CR>",
			},
		})
		vim.keymap.set("n", "<C-b>", function()
			require("mini.files").open()
		end, { desc = "Open file browser" })
	end,
}
