local set = vim.keymap.set

set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")
set("n", "<c-d>", "<c-d>zz", { desc = "Scroll down half screen" })
set("n", "<c-u>", "<c-u>zz", { desc = "Scroll down half screen" })
set("n", "º", ":m .+1<CR>==", { silent = true })
set("i", "º", "<Esc>:m .+1<CR>==", { silent = true })
set("v", "º", ":m '>+1<CR>gv=gv", { silent = true })
set("n", "∆", ":m .-2<CR>==", { silent = true })
set("i", "∆", "<Esc>:m .-2<CR>==", { silent = true })
set("v", "∆", ":m '<-2<CR>gv=gv", { silent = true })
set("n", "<leader>+", ':exe "vertical resize " . (winwidth(0) * 3/2)<CR>', { silent = true })
set("n", "<leader>-", ':exe "vertical resize " . (winwidth(0) * 2/3)<CR>', { silent = true })

set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
set("n", "K", function()
	vim.lsp.buf.hover({ border = "rounded", padding = { 1, 1 } })
end, { desc = "Hover Documentation" })
-- set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Documentation" })

set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
set("n", "<C-i>", ":noh<CR>", { silent = true, desc = "hide search highlights" })

local function tmux_yabai_or_split_switch(wincmd, direction)
	local previous_winnr = vim.api.nvim_get_current_win()
	vim.cmd("silent! wincmd " .. wincmd)
	local current_winnr = vim.api.nvim_get_current_win()
	if previous_winnr == current_winnr then
		os.execute("tmux-yabai.sh " .. direction)
	end
end

set("n", "<C-h>", function()
	tmux_yabai_or_split_switch("h", "west")
end, { silent = true })
set("n", "<C-j>", function()
	tmux_yabai_or_split_switch("j", "south")
end, { silent = true })
set("n", "<C-k>", function()
	tmux_yabai_or_split_switch("k", "north")
end, { silent = true })
set("n", "<C-l>", function()
	tmux_yabai_or_split_switch("l", "east")
end, { silent = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "oil",
	callback = function()
		vim.keymap.set("n", "<C-h>", function()
			tmux_yabai_or_split_switch("h", "west")
		end, { buffer = true, desc = "Open parent directory" })
		vim.keymap.set("n", "<C-j>", function()
			tmux_yabai_or_split_switch("j", "south")
		end, { buffer = true, desc = "Open file" })
		vim.keymap.set("n", "<C-k>", function()
			tmux_yabai_or_split_switch("k", "north")
		end, { buffer = true, desc = "Open file" })
		vim.keymap.set("n", "<C-l>", function()
			tmux_yabai_or_split_switch("l", "east")
		end, { buffer = true, desc = "Open file" })
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
	pattern = "*",
})
