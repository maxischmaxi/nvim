return {
  "stevearc/oil.nvim",
  config = function()
    local nvim_tmux_nav = require 'nvim-tmux-navigation'

    require("oil").setup({
      view_options = {
        show_hidden = true,
      },

      keymaps = {
        ["<C-l>"] = nvim_tmux_nav.NvimTmuxNavigateRight,
        ["<C-h>"] = nvim_tmux_nav.NvimTmuxNavigateLeft,
        ["<C-j>"] = nvim_tmux_nav.NvimTmuxNavigateDown,
        ["<C-k>"] = nvim_tmux_nav.NvimTmuxNavigateUp,
        ["<C-\\>"] = nvim_tmux_nav.NvimTmuxNavigateLastActive,
        ["<C-space>"] = nvim_tmux_nav.NvimTmuxNavigateNext,
      }
    })

    vim.keymap.set("n", "<c-b>", "<cmd>Oil<cr>")
  end,
}
