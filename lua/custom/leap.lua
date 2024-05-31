return {
  'ggandor/leap.nvim',
  config = function()
    local leap = require('leap');
    leap.create_default_mappings()
    leap.opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }
    leap.opts.special_keys.prev_target = '<backspace>'
    leap.opts.special_keys.prev_group = '<backspace>'
    require("leap.user").set_repeat_keys('<enter>', '<backspace>')
  end,
}
