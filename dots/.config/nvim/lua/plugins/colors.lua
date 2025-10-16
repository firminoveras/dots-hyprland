local ok, base16 = pcall(require, 'base16-colorscheme')
if not ok then return end

base16.setup {
  base00 = "#1D100F", -- BG
  base01 = "#261817", -- BG Light (Line HL)
  base02 = "#2A1C1B", -- BG Selection (IdentLine)
  base03 = "#413130", -- Comments, Invisibles

  base04 = "#59413F", -- FG Dark (NumHl), Status Bars
  base05 = "#F6DDDA", -- FG (Caret, Delimiters, Operators)
  base06 = "#FFFBFF", -- FG Light
  base07 = "#FFFFFF", -- FB Lighter

  base08 = "#FFBF8C", -- Variables
  base09 = "#FF544B", -- RED (Constants, Int, Bool, Numbers)
  base0A = "#FFDFD2", -- YELLOW - Classes, Object Primitives, Search BG
  base0B = "#B8AC66", -- GREEN - Strings
  base0C = "#F08F9B", -- PINK - Support Chars, Regular Expressions, Escape Char
  base0D = "#F9BF70", -- ORANGE - Dinamic Keywords, (Functions, MEthods)
  base0E = "#EFD3C6", -- ??? - Static Keywords, ? : if else for
  base0F = "#CCB4AB", -- GRAY - Deprecated, Symbols , . :
}
