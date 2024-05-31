local keyset = vim.keymap.set

keyset('n', '<C-b>', ':Explore<CR>', { silent = true })
keyset('n', 'n', 'nzzzv')
keyset('n', 'N', 'Nzzzv')
keyset('n', '<C-d>', '<C-d>zz')
keyset('n', '<C-u>', '<C-u>zz')
keyset('n', 'º', ':m .+1<CR>==', { silent = true })
keyset('i', 'º', '<Esc>:m .+1<CR>==', { silent = true })
keyset('v', 'º', ":m '>+1<CR>gv=gv", { silent = true })
keyset('n', '∆', ':m .-2<CR>==', { silent = true })
keyset('i', '∆', '<Esc>:m .-2<CR>==', { silent = true })
keyset('v', '∆', ":m '<-2<CR>gv=gv", { silent = true })
keyset('n', '<leader>+', ':exe "vertical resize " . (winwidth(0) * 3/2)<CR>', { silent = true })
keyset('n', '<leader>-', ':exe "vertical resize " . (winwidth(0) * 2/3)<CR>', { silent = true })

-- Mark whole buffer
keyset('n', '<leader>ma', 'ggVG', { silent = true })

keyset('n', '<c-l>', '<c-w><c-l>', { silent = true })
keyset('n', '<c-h>', '<c-w><c-h>', { silent = true })
keyset('n', '<c-j>', '<c-w><c-j>', { silent = true })
keyset('n', '<c-k>', '<c-w><c-k>', { silent = true })

keyset({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
keyset('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keyset('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
keyset('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
keyset('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
keyset('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
keyset('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
