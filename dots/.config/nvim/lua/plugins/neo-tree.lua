local ok, neotree = pcall(require, "neo-tree")
if not ok then return end

neotree.setup {
  popup_border_style = 'solid',
  close_if_last_window = false,
  enable_git_status = true,
  enable_diagnostics = true,
  default_component_configs = {
    container = {
      enable_character_fade = true,
    },
    indent = {
      indent_size = 2,
      padding = 0,
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
      with_expanders = true,
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty_open = "",
      folder_empty = "󰜌",
      default = "*",
      highlight = "NeoTreeFileIcon",
      use_filtered_colors = true,
    },
    modified = {
      symbol = "",
      highlight = "NeoTreeModified",
    },
    name = {
      trailing_slash = false,
      use_filtered_colors = true,
      use_git_status_colors = false,
      highlight = "NeoTreeFileName",
    },
    git_status = {
      symbols = {
        added = "",
        modified = "",
        deleted = "",
        renamed = "",
        untracked = "",
        ignored = "",
        unstaged = "",
        staged = "",
        conflict = "",
      },
    },
    file_size = {
      enabled = true,
      width = 12,
      required_width = 64,
    },
    type = {
      enabled = true,
      width = 10,
      required_width = 122,
    },
  },
  sources = {
    'filesystem',
    'buffers',
    'git_status',
    'document_symbols',
  },
  window = {
    position = 'left',
    width = 30,
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      ['l'] = 'open',
      ['h'] = 'close_node',
      ['<cr>'] = 'open',
      ['a'] = 'add',
      ['d'] = 'delete',
      ['r'] = 'rename',
      ['<C-q>'] = 'close_window',
      ['q'] = 'close_window',
      ['.'] = 'toggle_hidden',
      ['g?'] = 'show_help',
    },
  },
  filesystem = {
    follow_current_file = {
      enabled = true,
    },
    filtered_items = {
      visible = false,
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_by_name = {
        '.git',
        'node_modules',
      },
    },
  },
  buffers = {
    follow_current_file = {
      enabled = true,
      leave_dirs_open = false,
    },
    group_empty_dirs = true,
    show_unloaded = true,
  },
}
