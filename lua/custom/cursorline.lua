return {
  'yamatsum/nvim-cursorline',
  config = function()
    require('nvim-cursorline').setup {
      cursorline = {
        enable = false,
        timout = 100,
        number = true,
      },
      cursorword = {
        enable = true,
        min_length = 3,
        hl = { underline = true },
      },
    }
  end,
}
