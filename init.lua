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
require("custom.studienarbeit")

require("lazy").setup({
	require("plugins.lazydev"),
	require("plugins.oil"),
	require("plugins.mason"),
	require("plugins.mason-lspconfig"),
	require("plugins.nvim-lspconfig"),
	require("plugins.nvim-cmp"),
	require("plugins.sleuth"),
	require("plugins.autopairs"),
	require("plugins.autotag"),
	require("plugins.comment"),
	require("plugins.flash"),
	require("plugins.telescope"),
	require("plugins.luasnip"),
	require("plugins.treesitter"),
	require("plugins.fugitive"),
	require("plugins.mdx"),
	require("plugins.highlight-colors"),
	require("plugins.lualine"),
	require("plugins.tokyonight"),
	require("plugins.conflict-marker"),
	require("plugins.spectre"),
	require("plugins.formatter"),
	require("plugins.codecompanion"),
	require("plugins.hardtime"),
	require("plugins.copilot"),
})
