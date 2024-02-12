return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = false,
        theme = 'tokyonight',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_a = {
          'mode',
        },
        lualine_b = {
          'branch',
        },
        lualine_c = {
          {
            'filename',
            file_status = true,
            path = 1,
          },
        },
        lualine_x = {
          {
            'diagnostics',
            sources = {
              'nvim_lsp',
            },
            alawys_visible = false,
          },
        },
        lualine_y = {
          'progress',
        },
        lualine_z = {
          'location',
        },
      },
    }
  end,
}
