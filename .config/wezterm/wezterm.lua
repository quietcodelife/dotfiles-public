local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Font
config.font = wezterm.font("Hack Nerd Font Mono")
config.font_size = 13.0

-- Shell
config.default_prog = { "/opt/homebrew/bin/fish", "-l" }

-- Wygląd
config.color_scheme = "Tokyo Night"
config.window_background_opacity = 0.8
config.macos_window_background_blur = 20

-- Okno
config.window_padding = { left = 12, right = 12, top = 10, bottom = 10 }
config.initial_cols = 220
config.initial_rows = 50

-- Taby
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

-- Scrollback
config.scrollback_lines = 10000

-- Keybindings (opcjonalne, intuicyjne)
config.keys = {
	-- Split pionowy
	{ key = "d", mods = "CMD", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	-- Split poziomy
	{ key = "d", mods = "CMD|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	-- Zamknij panel
	{ key = "w", mods = "CMD", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
	-- Nawigacja między panelami
	{ key = "LeftArrow", mods = "CMD|OPT", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "CMD|OPT", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "CMD|OPT", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "CMD|OPT", action = wezterm.action.ActivatePaneDirection("Down") },
}

return config
