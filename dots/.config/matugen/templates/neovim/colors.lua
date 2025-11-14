local ok, base16 = pcall(require, 'base16-colorscheme')
if not ok then return end

base16.setup {
  base00 = "{{colors.background.default.hex}}", -- BG
  base01 = "{{colors.surface_container.default.hex}}", -- BG Light (Line HL)
  base02 = "{{colors.surface_container_high.default.hex}}", -- BG Selection (IdentLine)
  base03 = "{{colors.surface_container_highest.default.hex}}", -- Comments, Invisibles
  base04 = "{{colors.outline_variant.default.hex}}", -- FG Dark (NumHl), Status Bars
  base05 = "{{colors.on_surface_variant.default.hex}}", -- FG (Caret, Delimiters, Operators)
  base06 = "{{colors.on_surface.default.hex}}", -- FG Light
  base07 = "{{colors.term15.default.hex}}", -- FB Lighter

  base08 = "{{colors.term15.default.hex | harmonize: {{ colors.source_color.default.hex }} }}", -- WHITE Variables
  base09 = "{{colors.term09.default.hex | harmonize: {{ colors.source_color.default.hex }} }}", -- RED Constants, Int, Bool, Numbers
  base0A = "{{colors.term11.default.hex | harmonize: {{ colors.source_color.default.hex }} }}", -- YELLOW Classes, Object Primitives, Search BG
  base0B = "{{colors.term14.default.hex | harmonize: {{ colors.source_color.default.hex }} }}", -- GREEN Strings
  base0C = "{{colors.term10.default.hex | harmonize: {{ colors.source_color.default.hex }} }}", -- Support Chars, Regular Expressions, Escape Char
  base0D = "{{colors.term12.default.hex | harmonize: {{ colors.source_color.default.hex }} }}", -- BLUE Dinamic Keywords, (Functions, MEthods)
  base0E = "{{colors.term13.default.hex | harmonize: {{ colors.source_color.default.hex }} }}", -- MAGENTA Static Keywords, ? : if else for
  base0F = "{{colors.term08.default.hex | harmonize: {{ colors.source_color.default.hex }} }}", -- GRAY Deprecated, Symbols , . :
}
