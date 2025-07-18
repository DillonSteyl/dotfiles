local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Theming
config.color_scheme = "Catppuccin Macchiato"
-- config.font = wezterm.font("Hurmit Nerd Font Mono")

-- TMUX emulation
config.tab_and_split_indices_are_zero_based = true
config.use_fancy_tab_bar = false
-- config.tab_bar_at_bottom = true
config.leader = { key = " ", mods = "CTRL", timeout = 1000 }

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

-- show workspace name
wezterm.on("update-status", function(window, _)
	local WINDOW_ICON = utf8.char(0xf2d2)
	window:set_left_status(wezterm.format({
		{ Foreground = { AnsiColor = "Green" } },
		{ Text = " " .. WINDOW_ICON .. " " .. window:active_workspace() .. "    " },
	}))
end)

-- OS-specific
local is_windows = function()
	return wezterm.target_triple:find("windows") ~= nil
end

if is_windows() then
	config.default_prog = { "pwsh.exe" }
end

return config
