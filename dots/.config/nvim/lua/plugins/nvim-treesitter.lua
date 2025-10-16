local ok, ts = pcall(require, "nvim-treesitter.configs")
if not ok then return end

ts.setup {
  ensure_installed = { 'lua', 'python', 'javascript', 'html', 'css' },
  highlight = { enable = true },
  indent = { enable = true },
}
