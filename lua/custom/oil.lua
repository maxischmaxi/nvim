return {
  "stevearc/oil.nvim",
  config = function()
    local nvim_tmux_nav = require 'nvim-tmux-navigation'

    require("oil").setup({
      view_options = {
        show_hidden = true,
      },

      watch_for_changes = true,

      default_file_explorer = true,

      columns = {
        "icon",
        "size"
      },

      keymaps = {
        ["<C-l>"] = nvim_tmux_nav.NvimTmuxNavigateRight,
        ["<C-h>"] = nvim_tmux_nav.NvimTmuxNavigateLeft,
        ["<C-j>"] = nvim_tmux_nav.NvimTmuxNavigateDown,
        ["<C-k>"] = nvim_tmux_nav.NvimTmuxNavigateUp,
        ["<C-\\>"] = nvim_tmux_nav.NvimTmuxNavigateLastActive,
      }
    })

    vim.keymap.set("n", "<c-b>", "<cmd>Oil<cr>")
  end,
}
