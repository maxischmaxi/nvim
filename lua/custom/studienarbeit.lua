vim.api.nvim_set_keymap('n', 'π', ':!latexmk -pdf studienarbeit.tex -f<CR>',
                        {noremap = true, silent = true})
