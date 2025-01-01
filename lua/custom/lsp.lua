local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
local format_group = vim.api.nvim_create_augroup('FormatOnSave', { clear = true })

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
    autoFixOnSave = false,
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
  },

  stylelint_lsp = {
    filetypes = {
      'css',
      'scss',
      'less',
      'sass',
      'html',
      'vue',
      'javascript',
      'typescript',
      'javascriptreact',
      'typescriptreact',
    },
  },
}

local on_attach = function(client, bufnr)
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

  if client == "eslint" then
    vim.api.nvim_create_autocmd("BufWritePost", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end

  vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
      vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
  })
end

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'folke/lazydev.nvim',
    'elentok/format-on-save.nvim',
  },
  config = function()
    require('lazydev').setup()
    local formatters = require("format-on-save.formatters")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    local defaultFormatters = {
      formatters.lsp,
      formatters.if_file_exists({
        pattern = { "prettier.config.mjs", ".prettier.config.mjs", "prettier.config.js", ".prettier.config.js", ".prettierrc", ".prettierrc.js", ".prettierrc.json" },
        formatter = formatters.prettierd,
      }),
      formatters.if_file_exists({
        pattern = { "eslint.config.mjs", ".eslint.config.mjs", "eslint.config.js", ".eslint.config.js", ".eslint.config.js", ".eslintrc", ".eslintrc.js", ".eslintrc.json" },
        formatter = formatters.eslint_d_fix,
      }),
      formatters.if_file_exists({
        pattern = { "tsconfig.json" },
        formatter = formatters.prettierd,
      })
    }
    require('mason').setup({
      ui = {
        icons = {
          package_installed = " ",
          package_pending = " ",
          package_uninstalled = " ",
        }
      },
      diagnostic = {
        refreshSupport = true,
      }
    })

    require("format-on-save").setup({
      auto_commands = true,
      user_commands = true,
      exclude_path_patterns = {
        "/node_modules/",
        ".local/share/nvim/lazy",
        ".local/share/nvim/site/pack/packer",
      },
      formatter_by_ft = {
        javascript = defaultFormatters,
        typescript = defaultFormatters,
        typescriptreact = defaultFormatters,
        javascriptreact = defaultFormatters,
        css = { formatters.lsp },
        html = { formatters.lsp },
        lua = { formatters.lsp },
        rust = { formatters.lsp },
        go = { formatters.lsp },
      },
      experiments = {
        partial_update = 'diff', -- or 'line-by-line'
      },
      fallback_formatter = formatters.lsp,
    })

    require("mason-lspconfig").setup {
      ensure_installed = vim.tbl_keys(servers),
      automatic_installation = true,
      handlers = {
        function(server_name)
          require('lspconfig')[server_name].setup {
            flags = {
              debounce_text_changes = 1000,
              allow_incremental_sync = false,
            },
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          }
        end,
      }
    }
  end,
}
