return {
    {
        "RRethy/base16-nvim",
        config = function()
            require("base16-colorscheme").with_config({
                telescope = true,
                indentblankline = true,
                notify = true,
                ts_rainbow = true,
                cmp = true,
                illuminate = true,
                dapui = true,
            })
            require("base16-colorscheme").setup({
                base00 = "#1D100F",
                base01 = "#261817",
                base02 = "#2A1C1B",
                base03 = "#413130",
                base04 = "#59413F",
                base05 = "#E1BFBB",
                base06 = "#A88A87",
                base07 = "#F6DDDA",
                base08 = "#FFBDA3",
                base09 = "#FF554E",
                base0A = "#FFDFD7",
                base0B = "#B8AC66",
                base0C = "#F18F91",
                base0D = "#FFBA92",
                base0E = "#F0D1CA",
                base0F = "#CCB4AF",
            })
        end,
    },
}
