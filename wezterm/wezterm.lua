local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- ── Appearance ────────────────────────────────────────────────────────────
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font_with_fallback({
	{ family = "JetBrains Mono", weight = "Medium" },
	"Symbols Nerd Font Mono",
})
config.font_size = 14.0
config.line_height = 1.15

config.window_background_opacity = 0.80
config.macos_window_background_blur = 60
config.window_decorations = "TITLE|RESIZE"
config.window_padding = { left = 14, right = 14, top = 12, bottom = 8 }

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width = 32
config.colors = {
	tab_bar = {
		background = "#11111b",
		active_tab = { bg_color = "#89b4fa", fg_color = "#11111b", intensity = "Bold" },
		inactive_tab = { bg_color = "#181825", fg_color = "#a6adc8" },
		inactive_tab_hover = { bg_color = "#45475a", fg_color = "#cdd6f4" },
		new_tab = { bg_color = "#11111b", fg_color = "#a6adc8" },
		new_tab_hover = { bg_color = "#45475a", fg_color = "#cdd6f4" },
	},
}

config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500
config.inactive_pane_hsb = { saturation = 0.85, brightness = 0.65 }
config.scrollback_lines = 10000
config.window_close_confirmation = "NeverPrompt"
config.audible_bell = "Disabled"

-- ── Keys: match VS Code's integrated terminal on macOS ────────────────────
config.keys = {
	-- Opt+←/→ : jump by word
	{ key = "LeftArrow", mods = "OPT", action = act.SendString("\x1bb") },
	{ key = "RightArrow", mods = "OPT", action = act.SendString("\x1bf") },
	-- Cmd+←/→ : start / end of line
	{ key = "LeftArrow", mods = "CMD", action = act.SendString("\x01") },
	{ key = "RightArrow", mods = "CMD", action = act.SendString("\x05") },
	-- Opt+Backspace : delete previous word
	{ key = "Backspace", mods = "OPT", action = act.SendString("\x1b\x7f") },
	-- Cmd+Backspace : delete to start of line
	{ key = "Backspace", mods = "CMD", action = act.SendString("\x15") },
	-- Cmd+K : clear terminal
	{ key = "k", mods = "CMD", action = act.ClearScrollback("ScrollbackAndViewport") },

	-- Splits (VS Code: Cmd+\ splits the terminal)
	{ key = "\\", mods = "CMD", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "\\", mods = "CMD|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	-- Navigate between split panes (VS Code: Opt+Cmd+arrows)
	{ key = "LeftArrow", mods = "CMD|OPT", action = act.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "CMD|OPT", action = act.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "CMD|OPT", action = act.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "CMD|OPT", action = act.ActivatePaneDirection("Down") },
	-- Cmd+W closes the current pane (falls back to closing the tab/window)
	{ key = "w", mods = "CMD", action = act.CloseCurrentPane({ confirm = false }) },
	-- Cycle tabs
	{ key = "]", mods = "CMD|SHIFT", action = act.ActivateTabRelative(1) },
	{ key = "[", mods = "CMD|SHIFT", action = act.ActivateTabRelative(-1) },
}

return config
