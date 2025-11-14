local ok, statuscol = pcall(require, 'statuscol')
if not ok then return end

statuscol.setup {
  relculright = true,
  thousands = '.',
  segments = {
    { text = { " " } },
    {
      sign = { namespace = { "diagnostic" },
        maxwidth = 1,
        colwidth = 1,
        auto = true,
        wrap = false,
        fillcharhl = "WinSeparator",
        fillchar = ' ',
      },
      click = "v:lua.ScSa",
    },
    { text = { "%2l" } },
    {
      sign = {
        namespace = { "gitsigns" },
        maxwidth = 1,
        colwidth = 1,
        auto = true,
        wrap = false,
        fillcharhl = "WinSeparator",
        fillchar = '│',
      },
      click = "v:lua.ScSa"
    },
    { text = { " " } },
  }
}
