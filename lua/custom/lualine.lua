return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = false,
        -- theme = 'tokyonight',
        theme = 'sonokai',
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
              'nvim_diagnostic',
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
