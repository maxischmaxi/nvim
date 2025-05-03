local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("custom.base_options")
require("custom.base_keymap")
require("custom.hex_to_rgb")
require("custom.tmux-navigation")
require("custom.studienarbeit")
-- require("custom.netrw")
require("custom.yank")

require("lazy").setup({
	require("custom.oil"),
	require("custom.mason"),
	require("custom.sleuth"),
	require("custom.autopairs"),
	require("custom.autotag"),
	require("custom.comment"),
	require("custom.copilot"),
	require("custom.flash"),
	require("custom.nvim-cmp"),
	require("custom.telescope"),
	require("custom.treesitter"),
	require("custom.fugitive"),
	require("custom.mdx"),
	require("custom.highlight-colors"),
	require("custom.lualine"),
	require("custom.tokyonight"),
	require("custom.conflict-marker"),
	require("custom.spectre"),
	require("custom.dressing"),
	require("custom.formatter"),
	require("custom.file-history"),
	require("custom.bloat"),
}, {})
