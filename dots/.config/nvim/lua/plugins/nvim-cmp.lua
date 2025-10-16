local ok_cmp, cmp = pcall(require, "cmp")
if not ok_cmp then return end

local ok_snip, luasnip = pcall(require, "luasnip")
if not ok_snip then return end

require("luasnip.loaders.from_vscode").lazy_load()

local ok_colors, base16 = pcall(require, "base16-colorscheme")
if not ok_colors then return end
local hl = base16.colors

vim.api.nvim_set_hl(0, "CmpNormal", { bg = hl.base02, fg = hl.base05 })
vim.api.nvim_set_hl(0, "CmpBorder", { bg = hl.base02, fg = hl.base05 })
vim.api.nvim_set_hl(0, "CmpSel", { bg = hl.base04, fg = "NONE" })
vim.api.nvim_set_hl(0, "CmpDoc", { bg = hl.base02, fg = "NONE" })
vim.api.nvim_set_hl(0, "CmpDocBorder", { bg = hl.base02, fg = hl.base05 })
vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = hl.base0F, bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = hl.base05, bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = hl.base0F, bg = "NONE", strikethrough = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = hl.base08, bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = hl.base08, bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = hl.base0C, bg = "NONE", italic = true })
vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = hl.base03, bg = hl.base09 })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = hl.base03, bg = hl.base09 })
vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = hl.base03, bg = hl.base09 })
vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = hl.base03, bg = hl.base0B })
vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = hl.base03, bg = hl.base0B })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = hl.base03, bg = hl.base0B })
vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = hl.base03, bg = hl.base08 })
vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = hl.base03, bg = hl.base08 })
vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = hl.base03, bg = hl.base08 })
vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = hl.base03, bg = hl.base0C })
vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = hl.base03, bg = hl.base0C })
vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = hl.base03, bg = hl.base0C })
vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = hl.base03, bg = hl.base0C })
vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = hl.base03, bg = hl.base0C })
vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = hl.base03, bg = hl.base0A })
vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = hl.base03, bg = hl.base0A })
vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = hl.base03, bg = hl.base0E })
vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = hl.base03, bg = hl.base0E })
vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = hl.base03, bg = hl.base0E })
vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = hl.base03, bg = hl.base0D })
vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = hl.base03, bg = hl.base0D })
vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = hl.base03, bg = hl.base0D })
vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = hl.base03, bg = hl.base0F })
vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = hl.base03, bg = hl.base0F })
vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = hl.base03, bg = hl.base0F })

cmp.setup {
  completion = {
    autocomplete = { cmp.TriggerEvent.TextChanged },
    completeopt = "menu,menuone,noinsert",
  },
  sorting = {
    priority_weight = 1,
    comparators = {
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.offset,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
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
      local source_mapping = {
        nvim_lsp = 'LSP',
        luasnip = 'SNP',
        buffer = 'BUF',
        path = 'PAT',
        nvim_lua = 'LUA',
      }
      local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
      local strings = vim.split(kind.kind, "%s", { trimempty = true })
      local source_name = entry.source.name
      kind.kind = " " .. (strings[1] or "") .. " "
      kind.menu = source_mapping[source_name]
      return kind
    end,
  },
  window = {
    completion = {
      winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpSel,Search:None",
      col_offset = -3,
      side_padding = 0,
    },
    documentation = {

      winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder",
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
    disallow_partial_fuzzy_matching = false,
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
