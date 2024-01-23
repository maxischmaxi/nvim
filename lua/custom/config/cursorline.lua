require('nvim-cursorline').setup {
  cursorline = {
    enable = false,
    timout = 1000,
    number = false,
  },
  cursorword = {
    enable = true,
    min_length = 3,
    hl = { underline = true },
  },
}
