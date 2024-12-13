return {
  "numToStr/FTerm.nvim",
  config = function()
    require("FTerm").setup({
      dimensions = {
        height = 0.9,
        width = 0.9,
      }
    })

    vim.keymap.set("n", "<c-t>", "<cmd>lua require('FTerm').toggle()<CR>")
    vim.keymap.set("t", "<c-t>", "<C-\\><C-n><cmd>lua require('FTerm').toggle()<CR>")
  end,
}
