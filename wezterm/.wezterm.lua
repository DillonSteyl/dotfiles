local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- OS-specific
local is_windows = function()
	return wezterm.target_triple:find("windows") ~= nil
end

local is_linux = function()
	return wezterm.target_triple:find("linux") ~= nil
end

if is_windows() then
	config.default_prog = { "pwsh.exe" }
end

-- Theming
config.color_scheme = "Catppuccin Macchiato"
config.font = wezterm.font("Hurmit Nerd Font")
config.font_size = 12
config.tab_max_width = 25
local COLOR_SCHEME = wezterm.get_builtin_color_schemes()[config.color_scheme]
-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

-- TMUX emulation
config.tab_and_split_indices_are_zero_based = true
config.use_fancy_tab_bar = false
config.leader = { key = " ", mods = "CTRL", timeout = 1000 }
config.max_fps = 144
config.animation_fps = 60

-- FEDORA: Fixes issue with title bar not showing
config.enable_wayland = false

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
}

-- leader + number to activate that tab
for i = 0, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i),
	})
end

-- status appearance and util functions
local basename = function(s, is_filepath)
	if is_windows() or is_linux() and is_filepath then
		-- Filepaths have a trailing slash
		s = s:sub(1, -2)
	end
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

wezterm.on("update-status", function(window, _)
	local pane = window:active_pane()

	local status_bg = { Color = COLOR_SCHEME.background }
	if window:leader_is_active() then
		status_bg = { AnsiColor = "Maroon" }
	end

	window:set_left_status(wezterm.format({
		{ Foreground = { AnsiColor = "Green" } },
		{ Background = status_bg },
		{
			Text = "  " .. window:active_workspace(),
		},
		{ Foreground = { AnsiColor = "White" } },
		{
			Text = " │ ",
		},
		{ Foreground = { AnsiColor = "Blue" } },
		{
			Text = " " .. basename(pane:get_current_working_dir().file_path, true) .. "     ",
		},
	}))
end)

wezterm.on("update-right-status", function(window, pane)
	-- "Wed Mar 3 08:14"
	local date = wezterm.format({
		{ Foreground = { AnsiColor = "Blue" } },
		{ Text = wezterm.strftime("󰃭 %Y-%m-%d  󰥔 %H:%M ") },
	})

	local bat = ""
	local bat_icon = ""
	for _, b in ipairs(wezterm.battery_info()) do
		if b.state_of_charge > 0 then
			bat_icon = "󱊣  "
		elseif b.state_of_charge > 0.33 then
			bat_icon = "󱊢  "
		elseif b.state_of_charge > 0.66 then
			bat_icon = "󱊡  "
		end
		bat = wezterm.format({
			{ Foreground = { AnsiColor = "Green" } },
			{ Text = bat_icon .. string.format("%.0f%%", b.state_of_charge * 100) },
		})
	end

	window:set_right_status(wezterm.format({
		{ Text = bat .. "   " .. date },
	}))
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = wezterm.truncate_right(tab.active_pane.title, max_width - 5)

	local tab_bg = COLOR_SCHEME.tab_bar.inactive_tab.bg_color
	local tab_fg = COLOR_SCHEME.tab_bar.inactive_tab.fg_color
	if tab.is_active then
		tab_bg = COLOR_SCHEME.tab_bar.active_tab.bg_color
		tab_fg = COLOR_SCHEME.tab_bar.active_tab.fg_color
	end

	return {
		{ Background = { Color = COLOR_SCHEME.background } },
		{ Foreground = { Color = tab_bg } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = tab_bg } },
		{ Foreground = { Color = tab_fg } },
		{ Text = tab.tab_index .. ": " .. title },
		{ Background = { Color = COLOR_SCHEME.background } },
		{ Foreground = { Color = tab_bg } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

return config
