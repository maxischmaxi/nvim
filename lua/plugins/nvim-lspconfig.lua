return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			cssls = { filetypes = { "css", "scss", "less", "sass", "html" } },
			cssmodules_ls = {
				filetypes = { "css", "scss", "less", "sass", "html" },
			},
			eslint = {
				codeAction = {
					disableRuleComment = {
						enable = true,
						location = "separateLine",
					},
					showDocumentation = { enable = true },
				},
				codeActionOnSave = { enable = true, mode = "all" },
				experimental = { useFlatConfig = true },
				format = false,
				nodePath = "",
				onIgnoredFiles = "off",
				problems = { shortenToSingleLine = false },
				quiet = false,
				rulesCustomizations = {},
				run = "onType",
				useESLintClass = false,
				validate = "on",
				workingDirectory = { mode = "location" },
			},
			gopls = {},
			html = { filetypes = { "html", "twig", "hbs" } },
			jsonls = { filetypes = { "json", "jsonc" } },
			ltex = { ltex = { enabled = { "tex" }, language = "de-DE" } },
			lua_ls = {
				cmd = { "lua-language-server" },
				filetypes = { "lua" },
				root_markers = {
					".luarc.json",
					".luarc.jsonc",
					".luacheckrc",
					".stylua.toml",
					"stylua.toml",
					"selene.toml",
					"selene.yml",
					".git",
				},
				settings = {
					Lua = {
						telemetry = { enable = false },
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
					},
				},
			},
			protols = { filetypes = "proto" },
			pyright = {
				cmd = { "pyright-langserver", "--stdio" },
				settings = { python = { analysis = { autoSearchPaths = true, useLibraryCodeForTypes = true } } },
				filetypes = { "python" },
			},
			rust_analyzer = { diagnostics = { refreshSupport = false } },
			stylelint_lsp = {
				filetypes = { "css", "scss", "less", "sass", "html" },
			},
			tailwindcss = {
				filetypes = {
					"html",
					"typescriptreact",
					"javascriptreact",
					"css",
				},
			},
			ts_ls = {
				filetypes = {
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
				},
				settings = {
					typescript = {
						preferences = {
							disableSuggestions = true,
							includeCompletionsForModuleExports = true,
							includeCompletionsWithInsertText = true,
						},
					},
					javascript = {
						preferences = {
							includeCompletionsForModuleExports = true,
							includeCompletionsWithInsertText = true,
						},
					},
				},
			},
		},
	},
	config = function(_, opts)
		local lspconfig = require("lspconfig")
		for server, config in pairs(opts.servers) do
			lspconfig[server].setup(config)
		end
	end,
}
