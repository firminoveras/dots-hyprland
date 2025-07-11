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
                base00 = "#$background #",
                base01 = "#$surfaceContainerLow #",
                base02 = "#$surfaceContainer #",
                base03 = "#$surfaceContainerHighest #",
                base04 = "#$surfaceVariant #",
                base05 = "#$onSurfaceVariant #",
                base06 = "#$outline #",
                base07 = "#$onBackground #",
                base08 = "#$term2 #",
                base09 = "#$term1 #",
                base0A = "#$term3 #",
                base0B = "#$term4 #",
                base0C = "#$term5 #",
                base0D = "#$term6 #",
                base0E = "#$term7 #",
                base0F = "#$term8 #",
            })
        end,
    },
}
