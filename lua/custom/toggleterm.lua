return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    local toggleterm = require('toggleterm')

    toggleterm.setup({
      open_mapping = [[<C-t>]],
      direction = 'vertical',
      size = function(term)
        if term.direction == 'horizontal' then
          return 20
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.3
        end
      end,
    })
  end,
}
