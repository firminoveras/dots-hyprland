local ok, modes = pcall(require, "modes")
if not ok then return end

local config = {
  line_opacity = 0.30,
  set_cursor = true,
  set_cursorline = true,
  set_number = true,
  set_signcolumn = false,
  ignore = { "NvimTree", "TelescopePrompt", "!minifiles" }
}

local ok_colors, base16 = pcall(require, "base16-colorscheme")
if ok_colors and base16 and base16.colors then
  config.colors = {
    copy = base16.colors.base08,
    delete = base16.colors.base09,
    change = base16.colors.base09,
    format = base16.colors.base0F,
    insert = base16.colors.base0B,
    replace = base16.colors.base09,
    visual = base16.colors.base0C,
  }
else
  vim.notify("base16-colorscheme não disponível — highlights do modes mantidos padrão", vim.log.levels.INFO)
end

modes.setup(config)
