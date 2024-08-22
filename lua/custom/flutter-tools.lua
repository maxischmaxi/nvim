return {
  'akinsho/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim', -- optional for vim.ui.select
  },
  config = function()
    require('flutter-tools').setup({
      ui = {
        border = 'rounded',
        notification_style = 'plugin',
      },
      lsp = {
        settings = {
          enableSnippets = false,
        }
      }
    })
  end,
}
