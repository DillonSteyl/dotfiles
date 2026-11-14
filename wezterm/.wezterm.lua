local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- OS-specific
local is_windows = function()
	return wezterm.target_triple:find("windows") ~= nil
end

if is_windows() then
	config.default_prog = { "pwsh.exe" }
end

local function has_custom_tab_title(tab)
	return tab.tab_title ~= ""
end

-- Theming

local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha"
	else
		return "Gruvbox (Gogh)"
	end
end

config.color_scheme = scheme_for_appearance(get_appearance())
config.window_background_opacity = 0.98

config.font = wezterm.font("CommitMono Nerd Font", { weight = 400 })
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
			{ "index" },
			{
				"process",
				fmt = function()
					return ""
				end,
				padding = 0,
			},
			{ "tab", cond = has_custom_tab_title, padding = { left = 0, right = 1 } },
			{
				"parent",
				cond = function(tab)
					return not has_custom_tab_title(tab)
				end,
				padding = 0,
			},
			function(tab)
				if not has_custom_tab_title(tab) then
					return "/"
				end
				return ""
			end,
			{
				"cwd",
				cond = function(tab)
					return not has_custom_tab_title(tab)
				end,
				padding = { left = 0, right = 1 },
			},
			{ "zoomed", padding = 0 },
		},
		tab_inactive = {
			{ "index" },
			{
				"process",
				icons_enabled = true,
				padding = 0,
				fmt = function(process, tab)
					if has_custom_tab_title(tab) then
						return ""
					end
					return process
				end,
			},
			{ "tab", cond = has_custom_tab_title, padding = { left = 0, right = 1 } },
		},
	},
})
tabline.apply_to_config(config)

-- TMUX emulation
config.window_decorations = "TITLE | RESIZE"
-- config.tab_and_split_indices_are_zero_based = true
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
		key = "v",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "-",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	-- Key Table Activation
	{
		mods = "LEADER",
		key = "r",
		action = wezterm.action.ActivateKeyTable({
			name = "resize_pane",
			one_shot = false,
		}),
	},
	{
		mods = "LEADER",
		key = "w",
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

	-- vim-style pane navigation
	{ mods = "LEADER", key = "h", action = wezterm.action.ActivatePaneDirection("Left") },
	{ mods = "LEADER", key = "j", action = wezterm.action.ActivatePaneDirection("Down") },
	{ mods = "LEADER", key = "k", action = wezterm.action.ActivatePaneDirection("Up") },
	{ mods = "LEADER", key = "l", action = wezterm.action.ActivatePaneDirection("Right") },

	-- vim-style tab navigation
	{
		mods = "LEADER",
		key = "]",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		mods = "LEADER",
		key = "[",
		action = wezterm.action.ActivateTabRelative(-1),
	},
}

-- leader + number to activate that tab
for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

-------------------------
-- Key Tables
-------------------------

config.key_tables = {
	resize_pane = {
		-- resize left
		{ key = "LeftArrow", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
		{ key = "h", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
		-- resize right
		{ key = "RightArrow", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
		{ key = "l", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
		-- resize up
		{ key = "UpArrow", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
		{ key = "k", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
		-- resize down
		{ key = "DownArrow", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },
		{ key = "j", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },
		-- Cancel the mode by pressing escape
		{ key = "Escape", action = "PopKeyTable" },
	},
}

return config
