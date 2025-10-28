local ok, base16 = pcall(require, 'base16-colorscheme')
if not ok then return end

base16.setup {
  base00 = "{{colors.background.default.hex}}", -- BG
  base01 = "{{colors.surface_container_low.default.hex}}", -- BG Light (Line HL)
  base02 = "{{colors.surface_container.default.hex}}", -- BG Selection (IdentLine)
  base03 = "{{colors.surface_container_highest.default.hex}}", -- Comments, Invisibles

  base04 = "{{colors.surface_variant.default.hex}}", -- FG Dark (NumHl), Status Bars
  base05 = "{{colors.on_surface_variant.default.hex}}", -- FG (Caret, Delimiters, Operators)
  base06 = "{{colors.on_background.default.hex}}", -- FG Light
  base07 = "{{colors.on_background.default.hex | auto_lightness: -5.0 }}", -- FB Lighter

  base08 = "{{colors.primary.default.hex}}", -- Variables
  base09 = "{{colors.primary_container.default.hex}}", -- Constants, Int, Bool, Numbers
  base0A = "{{colors.secondary.default.hex| auto_lightness: -2.0}}", -- Classes, Object Primitives, Search BG
  base0B = "{{colors.tertiary.default.hex}}", -- Strings
  base0C = "{{colors.tertiary_fixed.default.hex}}", -- Support Chars, Regular Expressions, Escape Char
  base0D = "{{colors.tertiary.default.hex | auto_lightness: 7.0}}", -- Dinamic Keywords, (Functions, MEthods)
  base0E = "{{colors.inverse_primary.default.hex}}", -- Static Keywords, ? : if else for
  base0F = "{{colors.outline.default.hex}}", -- Deprecated, Symbols , . :
}
