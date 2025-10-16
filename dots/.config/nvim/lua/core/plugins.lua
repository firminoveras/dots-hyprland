local pack = vim.pack
local add = pack.add

local plugins = {
  -- Dependências e utilitários básicos
  { 'nvim-lua/plenary.nvim',                    name = 'plenary' },
  { 'nvim-tree/nvim-web-devicons',              name = 'nvim-web-devicons' },
  { 'nvim-mini/mini.icons',                     name = 'mini-icons' },
  { 'MunifTanjim/nui.nvim',                     name = 'nui' },

  -- Tema / cores / notificações
  { 'RRethy/base16-nvim',                       name = 'base16' },
  { 'rcarriga/nvim-notify',                     name = 'notify' },
  { 'folke/which-key.nvim',                     name = 'which-key' },

  -- Statusline / bufferline / pequenas UIs visuais
  { 'nvim-lualine/lualine.nvim',                name = 'lualine' },
  { 'akinsho/bufferline.nvim',                  name = 'bufferline' },
  { 'mvllow/modes.nvim',                        name = 'modes' },
  { 'nvim-neo-tree/neo-tree.nvim',              name = 'neo-tree' },
  { 'petertriho/nvim-scrollbar',                name = 'scrollbar' },
  { 'luukvbaal/statuscol.nvim',                 name = 'statuscol' },

  -- Complementos de completion/UX no cmdline
  { 'hrsh7th/cmp-cmdline',                      name = 'cmp-cmdline' },
  { 'onsails/lspkind.nvim',                     name = 'lspkind' },

  -- Melhorias de edição / movimentos / matching
  { 'matze/vim-move',                           name = 'vim-move' },
  { 'andymass/vim-matchup',                     name = 'vim-matchup' },
  { 'RRethy/vim-illuminate',                    name = 'vim-illuminate' },
  { 'windwp/nvim-autopairs',                    name = 'autopairs' },

  -- Fuzzy finder & extensão
  { 'nvim-telescope/telescope.nvim',            name = 'telescope',           requires = { 'nvim-lua/plenary.nvim' } },
  { 'nvim-telescope/telescope-fzf-native.nvim', name = 'telescope-fzf-native' },

  -- Treesitter (sintaxe/indent/highlight) + related
  { 'nvim-treesitter/nvim-treesitter',          name = 'nvim-treesitter' },
  { 'lukas-reineke/indent-blankline.nvim',      name = 'blankline' },

  -- Completion / snippets
  { 'L3MON4D3/LuaSnip',                         name = 'luasnip' },
  { 'hrsh7th/nvim-cmp',                         name = 'nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp',                     name = 'cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer',                       name = 'cmp-buffer' },
  { 'hrsh7th/cmp-path',                         name = 'cmp-path' },

  -- Git / utilitários finais
  { 'lewis6991/gitsigns.nvim',                  name = 'gitsigns' },
  { 'akinsho/git-conflict.nvim',                name = 'git-conflict' },

  -- Ferramentas diversas / utilitários pequenos
  { 'lambdalisue/vim-suda',                     name = 'vim-suda' },
  { 'mrjones2014/smart-splits.nvim',            name = 'smart-splits' },

  -- LSP / ferramentas de instalação
  { 'williamboman/mason.nvim',                  name = 'mason' },
  { 'williamboman/mason-lspconfig.nvim',        name = 'mason-lspconfig' },
  { 'neovim/nvim-lspconfig',                    name = 'nvim-lspconfig' },
  { 'folke/lazydev.nvim',                       name = 'lazydev' },
}

for _, p in ipairs(plugins) do
  if type(p[1]) == "string" then
    p.src = "https://github.com/" .. p[1]
  end
end

add(plugins, { confirm = false })

local plugin_configs = {}
local seen = {}
for _, p in ipairs(plugins) do
  if type(p) == "table" and p.name and p.name ~= "" then
    local mod = "plugins." .. tostring(p.name)
    if not seen[mod] then
      table.insert(plugin_configs, mod)
      seen[mod] = true
    end
  end
end

-- Carrega cada config em ordem
local function safe_load_plugin_config(module_name)
  local ok, _ = pcall(require, module_name)
  if not ok then
    return false
  end
  return true
end

for _, cfg in ipairs(plugin_configs) do
  safe_load_plugin_config(cfg)
end
