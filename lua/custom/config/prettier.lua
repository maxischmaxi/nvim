local prettier = require 'prettier'

prettier.setup {
  bin = 'prettierd',
  filetypes = {
    'css',
    'graphql',
    'html',
    'javascript',
    'javascriptreact',
    'json',
    'less',
    'markdown',
    'scss',
    'typescript',
    'typescriptreact',
    'yaml',
  },
  cli_options = {
    config_precedence = 'cli-override',
    bracket_spacing = true,
    print_width = 120,
    semi = true,
    single_quote = true,
    tab_width = 2,
    trailing_comma = 'es5',
  },
}
