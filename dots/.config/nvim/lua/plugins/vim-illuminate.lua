local ok, illuminate = pcall(require, "illuminate")
if not ok then return end

illuminate.configure({
  providers = { "lsp", "treesitter", "regex" },
  delay = 200,
  filetypes_denylist = { "dirbuf", "dirvish", "fugitive" },
  under_cursor = true,
  min_count_to_highlight = 1,
  case_insensitive_regex = false,
  disable_keymaps = false,
})

local color = vim.api.nvim_get_hl(0, { name = "WinSeparator", link = false })
vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = color.fg })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = color.fg })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = color.fg })
