local popup = require 'plenary.popup'
local borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' }

local win_id
local popup_win_id

function SplitToTable(str, sep)
  sep = sep or '\n'
  local t = {}
  for line in str:gmatch('([^' .. sep .. ']+)') do
    table.insert(t, line)
  end
  return t
end

function GitFetchAll()
  local cmd = 'git fetch --all'
  local status = vim.fn.system(cmd)

  if status == 0 then
    print 'Fetch successful'
  else
    print(status)
  end
end

function HasUntrackedFiles()
  return vim.fn.system('git ls-files --others --exclude-standard --error-unmatch'):gsub('\n', '') == ''
end

function GetUntrackedFiles()
  return vim.fn.system 'git ls-files --others --exclude-standard --error-unmatch'
end

function StripString(str)
  return str:gsub('%s+', '')
end

function HasUnstagedChanges()
  return vim.fn.system('git diff --quiet --ignore-submodules HEAD'):gsub('\n', '') == ''
end

function GetUnstagedChanges()
  return vim.fn.system 'git diff --name-only --ignore-submodules HEAD'
end

function IsString(s)
  return type(s) == 'string'
end

function IsGitRepository()
  return vim.fn.system('git rev-parse --is-inside-work-tree'):gsub('\n', '') == 'true'
end

function GetCurrentBranch()
  return vim.fn.system('git rev-parse --abbrev-ref HEAD'):gsub('\n', '')
end

function ListBranches()
  local branches = vim.fn.systemlist 'git branch --format="%(refname:short)"'
  table.sort(branches)

  local current_branch = GetCurrentBranch()

  for i, branch in ipairs(branches) do
    if branch == current_branch then
      branches[i] = '->   ' .. branch
    else
      branches[i] = '     ' .. branch
    end
  end

  table.insert(branches, 1, 'Rebase `' .. current_branch .. '` onto:')

  return branches
end

function CancelRebase()
  if popup_win_id then
    vim.api.nvim_win_close(popup_win_id, true)
    popup_win_id = nil
    return
  end

  if win_id then
    vim.api.nvim_win_close(win_id, true)
    win_id = nil
  end
end

function OpenRebaseWindow()
  local height = 20
  local width = 40

  if not IsGitRepository() then
    print 'Not a git repository'
    return
  end

  GitFetchAll()

  win_id = popup.create(ListBranches(), {
    title = 'Rebase',
    highlight = 'RebaseWindow',
    line = math.floor(((vim.o.lines - height) / 2) - 1),
    col = math.floor((vim.o.columns - width) / 2),
    minwidth = width,
    minheight = height,
    borderchars = borderchars,
    callback = DoRebase,
  })

  local bufnr = vim.api.nvim_win_get_buf(win_id)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'q', '<cmd>lua CancelRebase()<cr>', { noremap = true, silent = true })
end

function UntrackedFiles()
  local height = 10
  local width = 20

  local files = SplitToTable(GetUntrackedFiles())

  popup_win_id = popup.create(files, {
    title = 'Untracked Files',
    highlight = 'UntrackedFiles',
    line = math.floor(((vim.o.lines - height) / 2) - 1),
    col = math.floor((vim.o.columns - width) / 2),
    minwidth = width,
    minheight = height,
    borderchars = borderchars,
  })

  local bufnr = vim.api.nvim_win_get_buf(popup_win_id)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'q', '<cmd>lua CancelRebase()<cr>', { noremap = true, silent = true })
end

function UnstagedChanges()
  local height = 20
  local width = 40

  local files = SplitToTable(GetUnstagedChanges())

  popup_win_id = popup.create(files, {
    title = 'Unstaged changes',
    highlight = 'UnstagedChanges',
    line = math.floor(((vim.o.lines - height) / 2) - 1),
    col = math.floor((vim.o.columns - width) / 2),
    minwidth = width,
    minheight = height,
    borderchars = borderchars,
  })

  local bufnr = vim.api.nvim_win_get_buf(popup_win_id)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'q', '<cmd>lua CancelRebase()<cr>', { noremap = true, silent = true })
end

function DoRebase(_, branch)
  print('Rebasing onto', branch)

  if not IsString(branch) then
    print('Invalid branch', branch)
    return
  end

  local b = StripString(branch)

  if b == '' then
    print 'No branch selected'
    return
  end

  local current_branch = GetCurrentBranch()

  if b == current_branch then
    print 'Cannot rebase onto the same branch'
    return
  end

  if not IsGitRepository() then
    print 'Not a git repository'
    return
  end

  local unstaged = HasUnstagedChanges()
  local untracked = HasUntrackedFiles()

  if untracked then
    UntrackedFiles()
    return
  end

  if unstaged then
    UnstagedChanges()
    return
  end

  local cmd = 'git rebase ' .. b
  local status = vim.fn.system(cmd)

  if status == 0 then
    print 'Rebase successful'
  else
    print(status)
  end
end

vim.keymap.set('n', '<leader>rb', OpenRebaseWindow, { noremap = true, silent = true, desc = 'Start Rebase' })
