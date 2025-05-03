return {
	"mhartington/formatter.nvim",
	config = function()
		require("formatter").setup({
			logging = true,
			log_level = vim.log.levels.ERROR,
			filetype = {
				lua = {
					require("formatter.filetypes.lua").stylua,
				},
				rust = {
					require("formatter.filetypes.rust").rustfmt,
				},
				xhtml = {
					require("formatter.filetypes.xhtml").tidy,
				},
				html = {
					require("formatter.filetypes.html").htmlbeautifier,
				},
				javascript = {
					require("formatter.filetypes.javascript").prettierd,
				},
				typescript = {
					require("formatter.filetypes.typescript").prettierd,
				},
				javascriptreact = {
					require("formatter.filetypes.javascriptreact").prettierd,
				},
				typescriptreact = {
					require("formatter.filetypes.typescriptreact").prettierd,
				},
				json = {
					require("formatter.filetypes.json").jq,
					require("formatter.filetypes.json").prettierd,
				},
			},
		})
		local augroup = vim.api.nvim_create_augroup
		local autocmd = vim.api.nvim_create_autocmd

		augroup("__formatter__", { clear = true })
		autocmd("BufWritePost", {
			group = "__formatter__",
			callback = function()
				if not vim.fn.expand("%"):match("^oil://") and not vim.fn.expand("%"):match("^fugitive://") then
					vim.cmd("FormatWrite")
				end
			end,
		})
	end,
}
