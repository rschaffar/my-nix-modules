-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 10
config.font = wezterm.font("Hack Nerd Font")
-- config.color_scheme = 'Catppuccin Mocha'
config.color_scheme = "GruvboxDark"

-- config.window_background_opacity = 0.8

-- config.background = {
--   {
--     source = {
--       File = wezterm.home_dir .. "/.local/share/backgrounds/bert_backgrounds/galaxy_blue.jpg",
--       -- File = wezterm.home_dir .. "/.local/share/backgrounds/bert_backgrounds/anarchy_purple2.png",
--     },
--     hsb = { brightness = 0.08 },
--     opacity = 1.0,
--   },
-- }

-- Mouse bindings for hyperlinks
config.mouse_bindings = {
  -- Ctrl-click opens hyperlinks
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "CTRL",
    action = act.OpenLinkAtMouseCursor,
  },
  -- Plain click on hyperlinks also opens them
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "NONE",
    action = wezterm.action_callback(function(window, pane)
      local mouse = window:get_selection_text_for_pane(pane)
      -- Only open if we clicked on a hyperlink (not selecting text)
      if mouse == "" then
        window:perform_action(act.OpenLinkAtMouseCursor, pane)
      end
    end),
  },
}

config.keys = {
  {
    key = "Enter",
    mods = "ALT",
    action = act.DisableDefaultAssignment,
  },
  {
    key = "f",
    mods = "SHIFT|CTRL|ALT",
    action = act.ToggleFullScreen,
  },
  {
    key = "j",
    mods = "SHIFT|CTRL|ALT",
    action = act.PaneSelect({
      alphabet = "1234567890",
    }),
  },
  {
    key = "l",
    mods = "SHIFT|CTRL|ALT",
    action = act.ReloadConfiguration,
  },
}

-- Configure GPG agent as SSH auth socket (always override)
local f = io.popen("gpgconf --list-dirs agent-ssh-socket")
local gpg_sock = f:read("*l")
f:close()

config.default_ssh_auth_sock = gpg_sock
-- config.enable_osc52 = true

-- Reduce GPU usage
config.max_fps = 30
config.cursor_blink_rate = 0
config.default_cursor_style = "SteadyBlock"

config.skip_close_confirmation_for_processes_named = {}

-- Finally, return the configuration to wezterm:
return config
