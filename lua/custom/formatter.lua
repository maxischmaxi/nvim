return {
	"mhartington/formatter.nvim",
	config = function()
		require("formatter").setup({
			filetype = {
				lua = {
					require("formatter.filetypes.lua").stylua,
				},
				typescript = {
					require("formatter.filetypes.typescript").prettierd,
					require("formatter.filetypes.typescript").eslint_d,
				},
				javascript = {
					require("formatter.filetypes.javascript").prettierd,
					require("formatter.filetypes.javascript").eslint_d,
				},
				["*"] = {
					require("formatter.filetypes.any").remove_trailing_whitespace,
					function()
						return {
							exe = "prettierd",
							args = { vim.api.nvim_buf_get_name(0) },
							stdin = true,
						}
					end,
				},
			},
		})
		local augroup = vim.api.nvim_create_augroup
		local autocmd = vim.api.nvim_create_autocmd

		augroup("__formatter__", { clear = true })
		autocmd("BufWritePost", {
			group = "__formatter__",
			command = ":FormatWrite",
		})
	end,
}
