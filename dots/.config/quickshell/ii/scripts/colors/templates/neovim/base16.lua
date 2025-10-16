local ok, base16 = pcall(require, 'base16-colorscheme')
if not ok then return end

base16.with_config {
  telescope = true,
  indentblankline = true,
  notify = true,
  ts_rainbow = true,
  cmp = true,
  illuminate = true,
  dapui = true,
}

base16.setup {
  base00 = "#$background #",
  base01 = "#$surfaceContainerLow #",
  base02 = "#$surfaceContainer #",
  base03 = "#$surfaceContainerHighest #",
  base04 = "#$surfaceVariant #",
  base05 = "#$onSurfaceVariant #",
  base06 = "#$outline #",
  base07 = "#$onBackground #",
  base08 = "#$term2 #",
  base09 = "#$term1 #",
  base0A = "#$term3 #",
  base0B = "#$term4 #",
  base0C = "#$term5 #",
  base0D = "#$term6 #",
  base0E = "#$term7 #",
  base0F = "#$term8 #",
}

local function apply_custom_highlights()
  local colors = base16.colors
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = colors.base03 })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = colors.base00 })

  local c = {
    error  = { fg = "#e88585", bg = "#2a1e1e" },
    warn   = { fg = "#e5c07b", bg = "#2a281e" },
    info   = { fg = "#7db8d4", bg = "#1e2a2a" },
    hint   = { fg = "#9aa2aa", bg = "#1e1e1e" },
    gitadd = { fg = "#96DD85", bg = "#1e2a1e" },
    gitdel = { fg = "#E06C75", bg = "#2a1e1e" },
    gitcha = { fg = "#5EA3FF", bg = "#162031" },
    gittxt = { fg = "#C678DD", bg = "#201631" },
  }

  vim.api.nvim_set_hl(0, "DiffAdd", { bg = c.gitadd.bg })
  vim.api.nvim_set_hl(0, "DiffDelete", { bg = c.gitdel.bg })
  vim.api.nvim_set_hl(0, "DiffChange", { bg = c.gitcha.bg })
  vim.api.nvim_set_hl(0, "DiffText", { bg = c.gittxt.bg })

  vim.api.nvim_set_hl(0, "GitSignsAdd", c.gitadd)
  vim.api.nvim_set_hl(0, "GitSignsDelete", c.gitdel)
  vim.api.nvim_set_hl(0, "GitSignsChange", c.gitcha)
  vim.api.nvim_set_hl(0, "GitSignsChangedelete", c.gittxt)

  vim.api.nvim_set_hl(0, "LualineDiffAdd", c.gitadd)
  vim.api.nvim_set_hl(0, "LualineDiffChange", c.gitcha)
  vim.api.nvim_set_hl(0, "LualineDiffDelete", c.gitdel)

  vim.api.nvim_set_hl(0, "NeoTreeGitAdded", c.gitadd)
  vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", c.gitdel)
  vim.api.nvim_set_hl(0, "NeoTreeGitModified", c.gitcha)
  vim.api.nvim_set_hl(0, "NeoTreeGitConflict", c.gittxt)

  vim.api.nvim_set_hl(0, "DiagnosticError", c.error)
  vim.api.nvim_set_hl(0, "DiagnosticWarn", c.warn)
  vim.api.nvim_set_hl(0, "DiagnosticInfo", c.info)
  vim.api.nvim_set_hl(0, "DiagnosticHint", c.hint)

  vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { sp = c.error.fg, undercurl = true })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { sp = c.warn.fg, undercurl = true })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { sp = c.info.fg, undercurl = true })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { sp = c.hint.fg, undercurl = true })

  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", c.error)
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", c.warn)
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", c.info)
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", c.hint)

  vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = c.error.fg, bg = "none" })
  vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = c.warn.fg, bg = "none" })
  vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = c.info.fg, bg = "none" })
  vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = c.hint.fg, bg = "none" })
end

local group = vim.api.nvim_create_augroup("CustomBase16Highlights", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  group = group,
  pattern = "*",
  callback = apply_custom_highlights,
})

apply_custom_highlights()
