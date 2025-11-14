local ok, scrollbar = pcall(require, "scrollbar")
if not ok then return end

local config = { marks = { Cursor = { text = " ", }, }, }

local ok_colors, base16 = pcall(require, "base16-colorscheme")
if ok_colors and base16 and base16.colors then
  config.handle = {
    color = base16.colors.base03,
    blend = 0,
  }
else
  vim.notify("base16-colorscheme não disponível — highlights do scrollbar mantidos padrão", vim.log.levels.INFO)
end

scrollbar.setup(config)
