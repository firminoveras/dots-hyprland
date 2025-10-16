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

    -- Close No Name buffer in startup
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if api.nvim_buf_is_loaded(bufnr) and
          api.nvim_buf_get_name(bufnr) == '' and
          vim.bo[bufnr].filetype == '' then
        local total_characters = 0
        for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
          total_characters = total_characters + #line
        end
        if total_characters == 0 then
          api.nvim_buf_delete(bufnr, { force = true })
        end
      end
    end
  end,
})
