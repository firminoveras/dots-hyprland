local ok, ts = pcall(require, "nvim-treesitter.configs")
if not ok then return end

ts.setup {
  ensure_installed = { 'lua', 'python', 'javascript', 'html', 'css' },
  highlight = { enable = true },
  indent = { enable = true },
  auto_install = true,
  ignore_install = {},
  modules = {},
  sync_install = true,
  parser_install_dir = nil
}
