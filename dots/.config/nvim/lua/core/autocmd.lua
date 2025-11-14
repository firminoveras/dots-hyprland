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

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function()
    vim.lsp.document_color.enable(false)
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("AutoOpenLast", { clear = true }),
  nested = true,
  callback = function()
    if vim.fn.argc() > 0 then return end
    local last_file = vim.v.oldfiles[1]
    if last_file and vim.fn.filereadable(last_file) == 1 then
      vim.cmd("edit " .. vim.fn.fnameescape(last_file))
      local mark = vim.api.nvim_buf_get_mark(0, '"')
      local lcount = vim.api.nvim_buf_line_count(0)
      if mark[1] > 0 and mark[1] <= lcount then
        pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
    else
      vim.cmd("Neotree show")
    end
  end,
})
