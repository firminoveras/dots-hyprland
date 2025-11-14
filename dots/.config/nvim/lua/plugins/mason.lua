local ok_mason, mason = pcall(require, "mason")
if not ok_mason then return end

local ok_mason_lsp, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok_mason_lsp then
  mason.setup {}
  return
end

local ok_user_hl, user_hl = pcall(require, "core.user.highlights")
if not ok_user_hl then return end
user_hl.setup()

local ok_user_beacon, user_beacon = pcall(require, "core.user.beacon")
if not ok_user_beacon then return end
user_beacon.setup()

local ok_user_diag, user_diag = pcall(require, "core.user.diagnostics")
if not ok_user_diag then return end
user_diag.setup()

vim.diagnostic.config {
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.HINT] = '󰌵',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.ERROR] = '󱎘',
    }
  },
}

mason.setup {
  install_root_dir = vim.fn.stdpath("data") .. "/mason",
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
  pip = {
    upgrade_pip = false
  },
  ui = {
    check_outdated_packages_on_open = true,
    border = "solid",
    icons = {
      package_installed   = "✓",
      package_pending     = "➜",
      package_uninstalled = "✗",
    },
    keymaps = {
      toggle_package_expand = "<CR>",
      install_package = "i",
      update_package = "u",
      check_package_version = "c",
      uninstall_package = "X",
      cancel_installation = "<C-c>",
    },
  },
}

mason_lspconfig.setup {
  automatic_installation = true,
  ensure_installed = {
    "lua_ls",
    "pyright",
    "bashls",
    "jsonls",
    "html",
    "cssls",
  },
}

vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
  settings = {
    Lua = {
      workspace = { library = { vim.env.VIMRUNTIME }, checkThirdParty = false },
      runtime = { version = 'LuaJIT' },
      diagnostics = { enable = true, globals = { "vim", "th", "ui" } },
      telemetry = { enable = false },
    }
  }
})
