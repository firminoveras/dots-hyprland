local telescope = require('telescope')
local builtin = require('telescope.builtin')
local themes = require('telescope.themes')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local function multiopen(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local multi = picker:get_multi_selection()

    if not vim.tbl_isempty(multi) then
        actions.close(prompt_bufnr)
        for _, j in pairs(multi) do
            if j.path ~= nil then
                local path = vim.fn.fnameescape(j.path)
                if j.lnum ~= nil then
                    vim.cmd(string.format("silent! edit +%d %s", j.lnum, path))
                else
                    vim.cmd(string.format("silent! edit %s", path))
                end
            end
        end
    else
        actions.select_default(prompt_bufnr)
    end
end

telescope.setup {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    layout_strategy = 'flex',
    sorting_strategy = "ascending",
    file_ignore_patterns = { ".git/", "node_modules/", "target/", "build/", "vendor/" },
    path_display = { "truncate" },
    layout_config = {
      horizontal = {
        prompt_position = "top",
      },
      vertical = {
        mirror = false,
      },
    },
    mappings = {
      i = {
        ["<CR>"] = multiopen,
        ["<Tab>"] = actions.move_selection_next,
        ["<S-Tab>"] = actions.move_selection_previous,
      },
      n = {
        ["<esc>"] = actions.close,
        ["q"] = actions.close,
        ["<Tab>"] = actions.move_selection_next,
        ["<S-Tab>"] = actions.move_selection_previous,
        ["<Space>"] = actions.toggle_selection,
        ["<CR>"] = multiopen,
      },
    },
  },

  pickers = {
    find_files = {
      find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
    },
    live_grep = {
      prompt_title = "Words",
    },
    buffers = {
      sort_mru = true,
      ignore_current_buffer = false,
    },
  },

  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    ['ui-select'] = {
      require("telescope.themes").get_dropdown {
        -- Pode adicionar mais configurações do tema aqui
      }
    }
  },
}

pcall(function() telescope.load_extension("fzf") end)
pcall(function() telescope.load_extension("ui-select") end)

local M = {}
function M.find_all_files()
  local opts = themes.get_dropdown({
    prompt_title = "All Files (HOME)",
    find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
    cwd = vim.fn.expand("~"),
  })
  builtin.find_files(opts)
end

function M.find_all_words()
  local opts = themes.get_dropdown({
    prompt_title = "All Words (HOME)",
    cwd = vim.fn.expand("~"),
  })
  builtin.live_grep(opts)
end

return M
