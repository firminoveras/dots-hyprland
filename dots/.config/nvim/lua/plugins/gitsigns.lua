local ok, gitsigns = pcall(require, "gitsigns")
if not ok then return end

gitsigns.setup {
  signs = {
    add = { text = '┃' },
    change = { text = '┃' },
    delete = { text = '󰦺' },
    topdelete = { text = '󰧆' },
    changedelete = { text = '' },
    untracked = { text = '┆' },
  },
  signs_staged = {
    add = { text = '┃' },
    change = { text = '┃' },
    delete = { text = '󰦺' },
    topdelete = { text = '󰧆' },
    changedelete = { text = '' },
    untracked = { text = '┆' },
  },
  signs_staged_enable = true,
  signcolumn = true,
  numhl = false,
  linehl = false,
  word_diff = false,
  watch_gitdir = {
    follow_files = true
  },
  auto_attach = true,
  attach_to_untracked = true,
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol',
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
    use_focus = true,
  },
  current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil,
  max_file_length = 40000,
  preview_config = {
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  on_attach = function(bufnr)
    local function map(mode, lhs, rhs, desc)
      local opts = {}
      opts.noremap = true
      opts.silent = true
      opts.buffer = bufnr
      if desc ~= nil then opts.desc = desc end
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    local gs = package.loaded.gitsigns
    map('n', '<leader>g', '', ' Git')
    map({ 'n', 'v' }, '<leader>gs', gs.stage_hunk, '󰄬 Stage Hunk')
    map({ 'n', 'v' }, '<leader>gr', gs.reset_hunk, '󰮸 Reset Hunk')
    map('n', '<leader>gS', gs.stage_buffer, '󰄬 Stage all Hunks')
    map('n', '<leader>gR', gs.reset_buffer, '󰮸 Reset All Hunks')
    map('n', '<leader>gu', gs.undo_stage_hunk, '󰕮 Undo Stage')
    map('n', '<leader>gp', gs.preview_hunk, '󰊄 Preview Hunk')
    map('n', '<leader>gb', function() gs.blame_line({ full = true }) end, '󰘦 Git Blame')
    map('n', '<leader>gd', gs.diffthis, '󰍷 Diff (Index)')
    map('n', '<leader>gD', function() gs.diffthis('~') end, '󰍷 Diff (Last Commit)')
    map('n', '<leader>gn', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, '󰋗 Git: Próximo Hunk')

    map('n', '<leader>gN', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, '󰋗 Git: Hunk Anterior')
    map('n', '<leader>gt', '', ' Toggles')
    map('n', '<leader>gtD', gs.toggle_deleted, '󰌶 Toggle Deleted')
    map('n', '<leader>gtb', gs.toggle_current_line_blame, '󰘦 Toggle Blame')
    map('n', '<leader>gtd', gs.toggle_word_diff, '󰍷 Toggle Word Diff')
    map('n', '<leader>gts', gs.toggle_signs, ' Toggle Signs')
    map('n', '<leader>gtn', gs.toggle_numhl, ' Toggle Numhl')
    map('n', '<leader>gtl', gs.toggle_linehl, ' Toggle Linehl')
  end
}
