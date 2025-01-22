local autocmd = "BufWritePost"

local function file_exists(filepath)
    local f = io.open(filepath, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

local function isempty(s) return s == nil or s == '' end

local function findPrettierConfig()
    local prettier_files = {
        ".prettierrc", ".prettierrc.json", ".prettierrc.yaml",
        ".prettierrc.yml", ".prettierrc.js", "prettier.config.mjs",
        "prettier.config.js"
    }

    local dir = vim.fn.getcwd()

    for _, file in ipairs(prettier_files) do
        local path = dir .. '/' .. file
        if file_exists(path) then return path end
    end

    local project_dir = dir .. '/project'

    for _, file in ipairs(prettier_files) do
        local path = project_dir .. '/' .. file
        if file_exists(path) then return path end
    end

    return nil
end

local function findStylelintConfig()
    local stylelint_files = {
        ".stylelintrc", ".stylelintrc.json", ".stylelintrc.yaml",
        ".stylelintrc.yml", ".stylelintrc.js", "stylelint.config.mjs",
        "stylelint.config.js"
    }

    local dir = vim.fn.getcwd()
    for _, file in ipairs(stylelint_files) do
        local path = dir .. '/' .. file
        if file_exists(path) then return path end
    end

    local project_dir = dir .. '/project'
    for _, file in ipairs(stylelint_files) do
        local path = project_dir .. '/' .. file
        if file_exists(path) then return path end
    end

    return nil
end

local function findCompileCommands()
    local dir = vim.fn.getcwd()

    local path = dir .. '/compile_commands.json'
    if file_exists(path) then return path end

    return nil
end

vim.api.nvim_create_autocmd(autocmd, {
    group = vim.api.nvim_create_augroup("FormatCssOnSave", {clear = true}),
    pattern = "*.{css,scss,less,sass}",
    callback = function()
        local stylelint_file = findStylelintConfig()

        if stylelint_file then
            vim.cmd("silent! !stylelint --config " .. stylelint_file ..
                        " --fix %")
            vim.cmd("edit!")
        end
    end
})

vim.api.nvim_create_autocmd(autocmd, {
    group = vim.api.nvim_create_augroup("FormatCOnSave", {clear = true}),
    pattern = "*.{c,h,cpp,hpp}",
    callback = function()
        local compile_commands = findCompileCommands()
        if compile_commands then
            vim.cmd(
                "silent! !clang-format -assume-filename=compile_commands.json -style=file -i %")
            vim.cmd("edit!")
        end
    end
})

vim.api.nvim_create_autocmd(autocmd, {
    group = vim.api.nvim_create_augroup("FormatLuaOnSave", {clear = true}),
    pattern = "*.lua",
    callback = function()
        vim.cmd("silent! !lua-format -i % --tab-width 4 --column-limit 80")
        vim.cmd("edit!")
    end
})

vim.api.nvim_create_autocmd(autocmd, {
    group = vim.api.nvim_create_augroup("FormatRustOnSave", {clear = true}),
    pattern = "*.rs",
    callback = function()
        vim.cmd("silent! !cargo fmt")
        vim.cmd("edit!")
    end
})

vim.api.nvim_create_autocmd(autocmd, {
    group = vim.api.nvim_create_augroup("FormatPrettierOnSave", {clear = true}),
    pattern = "*.{js,jsx,ts,tsx,css,scss,less,sass,html,json,yaml,yml,md,markdown,mdx}",
    callback = function()
        local prettier_config = findPrettierConfig()
        if isempty(prettier_config) then
            -- vim.notify("No prettier config found", vim.log.levels.INFO)
            vim.cmd("silent! !prettier % --print-width 80 --tab-width 4 --write")
            vim.cmd("edit!")
        else
            -- vim.notify("prettier config: " .. prettier_config .. " haha",
            --            vim.log.levels.INFO)
            vim.cmd("silent! !prettier % --config " .. prettier_config ..
                        " --write")
            vim.cmd("edit!")
        end
    end
})
