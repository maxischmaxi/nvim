return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	build = "cargo build --release",
	opts = {
		fuzzy = { implementation = "lua" },
		sources = {
			default = { "lsp", "buffer", "path" },
			per_filetype = {
				codecompanion = { "codecompanion" },
			},
		},
		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,
			},
		},
		keymap = {
			preset = "default",
			["<Tab>"] = { "select_and_accept", "fallback" },
			["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
			["<C-u>"] = { "select_prev", "fallback_to_mappings" },
			["<C-d>"] = { "select_next", "fallback_to_mappings" },
			["<CR>"] = { "accept", "fallback" },
		},
	},
}
