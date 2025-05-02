local set = vim.keymap.set

vim.g.netrw_keepdir = 1
vim.g.netrw_winsize = 17
vim.g.netrw_banner = "0"
vim.g.netrw_sizestyle = "H"
vim.g.netrw_localmkdir = "mkdir -p"
vim.g.netrw_localcopycmd = "cp -r"
vim.g.netrw_localrmdir = "rm -rf"
vim.g.netrw_list_hide = [['\(^\|\s\s\)\zs\.\S\+']]

set("n", "<c-b>", ":Explore<CR>", { silent = true })

local last_file_path = nil

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		local bufname = vim.api.nvim_buf_get_name(0)
		if bufname ~= "" and vim.fn.isdirectory(bufname) == 0 then
			vim.notify("Netrw buf enter: " .. bufname, vim.log.levels.INFO, { title = "Netrw" })
			last_file_path = bufname
		end
	end,
})

-- Wenn netrw geöffnet wird, dahin navigieren
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		if last_file_path then
			local filename = vim.fn.fnamemodify(last_file_path, ":t")
			vim.defer_fn(function()
				vim.notify("Netrw netrw enter: " .. filename, vim.log.levels.INFO, { title = "Netrw" })
				vim.cmd("normal! gg")
				vim.cmd("normal! /" .. vim.fn.escape(filename, "/") .. "\\<CR>")
			end, 50)
		end
	end,
})
