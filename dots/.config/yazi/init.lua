require("full-border"):setup()
require("bunny"):setup({
	hops = {
    -- Common
		{ key = "/", path = "󰣇 Root" },
		{ key = "h", path = "~", desc = " Home" },
		{ key = "D", path = "~/Documents", desc = "󱧶 Documents" },
		{ key = "w", path = "~/Imagens/Wallpapers", desc = "󰋩 Wallpapers" },
		{ key = "a", path = "/usr/share/applications", desc = " Apps" },
		{ key = "d", path = "~/Downloads", desc = "󰉍 Downloads" },

    -- Dots
		{ key = "r", path = "~/Documents/Repositories/dots-hyprland", desc = "󱞞 Hyprland Dots" },
    { key = ".", path = "~/Documents/Repositories/dots-hyprland/dots/.config/", desc = "󱞞 Dots" },

    -- Configs
		{ key = { "c", "c" }, path = "~/.config", desc = " Config" },
		{ key = { "c", "h" }, path = "~/.config/hypr", desc = " Hyprland" },
		{ key = { "c", "y" }, path = "~/.config/yazi", desc = " Yazi" },
		{ key = { "c", "n" }, path = "~/.config/nvim", desc = " NVim" },
		{ key = { "c", "q" }, path = "~/.config/quickshell/ii", desc = " QuickShell" },
		{ key = { "c", "f" }, path = "~/.config/fish", desc = " Fish" },
		{ key = { "c", "F" }, path = "~/.config/foot", desc = " Foot" },
		{ key = { "c", "k" }, path = "~/.config/kitty", desc = " Kitty" },

    -- Projects
		{ key = {"p", "p"}, path = "~/Documents/Projetos", desc = " Projetos" },
		{ key = {"p", "n"}, path = "~/Documents/Projetos/NotaFacilBravo", desc = "󰊢 NotaFacilBravo" },
		{ key = {"p", "h"}, path = "~/Documents/Projetos/HINEDigital/app/src/main", desc = "󰊢 HINEDigital" },
		{ key = {"p", "f"}, path = "~/Documents/Projetos/FitoMente/app/src/main", desc = "󰊢 FITOMente" },
	},
	desc_strategy = "path",
	ephemeral = false,
	tabs = false,
	notify = false,
	fuzzy_cmd = "fzf",
})

th.git = th.git or {}
th.git.modified_sign = ""
th.git.added_sign = ""
th.git.untracked_sign = ""
th.git.ignored_sign = ""
th.git.deleted_sign = ""
th.git.updated_sign = ""
th.git.modified = ui.Style():fg("blue")
th.git.added = ui.Style():fg("green")
th.git.untracked = ui.Style():fg("darkgray")
th.git.ignored = ui.Style():fg("gray")
th.git.deleted = ui.Style():fg("red")
th.git.updated = ui.Style():fg("cyan")
require("git"):setup()
