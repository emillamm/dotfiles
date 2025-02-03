-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.color_scheme = 'Nord (Gogh)'
--config.default_cwd = "~"
config.font_size = 16.0

config.keys = {
  {
    key = 'f',
    mods = 'SUPER',
    action = wezterm.action.Search({ CaseInSensitiveString = '' }),
  },
  -- Open wezterm config file
  {
    key = ',',
    mods = 'SUPER',
    action = wezterm.action.SpawnCommandInNewWindow({
      args = { os.getenv("SHELL"), '-l', '-c', '$EDITOR $WEZTERM_CONFIG_FILE' },
    }),
  },
  -- Open neovim config file
  {
    key = '.',
    mods = 'SUPER',
    action = wezterm.action.SpawnCommandInNewWindow({
      args = { os.getenv("SHELL"), '-l', '-c', '$EDITOR ~/.config/nvim/init.lua' },
    }),
  },
  -- Open new window (home)
  {
    key = 'n',
    mods = 'SUPER',
    action = wezterm.action.SpawnCommandInNewWindow({ cwd = wezterm.home_dir }),
  },
  -- Open new window (cwd)
  {
    key = 'n',
    mods = 'SHIFT|SUPER',
    action = wezterm.action.SpawnWindow,
  },
  -- Open new tab (home)
  {
    key = 't',
    mods = 'SUPER',
    action = wezterm.action.SpawnCommandInNewTab({ cwd = wezterm.home_dir }),
  },
  -- Open new tab (cwd)
  {
    key = 't',
    mods = 'SHIFT|SUPER',
    action = wezterm.action.SpawnTab("CurrentPaneDomain"),
  },
  -- Move tabs relative
  {
    key = 'k',
    mods = 'SHIFT|SUPER',
    action = wezterm.action.MoveTabRelative(1),
  },
  {
    key = 'j',
    mods = 'SHIFT|SUPER',
    action = wezterm.action.MoveTabRelative(-1),
  },
  -- Activate tabs relative
  {
    key = 'k',
    mods = 'SUPER',
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    key = 'j',
    mods = 'SUPER',
    action = wezterm.action.ActivateTabRelative(-1),
  },
}

-- and finally, return the configuration to wezterm
return config
