local ok, base16 = pcall(require, 'base16-colorscheme')
if not ok then return end

base16.setup {
  base00 = "#$background #", -- BG
  base01 = "#$surfaceContainerLow #", -- BG Light (Line HL)
  base02 = "#$surfaceContainer #", -- BG Selection (IdentLine)
  base03 = "#$surfaceContainerHighest #", -- Comments, Invisibles

  base04 = "#$surfaceVariant #", -- FG Dark (NumHl), Status Bars
  base05 = "#$onBackground #", -- FG (Caret, Delimiters, Operators)
  base06 = "#$term10 #", -- FG Light
  base07 = "#$term11 #", -- FB Lighter

  base08 = "#$term2 #", -- Variables
  base09 = "#$term1 #", -- RED (Constants, Int, Bool, Numbers)
  base0A = "#$term3 #", -- YELLOW - Classes, Object Primitives, Search BG
  base0B = "#$term4 #", -- GREEN - Strings
  base0C = "#$term5 #", -- PINK - Support Chars, Regular Expressions, Escape Char
  base0D = "#$term6 #", -- ORANGE - Dinamic Keywords, (Functions, MEthods)
  base0E = "#$term7 #", -- ??? - Static Keywords, ? : if else for
  base0F = "#$term8 #", -- GRAY - Deprecated, Symbols , . :
}
