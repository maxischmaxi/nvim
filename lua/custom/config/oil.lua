require('oil').setup {
  default_file_explorer = true,
  columns = {
    'icon',
    'permissions',
    'size',
  },
  delete_to_trash = true,
  keymaps = {
    ['H'] = 'actions.toggle_hidden',
  },
}
