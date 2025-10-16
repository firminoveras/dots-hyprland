local ok_cmp, cmp = pcall(require, "cmp")
if not ok_cmp then return end

local ok_snip, luasnip = pcall(require, "luasnip")
if not ok_snip then return end

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup {
  completion = {
    autocomplete = { cmp.TriggerEvent.TextChanged },
    completeopt = "menu,menuone,noinsert",
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  view = {
    docs = {
      auto_open = true
    }
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-e>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-q>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true, }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
      local strings = vim.split(kind.kind, "%s", { trimempty = true })
      kind.kind = " " .. (strings[1] or "") .. " "
      local kind_text = strings[2]  or ""
      local source_name = entry.source.name
      local source_mapping = {
        nvim_lsp = '[LSP]',
        luasnip = '[SNP]',
        buffer = '[BUF]',
        path = '[PAT]',
        nvim_lua = '[LUA]',
      }
      local source_text = source_mapping[source_name] or ''
      kind.menu = "  " .. source_text .. " " .. kind_text

      return kind
    end,
  },
  window = {
    completion = {
      col_offset = 0,
      side_padding = 0,
    },
    documentation = {
      col_offset = 0,
      side_padding = 0,
    },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  experimental = {
    ghost_text = true,
    native_menu = false,
  },
}

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
  window = {
    completion = {
      col_offset = -3,
      side_padding = 0,
    },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  matching = {
    disallow_prefix_unmatching = false,
    disallow_partial_matching = false,
    disallow_fuzzy_matching = false,
    disallow_partial_fuzzy_matching= false,
    disallow_fullfuzzy_matching = false,
    disallow_symbol_nonprefix_matching = false
  },
})

local ok_lsp, lspconfig = pcall(require, "lspconfig")
local ok_cmp_lsp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok_lsp and ok_cmp_lsp then
  local capabilities = cmp_lsp.default_capabilities()
  for _, server in ipairs(vim.tbl_keys(lspconfig)) do
    lspconfig[server].setup({
      capabilities = capabilities,
    })
  end
end
