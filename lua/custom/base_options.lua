vim.g.mapleader = " "
vim.g.loaded_perl_provider = 0
vim.g.maplocalleader = " "

local vimOptions = {
	wrap = true,
	expandtab = true,
	hlsearch = true,
	mouse = "a",
	breakindent = true,
	undofile = true,
	ignorecase = true,
	smartcase = true,
	updatetime = 250,
	timeoutlen = 300,
	completeopt = "menuone,noselect",
	scrolloff = 12,
	fillchars = { fold = " " },
	foldmethod = "indent",
	foldenable = false,
	foldlevel = 99,
	cursorline = false,
	termguicolors = true,
	clipboard = "unnamedplus",
	tabstop = 4,
	shiftwidth = 4,
	softtabstop = 4,
	autoindent = true,
	smartindent = false,
}

local function set_tabs_from_prettier()
	local config_files = {
		".prettierrc",
		".prettierrc.json",
		".prettierrc.js",
		".prettierrc.cjs",
		".prettierrc.yaml",
		".prettierrc.yml",
		".prettierrc.toml",
	}

	local cwd = vim.fn.getcwd()

	for _, file in ipairs(config_files) do
		local path = cwd .. "/" .. file
		if vim.fn.filereadable(path) == 1 then
			for line in io.lines(path) do
				local tabwidth = line:match([["tabWidth"%s*:%s*(%d+)]])
				if tabwidth then
					local width = tonumber(tabwidth)
					vim.opt.tabstop = width
					vim.opt.shiftwidth = width
					vim.opt.softtabstop = width
					break
				end
			end
			break
		end
	end
end

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = set_tabs_from_prettier,
})

local windowOptions = {
	number = true,
	signcolumn = "yes",
	relativenumber = false,
}

for k, v in pairs(vimOptions) do
	vim.opt[k] = v
end

for k, v in pairs(windowOptions) do
	vim.wo[k] = v
end

vim.diagnostic.config({
	underline = true,
	virtual_text = { source = "if_many", spacing = 2 },
	signs = true,
	update_in_insert = false,
	severity_sort = true,
})
