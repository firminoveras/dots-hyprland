local api = vim.api

api.nvim_create_autocmd("UIEnter", {
  callback = function()
    -- Hide CmdBar
    vim.opt.cmdheight = 0
  end,
})

api.nvim_create_autocmd("BufReadPost", {
  pattern = { "*" },
  callback = function()
    -- Caret placement
    vim.cmd [[
      if line("'\"") > 0 && line("'\"") <= line("$") |
        exe "normal! g`\"" |
      endif
    ]]
  end,
})

api.nvim_create_autocmd("BufHidden", {
  callback = function(event)
    if event.file == "" and vim.bo[event.buf].buftype == "" and not vim.bo[event.buf].modified then
      vim.schedule(function() pcall(vim.api.nvim_buf_delete, event.buf, {}) end)
    end
  end,
})
