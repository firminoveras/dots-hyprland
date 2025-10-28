require("full-border"):setup()
require("bunny"):setup({
	hops = {
		{ key = "/", path = "/" },
		{ key = "h", path = "~", desc = "Home" },
		{ key = { "c", "c" }, path = "~/.config", desc = "Config" },
		{ key = { "c", "h" }, path = "~/.config/hypr", desc = "Hyprland" },
		{ key = { "c", "y" }, path = "~/.config/yazi", desc = "Yazi" },
		{ key = { "c", "n" }, path = "~/.config/nvim", desc = "NVim" },
		{ key = { "c", "q" }, path = "~/.config/quickshell/ii", desc = "QuickShell" },
		{ key = { "c", "f" }, path = "~/.config/fish", desc = "Fish" },
		{ key = { "c", "F" }, path = "~/.config/foot", desc = "Foot" },
		{ key = { "c", "k" }, path = "~/.config/kitty", desc = "Kitty" },
		{ key = { "c", "i" }, path = "~/.config/illogical-impulse", desc = "Illogical" },
		{ key = "r", path = "~/Documentos/Repositories/dots-hyprland", desc = "Hyprland Dots" },
    { key = ".", path = "~/Documentos/Repositories/dots-hyprland/dots/.config/", desc = "Dots" },
		{ key = "p", path = "~/Documentos/Projetos", desc = "Projetos" },
		{ key = "d", path = "~/Documentos", desc = "Documents" },
		{ key = "w", path = "~/Imagens/Wallpapers", desc = "Wallpapers" },
		{ key = "a", path = "/usr/share/applications", desc = "Apps" },
		{ key = "D", path = "~/Downloads", desc = "Downloads" },
	},
	desc_strategy = "path",
	ephemeral = true,
	tabs = true,
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
