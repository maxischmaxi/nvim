return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim',
        'folke/lazydev.nvim'
    },
    config = function()
        local servers = {
            ltex = {ltex = {enabled = {"tex"}, language = "de-DE"}},

            tailwindcss = {
                filetypes = {
                    'html', 'typescriptreact', 'javascriptreact', 'css'
                }
            },

            html = {filetypes = {'html', 'twig', 'hbs'}},

            jsonls = {filetypes = {'json', 'jsonc'}},

            ts_ls = {
                filetypes = {
                    'javascript', 'javascriptreact', 'typescript',
                    'typescriptreact'
                },
                init_options = {
                    preferences = {
                        disableSuggestions = true,
                        includeCompletionsForModuleExports = false
                    }
                }
            },

            pyright = {filetypes = {'python'}},

            lua_ls = {
                Lua = {
                    workspace = {checkThirdParty = false},
                    telemetry = {enable = false}
                }
            },

            eslint = {
                codeAction = {
                    disableRuleComment = {
                        enable = true,
                        location = "separateLine"
                    },
                    showDocumentation = {enable = true}
                },
                codeActionOnSave = {enable = true, mode = "all"},
                experimental = {useFlatConfig = true},
                format = false,
                nodePath = "",
                onIgnoredFiles = "off",
                problems = {shortenToSingleLine = false},
                quiet = false,
                rulesCustomizations = {},
                run = "onType",
                useESLintClass = false,
                validate = "on",
                workingDirectory = {mode = "location"}
            },

            rust_analyzer = {diagnostics = {refreshSupport = false}},

            gopls = {},

            stylelint_lsp = {
                filetypes = {'css', 'scss', 'less', 'sass', 'html'}
            },

            cssmodules_ls = {
                filetypes = {'css', 'scss', 'less', 'sass', 'html'}
            },

            cssls = {filetypes = {'css', 'scss', 'less', 'sass', 'html'}},

            clangd = {
                offsetEncoding = {"utf-8", "utf-16"},
                textDocument = {completion = {editsNearCursor = true}}
            }
        }

        require('lazydev').setup({
            library = {"nvim-dap-ui"},
            enabled = true,
            integrations = {cmp = true, coq = false},
            runtime = vim.env.VIMRUNTIME,
            debug = false
        })

        vim.api.nvim_create_autocmd('TextYankPost', {
            callback = function() vim.highlight.on_yank() end,
            group = vim.api.nvim_create_augroup('YankHighlight', {clear = true}),
            pattern = '*'
        })

        require('mason').setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            },
            install_root_dir = vim.fn.stdpath("data") .. "/mason",
            PATH = "prepend",
            log_level = vim.log.levels.INFO,
            max_concurrent_installers = 4,
            registries = {"github:mason-org/mason-registry"},
            providers = {
                "mason.providers.registry-api", "mason.providers.client"
            },
            github = {
                download_url_template = "https://github.com/%s/releases/download/%s/%s"
            },
            pip = {upgrade_pip = false, install_args = {}},
            diagnostic = {refreshSupport = true}
        })

        local capabilities = require('cmp_nvim_lsp').default_capabilities(
                                 vim.lsp.protocol.make_client_capabilities())
        require("mason-lspconfig").setup {
            ensure_installed = vim.tbl_keys(servers),
            automatic_installation = true,
            handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup {
                        flags = {
                            debounce_text_changes = 1000,
                            allow_incremental_sync = false
                        },
                        capabilities = capabilities,
                        settings = servers[server_name],
                        filetypes = (servers[server_name] or {}).filetypes
                    }
                end
            }
        }
    end
}
