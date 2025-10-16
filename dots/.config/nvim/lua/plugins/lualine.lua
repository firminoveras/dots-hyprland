local ok_colors, base16 = pcall(require, "base16-colorscheme")
if not ok_colors then return end

local colors = {
  red     = base16.colors.base09,
  grey    = base16.colors.base03,
  fg      = base16.colors.base07,
  bg      = base16.colors.base02,
  insert  = base16.colors.base0C,
  visual  = base16.colors.base08,
  replace = base16.colors.base0B,
}

local function get_fg(group)
  local hl = vim.api.nvim_get_hl(0, { name = group })
  return hl.fg and string.format("#%06x", hl.fg) or nil
end

local theme = {
  normal = {
    a = { fg = colors.bg, bg = colors.fg },
    b = { fg = colors.fg, bg = colors.grey },
    c = { fg = colors.fg, bg = colors.bg },
    z = { fg = colors.bg, bg = colors.fg },
  },
  insert = { a = { fg = colors.bg, bg = colors.insert } },
  visual = { a = { fg = colors.bg, bg = colors.visual } },
  replace = { a = { fg = colors.bg, bg = colors.replace } },
}

local empty = require('lualine.component'):extend()
function empty:draw(default_highlight)
  self.status = ''
  self.applied_separator = ''
  self:apply_highlights(default_highlight)
  self:apply_section_separators()
  return self.status
end

local function process_sections(sections)
  for name, section in pairs(sections) do
    local left = name:sub(9, 10) < 'x'
    for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
      table.insert(section, pos * 2, { empty, color = { fg = colors.bg, bg = colors.bg } })
    end
    for id, comp in ipairs(section) do
      if type(comp) ~= 'table' then
        comp = { comp }
        section[id] = comp
      end
      comp.separator = left and { right = '' } or { left = '' }
    end
  end
  return sections
end

local function search_result()
  if vim.v.hlsearch == 0 then
    return ''
  end
  local last_search = vim.fn.getreg('/')
  if not last_search or last_search == '' then
    return ''
  end
  local searchcount = vim.fn.searchcount { maxcount = 9999 }
  return last_search .. ' (' .. searchcount.current .. '/' .. searchcount.total .. ')'
end

local function modified()
  if vim.bo.modified then
    return ''
  elseif vim.bo.modifiable == false or vim.bo.readonly == true then
    return ''
  end
  return ''
end

require('lualine').setup {
  options = {
    theme = theme,
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = process_sections {
    lualine_a = { 'mode' },
    lualine_b = {
      { 'filename', file_status = false,        path = 1 },
      {
        'diff',
        symbols = { added = ' ', modified = ' ', removed = ' ' },
      },
      { modified,   color = { bg = colors.red } },
      {
        '%w',
        cond = function()
          return vim.wo.previewwindow
        end,
      },
      {
        '%r',
        cond = function()
          return vim.bo.readonly
        end,
      },
      {
        '%q',
        cond = function()
          return vim.bo.buftype == 'quickfix'
        end,
      },
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {
      search_result,
      {
        'diagnostics',
        source = { 'nvim' },
        sections = { 'hint' },
        diagnostics_color = { hint = { fg = colors.bg, bg = get_fg("DiagnosticHint") } },
      },
      {
        'diagnostics',
        source = { 'nvim' },
        sections = { 'info' },
        diagnostics_color = { info = { fg = colors.bg, bg = get_fg("DiagnosticInfo") } },
      },
      {
        'diagnostics',
        source = { 'nvim' },
        sections = { 'warn' },
        diagnostics_color = { warn = { fg = colors.bg, bg = get_fg("DiagnosticWarn") } },
      },
      {
        'diagnostics',
        source = { 'nvim' },
        sections = { 'error' },
        diagnostics_color = { error = { fg = colors.bg, bg = get_fg("DiagnosticError") } },
      },
      {
        'lsp_status',
        symbols = {
          done = '',
          separator = '',
        },
        'filetype',
      }
    },
    lualine_z = { '%l:%c', '%p%%/%L' },
  },
  inactive_sections = {
    lualine_c = { '%f %y %m' },
    lualine_x = {},
  },
}
