local ok, whichkey = pcall(require, "which-key")
if not ok then return end

whichkey.setup {
  filter = function(mapping)
    return mapping.desc and mapping.desc ~= ""
  end,
  icons = {
    breadcrumb = "»",
    separator = "➜",
    group = "",
    mappings = false,
  },
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = true,
      suggestions = 20,
    },
  },
  operator_pending_mode = {
    enabled = true,
  },
  win = {
    title = false,
    border = "none",
    padding = { 1, 2, 1, 2 },
  },
  ui = {
    icons = {
      mappings = false,
      rules = false,
    }
  }
}
