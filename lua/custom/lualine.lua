return {
    'nvim-lualine/lualine.nvim',
    config = function()
        require('lualine').setup {
            options = {
                icons_enabled = true,
                -- theme = 'tokyonight',
                -- theme = 'sonokai',
                -- theme = "moonfly",
                -- theme = "horizon",
                component_separators = {left = '', right = ''},
                section_separators = {left = '', right = ''}
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch'},
                lualine_c = {{'filename', file_status = true, path = 1}},
                lualine_x = {
                    {
                        'diagnostics',
                        sources = {'nvim_lsp', 'nvim_diagnostic'},
                        alawys_visible = false
                    }
                },
                lualine_y = {'progress'},
                lualine_z = {'location'}
            }
        }
    end
}
