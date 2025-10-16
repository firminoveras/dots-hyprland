local ok, ibl = pcall(require, 'ibl')
if not ok then return end

ibl.setup {
  indent = {
    char = " "
  },
  scope = {
    char = '┊',
    highlight = "WinSeparator",
    show_start = false,
    include = { node_type = { ["*"] = { "*" } }, },
  }
}
