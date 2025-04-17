local function start_lsp(server_name, cmd)
    local root_dir = vim.fn.getcwd()
    local client_id = vim.lsp.start({
        name = server_name,
        cmd = cmd,
        root_dir = root_dir,
        root_uri = vim.uri_from_fname(root_dir),
        on_attach = function(client, bufnr)
            vim.notify(server_name ..
                           " LSP erfolgreich gestartet und an Buffer " .. bufnr ..
                           " angehängt.", vim.log.levels.INFO)
        end,
        capabilities = vim.lsp.protocol.make_client_capabilities()
    })

    if client_id then
        vim.lsp.buf_attach_client(0, client_id)
    else
        vim.notify("Fehler beim Starten des " .. server_name .. " LSP.",
                   vim.log.levels.ERROR)
    end
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = {"typescript", "typescriptreact", "javascript", "javascriptreact"},
    callback = function()
        start_lsp("tsserver", {"typescript-language-server", "--stdio"})
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {"lua"},
    callback = function() start_lsp("lua_ls", {"lua-language-server"}) end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "javascript", "javascriptreact", "typescript", "typescriptreact", "vue",
        "svelte"
    },
    callback = function()
        start_lsp("eslint", {"vscode-eslint-language-server", "--stdio"})
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {"css", "scss", "less", "sass", "html"},
    callback = function()
        start_lsp("vscode-css-language-server",
                  {"vscode-css-language-server", "--stdio"})
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {"json"},
    callback = function()
        start_lsp("jsonls", {"vscode-json-languageserver", "--stdio"})
    end
})

vim.lsp.set_log_level("debug")
