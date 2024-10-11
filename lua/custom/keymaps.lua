local function lazy(keys)
  keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
  return function()
    local current_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_line_count(0)

    if current_line == lines then
      vim.api.nvim_feedkeys('20k', 'n', false)
      return
    end

    local old = vim.o.lazyredraw
    vim.o.lazyredraw = true
    vim.api.nvim_feedkeys(keys, 'nx', false)
    vim.o.lazyredraw = old
  end
end

vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
-- vim.keymap.set('n', '<C-d>', '<C-d>zz')
-- vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<c-d>', lazy('<c-d>zz'), { desc = 'Scroll down half screen' })
vim.keymap.set('n', '<c-u>', lazy('<c-u>zz'), { desc = 'Scroll down half screen' })
vim.keymap.set('n', 'º', ':m .+1<CR>==', { silent = true })
vim.keymap.set('i', 'º', '<Esc>:m .+1<CR>==', { silent = true })
vim.keymap.set('v', 'º', ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('n', '∆', ':m .-2<CR>==', { silent = true })
vim.keymap.set('i', '∆', '<Esc>:m .-2<CR>==', { silent = true })
vim.keymap.set('v', '∆', ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set('n', '<leader>+', ':exe "vertical resize " . (winwidth(0) * 3/2)<CR>', { silent = true })
vim.keymap.set('n', '<leader>-', ':exe "vertical resize " . (winwidth(0) * 2/3)<CR>', { silent = true })

-- Mark whole buffer
vim.keymap.set('n', '<leader>ma', 'ggVG', { silent = true })

vim.keymap.set('n', '<c-l>', '<c-w><c-l>', { silent = true })
vim.keymap.set('n', '<c-h>', '<c-w><c-h>', { silent = true })
vim.keymap.set('n', '<c-j>', '<c-w><c-j>', { silent = true })
vim.keymap.set('n', '<c-k>', '<c-w><c-k>', { silent = true })

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
