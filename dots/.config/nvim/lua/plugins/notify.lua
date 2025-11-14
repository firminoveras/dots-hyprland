local ok, notify = pcall(require, "notify")
if not ok then return end

vim.notify = notify
print = function(...)
  local items = {}
  for i = 1, select('#', ...) do
    items[i] = tostring(select(i, ...))
  end
  notify(table.concat(items, ' '), vim.log.levels.INFO, { title = "Print Output" })
end

notify.setup {
  merge_duplicates = true,
  stage = "slide",
  timeout = 3000,
  top_down = true,
}
