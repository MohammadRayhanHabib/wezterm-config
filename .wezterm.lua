local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- PERFORMANCE & RENDERING
config.front_end = "OpenGL"
config.max_fps = 160
config.animation_fps = 1
config.cursor_blink_rate = 500
config.default_cursor_style = "BlinkingBlock"
config.term = "xterm-256color"
config.prefer_egl = true
config.font = wezterm.font("JetBrains Mono", { weight = "Medium" })

-- SMOOTH CURSOR (closest WezTerm can get to smear-cursor.nvim)
config.cursor_blink_ease_in = "EaseOut"
config.cursor_blink_ease_out = "EaseOut"

-- Speed up the animation for a snappier, fluid feel (in milliseconds)

-- FONT
--

--config.font = wezterm.font("Iosevka Custom")
config.font_size = 14.0
config.cell_width = 0.9

-- PADDING & DECORATIONS
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_decorations = "NONE | RESIZE"

-- OPACITY
config.window_background_opacity = 0.9
-- config.win32_system_backdrop = "Acrylic"
--config.window_background_image = "C:/Users/ref/Pictures/r.png"
-- config.window_background_image_hsb = {
-- 	brightness = 0.04, -- dim it
-- 	hue = 1.0,
-- 	saturation = 1.0,
-- }
-- STARTUP SHELL
config.default_prog = { "powershell.exe", "-NoLogo" }

-- WINDOW SIZE
config.initial_cols = 80

-- TABS
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

-- CUSTOM COLOR SCHEME
config.color_schemes = {
	["Rayhan Dark"] = {
		foreground = "#d0c8c6",
		background = "rgba(0, 0, 0, 80%)", -- fully transparent black
		cursor_bg = "#eeeeee",
		cursor_border = "#000000",
		cursor_fg = "#000000",
		selection_bg = "rgba(255, 255, 255, 15%)",
		selection_fg = "#ffffff",
		ansi = {
			"#1d202f", -- black
			"#f7768e", -- red
			"#9ece6a", -- green
			"#e0af68", -- yellow
			"#7aa2f7", -- blue
			"#bb9af7", -- magenta
			"#7dcfff", -- cyan
			"#a9b1d6", -- white
		},
		brights = {
			"#414868", -- bright black
			"#f7768e", -- bright red
			"#9ece6a", -- bright green
			"#e0af68", -- bright yellow
			"#7aa2f7", -- bright blue
			"#bb9af7", -- bright magenta
			"#7dcfff", -- bright cyan
			"#c0caf5", -- bright white
		},

		tab_bar = {
			background = "rgba(0, 0, 0, 80%)",
			active_tab = {
				bg_color = "rgba(0, 0, 0, 80%)",
				fg_color = "#ffffff",
				intensity = "Normal",
				underline = "None",
				italic = false,
				strikethrough = false,
			},
			inactive_tab = {
				bg_color = "rgba(0, 0, 0, 80%)",
				fg_color = "#cccccc",
				intensity = "Normal",
				underline = "None",
				italic = false,
				strikethrough = false,
			},
			new_tab = {
				bg_color = "rgba(0, 0, 0, 80%)",
				fg_color = "#ffffff",
			},
		},
	},
}

-- APPLY CUSTOM COLOR SCHEME
config.color_scheme = "Rayhan Dark"

-- WINDOW FRAME FONT
config.window_frame = {
	font = wezterm.font({ family = "Iosevka Custom", weight = "Regular" }),
	active_titlebar_bg = "rgba(0, 0, 0, 0%)",
}

-- EVENT: TOGGLE THEME
wezterm.on("toggle-rayhan-colorscheme", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if overrides.color_scheme == "Rayhan Dark" then
		overrides.color_scheme = "Cloud (terminal.sexy)"
	else
		overrides.color_scheme = "Rayhan Dark"
	end
	window:set_config_overrides(overrides)
end)

-- EVENT: TOGGLE OPACITY
wezterm.on("toggle-opacity", function(window, _)
	local overrides = window:get_config_overrides() or {}
	if overrides.window_background_opacity == 1.0 then
		overrides.window_background_opacity = 0.85
	else
		overrides.window_background_opacity = 1.0
	end
	window:set_config_overrides(overrides)
end)

-- KEY BINDINGS
config.keys = {
	{
		key = "R",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.EmitEvent("toggle-rayhan-colorscheme"),
	},
	{
		key = "O",
		mods = "CTRL|ALT",
		action = wezterm.action.EmitEvent("toggle-opacity"),
	},
	{
		key = "h",
		mods = "CTRL|SHIFT|ALT",
		action = act.SplitPane({ direction = "Right", size = { Percent = 50 } }),
	},
	{
		key = "v",
		mods = "CTRL|SHIFT|ALT",
		action = act.SplitPane({ direction = "Down", size = { Percent = 50 } }),
	},
	{ key = "U", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "I", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
	{ key = "O", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
	{ key = "P", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },
	{ key = "9", mods = "CTRL", action = act.PaneSelect },
	{ key = "L", mods = "CTRL", action = act.ShowDebugOverlay },
}

return config
