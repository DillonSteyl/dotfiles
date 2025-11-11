local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- OS-specific
local is_windows = function()
	return wezterm.target_triple:find("windows") ~= nil
end

if is_windows() then
	config.default_prog = { "pwsh.exe" }
end

-- Theming
config.color_scheme = "rose-pine-moon"
config.colors = {
	selection_bg = "#d2d0e7",
	selection_fg = "#26233a",
}

config.font = wezterm.font("Hurmit Nerd Font")
config.font_size = 12
config.tab_max_width = 25

local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup({
	options = {
		theme = config.color_scheme,
		tab_separators = {
			left = wezterm.nerdfonts.ple_right_half_circle_thick,
			right = wezterm.nerdfonts.ple_left_half_circle_thick,
		},
	},
	sections = {
		tabline_a = {
			{
				"mode",
				fmt = function(mode, window)
					if window:leader_is_active() then
						return mode .. " "
					end
					return mode .. " "
				end,
			},
		},
		tab_active = {
			{ "index", zero_indexed = true },
			{ "parent", padding = 0 },
			"/",
			{ "cwd", padding = { left = 0, right = 1 } },
			{ "zoomed", padding = 0 },
		},
		tab_inactive = {
			{ "index", zero_indexed = true },
			{ "process", padding = { left = 0, right = 1 } },
		},
	},
})
tabline.apply_to_config(config)

-- TMUX emulation
config.window_decorations = "TITLE | RESIZE"
config.tab_and_split_indices_are_zero_based = true
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = false
config.leader = { key = " ", mods = "CTRL", timeout = 1000 }
config.max_fps = 144
config.animation_fps = 60

-- FEDORA: Fixes issue with title bar not showing
config.enable_wayland = false

-- Keymaps
config.keys = {
	{
		mods = "LEADER",
		key = "c",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		mods = "LEADER",
		key = "x",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		mods = "LEADER",
		key = "\\",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "-",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "s",
		action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
	},
	{
		mods = "LEADER",
		key = "n",
		action = wezterm.action.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Enter name for new workspace" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:perform_action(
						wezterm.action.SwitchToWorkspace({
							name = line,
						}),
						pane
					)
				end
			end),
		}),
	},
}

-- leader + number to activate that tab
for i = 0, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i),
	})
end

return config
