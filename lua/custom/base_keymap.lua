local set = vim.keymap.set

set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")
set("n", "<c-d>", "<c-d>zz", { desc = "Scroll down half screen" })
set("n", "<c-u>", "<c-u>zz", { desc = "Scroll down half screen" })
set("n", "º", ":m .+1<CR>==", { silent = true })
set("i", "º", "<Esc>:m .+1<CR>==", { silent = true })
set("v", "º", ":m '>+1<CR>gv=gv", { silent = true })
set("n", "∆", ":m .-2<CR>==", { silent = true })
set("i", "∆", "<Esc>:m .-2<CR>==", { silent = true })
set("v", "∆", ":m '<-2<CR>gv=gv", { silent = true })
set("n", "<leader>+", ':exe "vertical resize " . (winwidth(0) * 3/2)<CR>', { silent = true })
set("n", "<leader>-", ':exe "vertical resize " . (winwidth(0) * 2/3)<CR>', { silent = true })

set("n", "<c-l>", "<c-w><c-l>", { silent = true })
set("n", "<c-h>", "<c-w><c-h>", { silent = true })
set("n", "<c-j>", "<c-w><c-j>", { silent = true })
set("n", "<c-k>", "<c-w><c-k>", { silent = true })

set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
set("n", "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })
set("n", "K", function()
	vim.lsp.buf.hover({ border = "rounded", padding = { 1, 1 } })
end, { desc = "Hover Documentation" })
set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Documentation" })

set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
