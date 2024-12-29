local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
end

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'folke/lazydev.nvim',
  },
  config = function()
    require('lazydev').setup()
    require('mason').setup({
      ui = {
        icons = {
          package_installed = " ",
          package_pending = " ",
          package_uninstalled = " ",
        }
      },
      diagnostic = {
        refreshSupport = false,
      }
    })

    local servers = {
      tailwindcss = {
        filetypes = {
          'html',
          'typescriptreact',
          'javascriptreact',
          'css'
        }
      },

      html = {
        filetypes = {
          'html',
          'twig',
          'hbs',
        },
      },

      jsonls = {
        filetypes = {
          'json',
          'jsonc',
        },
      },

      ts_ls = {
        filetypes = {
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
        },
        init_options = {
          preferences = {
            disableSuggestions = true,
            includeCompletionsForModuleExports = false,
          }
        }
      },

      pyright = {
        filetypes = {
          'python',
        },
      },

      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },

      eslint = {
                enable = true,
                format = true,
                autoFixOnSave = true,
                packageManager = 'npm',
                lintTask = {
                  enable = true,
                },
                codeAction = {
                  disableRuleComment = {
                    enable = true,
                    location = "separateLine"
                  },
                  showDocumentation = {
                    enable = true
                  }
                }
              },

      rust_analyzer = {
        diagnostics = {
          refreshSupport = false,
        }
      }
    }


    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
      automatic_installation = true,
      handlers = {
        function(server_name)
          if server_name == 'eslint' then
            require('lspconfig').eslint.setup {
              capabilities = capabilities,
              flags = {
                debounce_text_changes = 1000,
                allow_incremental_sync = false,
              },
              on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                vim.api.nvim_create_autocmd("BufWritePre",{
                  buffer = bufnr,
                  command = "EslintFixAll",
                })
              end,
              cmd = { "vscode-eslint-language-server", "--stdio"},
              settings = servers[server_name],
              filetypes = (servers[server_name] or {}).filetypes,
            }
          else
            require('lspconfig')[server_name].setup {
              capabilities = capabilities,
              on_attach = on_attach,
              settings = servers[server_name],
              filetypes = (servers[server_name] or {}).filetypes,
            }
          end
        end,
      }
    }
  end,
}
