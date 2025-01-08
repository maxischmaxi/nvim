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
    codeAction = {
      disableRuleComment = {
        enable = true,
        location = "separateLine"
      },
      showDocumentation = {
        enable = true
      }
    },
    codeActionOnSave = {
      enable = true,
      mode = "all"
    },
    experimental = {
      useFlatConfig = false,
    },
    format = true,
    nodePath = "",
    onIgnoredFiles = "off",
    problems = {
      shortenToSingleLine = false
    },
    quiet = false,
    rulesCustomizations = {},
    run = "onType",
    useESLintClass = false,
    validate = "on",
    workingDirectory = {
      mode = "location"
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
    },
  },

  cssmodules_ls = {
    filetypes = {
      'css',
      'scss',
      'less',
      'sass',
      'html'
    }
  },

  cssls = {
    filetypes = {
      'css',
      'scss',
      'less',
      'sass',
      'html'
    }
  },

  clangd = {
    offsetEncoding = { "utf-8", "utf-16" },
    textDocument = {
      completion = {
        editsNearCursor = true,
      }
    }
  }
}

local function file_exists(filepath)
  local f=io.open(filepath,"r")
   if f~=nil then io.close(f) return true else return false end
end

local function isempty(s)
  return s == nil or s == ''
end

-- local function findEslintConfig()
--   local eslint_files = {
--     ".eslintrc",
--     ".eslintrc.json",
--     ".eslintrc.yaml",
--     ".eslintrc.yml",
--     ".eslintrc.js",
--     "eslint.config.mjs",
--     "eslint.config.js",
--   }
--
--   local dir = vim.fn.getcwd()
--
--   for _, file in ipairs(eslint_files) do
--     local path = dir .. '/' .. file
--     if file_exists(path) then
--       return path
--     end
--   end
--
--   local project_dir = dir .. '/project'
--
--   for _, file in ipairs(eslint_files) do
--     local path = project_dir .. '/' .. file
--     if file_exists(path) then
--       vim.notfy("Found eslint config: " .. path)
--       return path
--     end
--   end
--
--   return nil
-- end

local function findPrettierConfig()
  local prettier_files = {
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.yaml",
    ".prettierrc.yml",
    ".prettierrc.js",
    "prettier.config.mjs",
    "prettier.config.js",
  }

  local dir = vim.fn.getcwd()

  for _, file in ipairs(prettier_files) do
    local path = dir .. '/' .. file
    if file_exists(path) then
      return path
    end
  end

  local project_dir = dir .. '/project'

  for _, file in ipairs(prettier_files) do
    local path = project_dir .. '/' .. file
    if file_exists(path) then
      return path
    end
  end

  return nil
end

local function findStylelintConfig()
  local stylelint_files = {
    ".stylelintrc",
    ".stylelintrc.json",
    ".stylelintrc.yaml",
    ".stylelintrc.yml",
    ".stylelintrc.js",
    "stylelint.config.mjs",
    "stylelint.config.js",
  }

  local dir = vim.fn.getcwd()
  for _, file in ipairs(stylelint_files) do
    local path = dir .. '/' .. file
    if file_exists(path) then
      return path
    end
  end

  local project_dir = dir .. '/project'
  for _, file in ipairs(stylelint_files) do
    local path = project_dir .. '/' .. file
    if file_exists(path) then
      return path
    end
  end

  return nil
end

local function findCompileCommands()
  local dir = vim.fn.getcwd()

  local path = dir .. '/compile_commands.json'
  if file_exists(path) then
    return path
  end

  return nil
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
    local autocmd = "BufWritePost"

    vim.api.nvim_create_autocmd('TextYankPost', {
      callback = function()
        vim.highlight.on_yank()
      end,
      group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
      pattern = '*',
    })

    vim.api.nvim_create_autocmd(autocmd, {
      group = vim.api.nvim_create_augroup("FormatCssOnSave", { clear = true }),
      pattern = "*.{css,scss,less,sass}",
      callback = function()
        local stylelint_file = findStylelintConfig()
        if stylelint_file then
          local view = vim.fn.winsaveview()
          vim.cmd("silent! !stylelint --config " .. stylelint_file .. " --fix %")
          vim.cmd("edit!")
          vim.fn.winrestview(view)
        end
      end
    })

    vim.api.nvim_create_autocmd(autocmd, {
      group = vim.api.nvim_create_augroup("FormatCOnSave", { clear = true }),
      pattern = "*.{c,h,cpp,hpp}",
      callback = function()
        local compile_commands = findCompileCommands()
        if compile_commands then
          local view = vim.fn.winsaveview()
          vim.cmd("silent! !clang-format -assume-filename=compile_commands.json -style=file -i %")
          vim.cmd("edit!")
          vim.fn.winrestview(view)
        end
      end
    })

    vim.api.nvim_create_autocmd(autocmd, {
      group = vim.api.nvim_create_augroup("FormatRustOnSave", { clear = true }),
      pattern = "*.rs",
      callback = function()
        local view = vim.fn.winsaveview()
        vim.cmd("!cargo fmt")
        vim.cmd("edit!")
        vim.fn.winrestview(view)
      end
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
      registries = {
        "github:mason-org/mason-registry",
      },
      providers = {
        "mason.providers.registry-api",
        "mason.providers.client"
      },
      github = {
        download_url_template = "https://github.com/%s/releases/download/%s/%s",
      },
      pip = {
        upgrade_pip = false,
        install_args = {}
      },
      diagnostic = {
        refreshSupport = true,
      }
    })

    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
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
            on_attach = function(_, bufnr)
              local nmap = function(keys, func, desc)
                if desc then
                  desc = 'LSP: ' .. desc
                end

                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
              end

              vim.api.nvim_create_autocmd(autocmd, {
                group = vim.api.nvim_create_augroup("FormatPrettierOnSave", { clear = true }),
                buffer = bufnr,
                callback = function()
                  local prettier_config = findPrettierConfig()

                  if isempty(prettier_config) then
                    vim.cmd("silent! !prettier % --print-width 80 --tab-width 4 --write")
                    vim.cmd("edit!")
                  else
                    vim.cmd("silent! !prettier % --config " .. prettier_config .. " --write")
                    vim.cmd("edit!")
                  end
                end,
              })

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
            end,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          }
        end,
      }
    }
  end,
}
