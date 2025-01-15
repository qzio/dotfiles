local wezterm = require('wezterm')

local config = wezterm.config_builder()

-- config.color_scheme = "Solarized Dark - Patched"
config.color_scheme = "Mariana"

-- decorations
config.window_decorations = "RESIZE"
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
--config.use_fancy_tab_bar = true
config.native_macos_fullscreen_mode = true
config.font_size = 16.0

-- status bar stuff

wezterm.on('update-right-status', function(window, pane)
  local date = wezterm.strftime '%Y-%m-%d %H:%M:%S'

  -- Make it italic and underlined
  window:set_right_status(wezterm.format {
    { Text = date .. ' ' },
  })
end)

-- functionalilty
config.leader = { key = 'b', mods = 'CTRL'}

config.keys = {
  -- handle
  { key = '%', mods = 'LEADER|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
  { key = '"', mods = 'LEADER|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }, },
  { key = "z", mods = "LEADER",       action="TogglePaneZoomState" },
  { key = "q", mods = "LEADER",       action=wezterm.action{CloseCurrentPane={confirm=true}}},
  { key = "p", mods = "LEADER",       action=wezterm.action{ActivateTabRelative=-1}},
  { key = "n", mods = "LEADER",       action=wezterm.action{ActivateTabRelative=1}},

  -- movement
  { key = "c", mods = "LEADER",       action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
  { key = "h", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Left"}},
  { key = "j", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Down"}},
  { key = "k", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Up"}},
  { key = "l", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Right"}},

  -- resize
  { key = "H", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Left", 5}}},
  { key = "J", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Down", 5}}},
  { key = "K", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Up", 5}}},
  { key = "L", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Right", 5}}},
}

return config
