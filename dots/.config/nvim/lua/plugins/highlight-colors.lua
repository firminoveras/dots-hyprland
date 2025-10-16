local ok, hl = pcall(require, "nvim-highlight-colors")
if not ok then return end

hl.setup {
  render = "virtual",
  virtual_symbol = "",
  virtual_symbol_prefix = " ",
  virtual_symbol_position = "eow",
}
