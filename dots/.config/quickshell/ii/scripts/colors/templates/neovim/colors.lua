local ok, base16 = pcall(require, 'base16-colorscheme')
if not ok then return end

base16.setup {
  base00 = "#$term0 #", -- BG
  base01 = "#$surfaceContainer #", -- BG Light (Line HL)
  base02 = "#$surfaceContainerHigh #", -- BG Selection (IdentLine)
  base03 = "#$surfaceContainerHighest #", -- Comments, Invisibles
  base04 = "#$outlineVariant #", -- FG Dark (NumHl), Status Bars
  base05 = "#$onSurfaceVariant #", -- FG (Caret, Delimiters, Operators)
  base06 = "#$onSurface #", -- FG Light
  base07 = "#$term15 #", -- FB Lighter

  base08 = "#$term11 #", -- WHITE Variables
  base09 = "#$term1 #",  -- RED Constants, Int, Bool, Numbers
  base0A = "#$term2 #", -- YELLOW Classes, Object Primitives, Search BG
  base0B = "#$term3 #", -- GREEN Strings
  base0C = "#$term4 #", -- Support Chars, Regular Expressions, Escape Char
  base0D = "#$term5 #", -- BLUE Dinamic Keywords, (Functions, MEthods)
  base0E = "#$term9 #", -- MAGENTA Static Keywords, ? : if else for
  base0F = "#$term8 #",  -- GRAY Deprecated, Symbols , . :
}
