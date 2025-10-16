local ok_buf, bufferline = pcall(require, "bufferline")
if not ok_buf then return end

local config = {
  options = {
    separator_style = "slant",
    show_buffer_close_icons = false,
    numbers = "ordinal",
    auto_toggle_bufferline = true,
    always_show_bufferline = false,
    indicator = {},
  },
}

local ok_colors, base16 = pcall(require, "base16-colorscheme")
if ok_colors and base16 and base16.colors then
  config.highlights = {
    fill = { bg = base16.colors.base01 },
    separator = { fg = base16.colors.base01 },
    separator_visible = { fg = base16.colors.base01 },
    separator_selected = { fg = base16.colors.base01 },
    numbers = { fg = base16.colors.base09 },
    numbers_selected = { fg = base16.colors.base00 },
  }
else
  vim.notify("base16-colorscheme não disponível — highlights do bufferline mantidos padrão", vim.log.levels.INFO)
end

bufferline.setup(config)
