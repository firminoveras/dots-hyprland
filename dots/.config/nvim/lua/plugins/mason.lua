local ok_mason, mason = pcall(require, "mason")
if not ok_mason then return end

local ok_mason_lsp, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok_mason_lsp then mason.setup {} return end

vim.diagnostic.config {
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  virtual_lines = {
    current_line = true,
    format = function(diagnostic)
      local sign = ''
      if diagnostic.severity == vim.diagnostic.severity.INFO then sign = ' ' end
      if diagnostic.severity == vim.diagnostic.severity.HINT then sign = '󰌵 ' end
      if diagnostic.severity == vim.diagnostic.severity.WARN then sign = ' ' end
      if diagnostic.severity == vim.diagnostic.severity.ERROR then sign = ' ' end
      return string.format(sign .. '%s', diagnostic.message)
    end
  },
  signs = {
    text = {
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '󰌵',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.ERROR] = ' ',
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
      runtime = {
        version = 'LuaJIT',
        diagnostics = { globals = { "vim" } },
        workspace = { library = vim.api.nvim_get_runtime_file("", true) },
        telemetry = { enable = false },
      }
    }
  }
})
