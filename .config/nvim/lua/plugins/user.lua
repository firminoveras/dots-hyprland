-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize dashboard options
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {

      dashboard = {
        enabled = true,

        width = 50,
        row = nil,
        col = nil,
        pane_gap = 4,
        autokeys = "123456789!@#$",

        preset = {
          pick = "telescope.nvim",
          keys = {
            { icon = " ", key = "n", desc = "New", action = ":ene | startinsert" },
            {
              icon = " ",
              key = "f",
              desc = "Find",
              action = ":lua Snacks.dashboard.pick('files', {cwd='~/', hidden = true})",
            },
            { icon = " ", key = "s", desc = "Session", action = ":lua require('resession').load()" },
            { icon = " ", key = "w", desc = "Words", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recents", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "Configs",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },

          header = [[
           ⠀⠀⠀⠀⠀⠀⠀⠀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡀⠀⠀⠀⠀⠀              
           ⠀⠀⠀⠀⣠⣴⡿⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⣷⣤⡀⠀              
           ⠀⠀⢀⣾⡟⡍⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⡙⣿⡄              
           ⠀⠀⣸⣿⠃⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠇⣹⣿              
           ⠀⠀⣿⣿⡆⢚⢄⣀⣠⠤⠒⠈⠁⠀⠀⠈⠉⠐⠢⢄⡀⣀⢞⠀⣾⣿              
           ⠀⠀⠸⣿⣿⣅⠄⠙⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡟⠑⣄⣽⣿⡟              
           ⠀⠀⠀⠘⢿⣿⣟⡾⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠱⣾⣿⣿⠏⠀              
           ⠀⠀⠀⠀⣸⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⡉⢻⠀⠀              
           ⠀⠀⠀⠀⢿⠀⢃⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⠁⢸⠀⠀              
           ⠀⠀⠀⠀⢸⢰⡿⢘⣦⣤⣀⠑⢦⡀⠀⣠⠖⣁⣤⣴⡊⢸⡇⡼⠀⠀              
           ⠀⠀⠀⠀⠀⠾⡅⣿⣿⣿⣿⣿⠌⠁⠀⠁⢺⣿⣿⣿⣿⠆⣇⠃⠀⠀              
           ⠀⠀⠀⠀⠀⢀⠂⠘⢿⣿⣿⡿⠀⣰⣦⠀⠸⣿⣿⡿⠋⠈⢀⠀⠀⠀              
           ⠀⠀⠀⠀⠀⢠⠀⠀⠀⠀⠀⠀⢠⣿⢻⣆⠀⠀⠀⠀⠀⠀⣸⠀⠀⠀              
           ⠀⠀⠀⠀⠀⠈⠓⠶⣶⣦⠤⠀⠘⠋⠘⠋⠀⠠⣴⣶⡶⠞⠃⠀⠀⠀              
           ⠀⠀⠀⠀⠀⠀⠀⠀⣿⢹⣷⠦⢀⠤⡤⡆⡤⣶⣿⢸⠇⠀⠀⠀⠀⠀              
           ⠀⠀⠀⠀⠀⠀⠀⢰⡀⠘⢯⣳⢶⠦⣧⢷⢗⣫⠇⠀⡸⠀⠀⠀⠀⠀              
           ⠀⠀⠀⠀⠀⠀⠀⠀⠑⢤⡀⠈⠋⠛⠛⠋⠉⢀⡠⠒⠁⠀⠀⠀⠀⠀              
           ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⢦⠀⢀⣀⠀⣠⠞⠁⠀⠀⠀⠀⠀⠀⠀              
           ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀              
 ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓
 ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒
▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░
▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ 
▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒
░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░
         ░    ░  ░    ░ ░        ░   ░         ░   ]],
        },

        sections = {
          { section = "header" },
          { section = "keys", width = 20, padding = 1 },
          { title = "Recentes", section = "recent_files", padding = 1, limit = 9 },
          { section = "startup" },
        },
      },
      bigfile = { enabled = true },
      picker = {
        enabled = true,
        win = {
          input = {
            keys = {
              ["<S-Tab>"] = { "list_up", mode = { "i", "n" } },
              ["<Tab>"] = { "list_down", mode = { "i", "n" } },
              ["<Right>"] = { "select_and_next", mode = { "i", "n" } },
            },
          },
        },
      },
      scroll = { enabled = true },
      toggle = { enabled = true },
      zen = { enabled = true },
      dim = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      animate = { enabled = true },
      notify = { enabled = true },
      layout = { enabled = true },
    },
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },

  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        separator_style = "slant",
        show_buffer_close_icons = false,
        numbers = "ordinal",
        auto_toggle_bufferline = true,
        always_show_bufferline = false,
      },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      buffers = {
        follow_current_file = {
          enabled = true,
        },
      },
    },
  },

  {
    "brenoprata10/nvim-highlight-colors",
    opts = {
      render = "virtual",
      virtual_symbol = "",
      virtual_symbol_prefix = " ",
      virtual_symbol_position = "eow",
    },
  },

  {
    "rebelot/heirline.nvim",
    opts = function(_, opts) opts.winbar = nil end,
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      keywords = {
        MARK = { icon = "", color = "info", alt = { "M" } },
        BOOKMARK_0 = { icon = "", color = "warning" },
        BOOKMARK_1 = { icon = "", color = "warning" },
        BOOKMARK_2 = { icon = "", color = "warning" },
        BOOKMARK_3 = { icon = "", color = "warning" },
        BOOKMARK_4 = { icon = "", color = "warning" },
        BOOKMARK_5 = { icon = "", color = "warning" },
        BOOKMARK_6 = { icon = "", color = "warning" },
        BOOKMARK_7 = { icon = "", color = "warning" },
        BOOKMARK_8 = { icon = "", color = "warning" },
        BOOKMARK_9 = { icon = "", color = "warning" },
      },
    },
  },

  {
    "brenoprata10/nvim-highlight-colors",
    opts = {
      render = "virtual",
      virtual_symbol = "",
      virtual_symbol_prefix = " ",
      virtual_symbol_position = "eow",
    },
  },

  {
    "rebelot/heirline.nvim",
    opts = function(_, opts) opts.winbar = nil end,
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      keywords = {
        MARK = { icon = "", color = "info", alt = { "M" } },
        BOOKMARK_0 = { icon = "", color = "warning" },
        BOOKMARK_1 = { icon = "", color = "warning" },
        BOOKMARK_2 = { icon = "", color = "warning" },
        BOOKMARK_3 = { icon = "", color = "warning" },
        BOOKMARK_4 = { icon = "", color = "warning" },
        BOOKMARK_5 = { icon = "", color = "warning" },
        BOOKMARK_6 = { icon = "", color = "warning" },
        BOOKMARK_7 = { icon = "", color = "warning" },
        BOOKMARK_8 = { icon = "", color = "warning" },
        BOOKMARK_9 = { icon = "", color = "warning" },
      },
    },
  },

  {
    "petertriho/nvim-scrollbar",
    opts = {
      handle = {
        blend = 0,
      },
      marks = {
        Cursor = {
          text = " ",
        },
      },
    },
  },

  {
    "AstroNvim/astrotheme",
    opts = {
      style = {
        -- transparent = true
      },
    },
  },

  {
    "kdheepak/monochrome.nvim",
  },
}
