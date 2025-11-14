local ok_buf, bufferline = pcall(require, "bufferline")
if not ok_buf then return end

local config = {
  options = {
    style_preset = { bufferline.style_preset.no_italic },
    separator_style = "slope",
    show_buffer_close_icons = false,
    numbers = "ordinal",
    auto_toggle_bufferline = true,
    always_show_bufferline = false,
    indicator = {},
  },
}

local ok_colors, base16 = pcall(require, "base16-colorscheme")
if ok_colors and base16 and base16.colors then
  local c = base16.colors
  config.highlights = {
    fill = { bg = c.base01 },
    separator = { fg = c.base01, bg = c.base03 },
    separator_visible = { bg = c.base07, fg = c.base09 },
    separator_selected = { bg = c.base07, fg = c.base01 },
    numbers = { fg = c.base05, bg = c.base03 },
    numbers_selected = { fg = c.base01, bg = c.base07 },
    buffer_selected = { bg = c.base07, fg = c.base01 },
    buffer_visible = { bg = c.base03, },
    background = { bg = c.base03, fg = c.base07 },
    modified_selected = { fg = c.base09, bg = c.base07 },
    modified = { fg = c.base09, bg = c.base03 },
  }
else
  vim.notify("base16-colorscheme não disponível — highlights do bufferline mantidos padrão", vim.log.levels.INFO)
end

bufferline.setup(config)
