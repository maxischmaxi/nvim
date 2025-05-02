return {
	"dawsers/telescope-file-history.nvim",
	config = function()
		require("file_history").setup({
			backup_dir = "~/.file-history-git",
			git_cmd = "git",
			hostname = nil,
		})
		require("telescope").load_extension("file_history")
	end,
}
