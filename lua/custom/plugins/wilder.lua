return {
  'gelguy/wilder.nvim',
  config = function()
    local wilder = require 'wilder'
    wilder.setup {
      modes = {
        '/',
        '?',
        ':',
      },
    }

    wilder.set_option('pipeline', {
      wilder.branch(
        wilder.cmdline_pipeline {
          language = 'vim',
          fuzzy = true,
        },
        wilder.vim_search_pipeline {
          fuzzy = true,
        }
      ),
    })

    wilder.set_option(
      'renderer',
      wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
        highlighter = wilder.basic_highlighter(),
        pumblend = 5,
        min_width = '100%',
        min_height = '25%',
        max_height = '25%',
        border = 'rounded',
        left = { ' ', wilder.popupmenu_devicons() },
        right = { ' ', wilder.popupmenu_scrollbar() },
      })
    )
  end,
  build = function()
    vim.cmd [[let &rtp=&rtp]]
    vim.api.nvim_command 'runtime! plugin/rplugin.vim'
    vim.api.nvim_command ':UpdateRemotePlugins'
  end,
}
