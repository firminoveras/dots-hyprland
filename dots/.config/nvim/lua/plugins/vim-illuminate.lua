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

local ok_colors, base16 = pcall(require, "base16-colorscheme")
if ok_colors and base16 and base16.colors then
  vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = base16.colors.base04 })
  vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = base16.colors.base04 })
  vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = base16.colors.base04 })
end
