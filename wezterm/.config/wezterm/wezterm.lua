-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Mocha"

-- This is where you actually apply your config choices

config.font = wezterm.font("MesloLGS Nerd Font Mono", { weight = "Bold" })
config.font_size = 16

config.window_close_confirmation = "NeverPrompt"

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

config.default_prog = { "zsh" }

-- apply padding when not on neovim
local padding = {
	left = "1cell",
	right = "1cell",
	top = "0.5cell",
	bottom = "0.5cell",
}

wezterm.on("update-status", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if string.find(pane:get_title(), "^n-vi-m-.*") then
		overrides.window_padding = {
			left = 0,
			right = 0,
			top = 0,
			bottom = 0,
		}
	else
		overrides.window_padding = padding
	end
	window:set_config_overrides(overrides)
end)

-- and finally, return the configuration to wezterm
return config
