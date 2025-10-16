local ok, gitconflict = pcall(require, 'git-conflict')
if not ok then return end

gitconflict.setup {
  default_mappings = false,
}

local function map(mode, lhs, rhs, desc)
  local opts = {}
  opts.noremap = true
  opts.silent = true
  if desc ~= nil then opts.desc = desc end
  vim.keymap.set(mode, lhs, rhs, opts)
end

map('n', '<leader>gm', '<Nop>', ' Merge')
map('n', '<leader>gmo', '<Plug>(git-conflict-ours)', ' Ours')
map('n', '<leader>gmt', '<Plug>(git-conflict-theirs)', ' Theirs')
map('n', '<leader>gmb', '<Plug>(git-conflict-both)', ' Both')
map('n', '<leader>gm0', '<Plug>(git-conflict-none)', '󰢤 None')
map('n', '<leader>gml', '<Plug>(git-conflict-list-qf)', ' List')
map('n', '<leader>gmn', '<Plug>(git-conflict-next-conflict)', ' Next Conflict')
map('n', '<leader>gmN', '<Plug>(git-conflict-prev-conflict)', ' Previous Conflict')
