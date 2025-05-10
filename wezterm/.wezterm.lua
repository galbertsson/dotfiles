local wezterm = require("wezterm")
local config = wezterm.config_builder()

local is_windows = wezterm.target_triple:find("windows") ~= nil
local filename = is_windows and wezterm.home_dir .. "\\Documents\\Repos\\temp_wezterm_workspace_selection.txt"
	or wezterm.home_dir .. "/repos/temp_wezterm_workspace_selection.txt"

wezterm.on("start-poll-for-fzf-workspace-selection", function(window, pane)
	-- Hacky way of getting the result of fzf workspace selection
	while true do
		local file = io.open(filename, "r")

		if file then
			local fzfSelection = file:read("*all"):gsub("\r?\n$", "")
			file:close()
			os.remove(filename)

			local spawn_command = {
				label = fzfSelection,
				cwd = fzfSelection,
				args = {
					"powershell.exe",
					"-NoProfile",
					"-Command",
					"nvim .",
				},
			}

			if not is_windows then
				spawn_command = {
					label = fzfSelection,
					cwd = fzfSelection,
					args = { "bash", "-c", "nvim ." },
				}
			end

			window:perform_action(
				wezterm.action.SwitchToWorkspace({
					name = fzfSelection,
					spawn = spawn_command,
				}),
				pane
			)
			return
		else
			wezterm.sleep_ms(100)
		end
	end
end)

config.keys = {
	{ key = "1", mods = "ALT", action = wezterm.action.ActivateTab(0) },
	{ key = "2", mods = "ALT", action = wezterm.action.ActivateTab(1) },
	{ key = "3", mods = "ALT", action = wezterm.action.ActivateTab(2) },
	{ key = "4", mods = "ALT", action = wezterm.action.ActivateTab(3) },
	{ key = "5", mods = "ALT", action = wezterm.action.ActivateTab(4) },
	{ key = "6", mods = "ALT", action = wezterm.action.ActivateTab(5) },
	{ key = "7", mods = "ALT", action = wezterm.action.ActivateTab(6) },
	{ key = "8", mods = "ALT", action = wezterm.action.ActivateTab(7) },
	{ key = "9", mods = "ALT", action = wezterm.action.ActivateTab(8) },
	{ key = "a", mods = "ALT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{
		key = "s",
		mods = "ALT",
		action = wezterm.action_callback(function(window, pane)
			local cmd = {
				"powershell.exe",
				"-NoProfile",
				"-Command",
				[[
        cd $env:USERPROFILE\Documents\Repos;
        $selection = Get-ChildItem -Directory | ForEach-Object { $_.FullName } | ./fzf;
        if ($selection) {
          Set-Content "temp_wezterm_workspace_selection.txt" $selection
        }
      ]],
			}

			if not is_windows then
				cmd = {
					"bash",
					"-c",
					[[
							cd ~/repos;
							selection=$(find ~+ -maxdepth 1 -type d ! -name '.' | fzf);
							if [ -n "$selection" ]; then
								echo "$selection" > ./temp_wezterm_workspace_selection.txt;
							fi
						]],
				}
			end

			window:perform_action(wezterm.action.SpawnCommandInNewTab({ args = cmd }), pane)
			wezterm.emit("start-poll-for-fzf-workspace-selection", window, pane)
		end),
	},
}

config.color_scheme = "Catppuccin Mocha"

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

return config
