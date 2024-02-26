return {
  "elentok/format-on-save.nvim",
  config = function()
    local formatters = require("format-on-save.formatters")

    local defaultFormatters = {
      formatters.lsp,
      formatters.if_file_exists({
        pattern = { ".prettierrc", ".prettierrc.json", ".prettierrc.yaml", "prettier.config.*", ".prettierrc.js" },
        formatter = formatters.prettierd,
      }),
      formatters.if_file_exists({
        pattern = { "*.eslintrc.*", ".eslintrc.*" },
        formatter = formatters.eslint_d_fix,
      })
    }

    require("format-on-save").setup({
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
  end,
}
