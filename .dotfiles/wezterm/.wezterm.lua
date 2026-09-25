-- These are the basic's for using wezterm.
-- Mux is the mutliplexes for windows etc inside of the terminal
-- Action is to perform actions on the terminal
local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action
local def_opacity = 0.92

-- This is for newer wezterm vertions to use the config builder 
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- WSL2 UBUNTU-22.04 as the default when opening Wezterm
config.wsl_domains = {
  {
    -- The name of this specific domain.  Must be unique amongst all types
    -- of domain in the configuration file.
    name = 'WSL:Ubuntu',

    -- The name of the distribution.  This identifies the WSL distribution.
    -- It must match a valid distribution from your `wsl -l -v` output in
    -- order for the domain to be useful.
    distribution = 'Ubuntu',

    -- The username to use when spawning commands in the distribution.
    -- If omitted, the default user for that distribution will be used.

    -- username = "chris",

    -- The current working directory to use when spawning commands, if
    -- the SpawnCommand doesn't otherwise specify the directory.

    default_cwd = "~",

    -- The default command to run, if the SpawnCommand doesn't otherwise
    -- override it.  Note that you may prefer to use `chsh` to set the
    -- default shell for your user inside WSL to avoid needing to
    -- specify it here

    default_prog = {"zsh"}
  },
}
config.default_domain = 'WSL:Ubuntu'
--config.default_cwd = '\\wsl.localhost\\Ubuntu\\home\\chris'
--config.default_prog = { 'C:\\Windows\\System32\\wsl.exe', '--distribution', 'Ubuntu', '--cd', '~' }


-- Color scheme, Wezterm has 100s of them you can see here:
--- https://wezfurlong.org/wezterm/colorschemes/index.html
--config.color_scheme = 'Gruvbox dark, hard (base16)'
--config.color_scheme = '3024 (base16)'

-- Font
config.font = wezterm.font('SFMono Nerd Font')
config.font_size = 12

config.launch_menu = launch_menu

-- Cursor
config.default_cursor_style = 'SteadyBlock'

-- Hyperlinks
--- Use the defaults as a base
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- Bell
-- config.audible_bell = 'Disabled'
-- config.visual_bell = {
  -- fade_in_function = 'EaseIn',
  -- fade_in_duration_ms = 150,
  -- fade_out_function = 'EaseOut',
  -- fade_out_duration_ms = 150,
-- }
-- config.colors = {
  -- visual_bell = '#301010',
-- }

--- make task numbers clickable
--- the first matched regex group is captured in $1.
table.insert(config.hyperlink_rules, {
  regex = [[\b[tt](\d+)\b]],
  format = 'https://example.com/tasks/?t=$1',
})

--- make username/project paths clickable. this implies paths like the following are for github.
--- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wezterm/wezterm | "wezterm/wezterm.git" )
--- as long as a full url hyperlink regex exists above this it should not match a full url to
--- github or gitlab / bitbucket (i.e. https://gitlab.com/user/project.git is still a whole clickable url)
table.insert(config.hyperlink_rules, {
  regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
  format = 'https://www.github.com/$1/$3',
})

-- Text Adjustments
--- This is used to make my foreground (text, etc) brighter than my background
-- config.foreground_text_hsb = {
  -- hue = 1.0,
  -- saturation = 1.2,
  -- brightness = 1.5,
-- }

-- Tab Bar
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

-- Window

config.window_background_opacity = def_opacity

config.window_decorations = "RESIZE"
-- config.initial_cols = 80
-- config.initial_rows = 24
 config.window_padding = {
   left = 8,
   right = 8,
   top = 8,
   bottom = 8,
}

local border_color = '#ddcba6'
local border_height = '1px'
local border_width = '1px'
config.window_frame = {
  border_left_width = border_width,
  border_right_width = border_width,
  border_bottom_height = border_height,
  border_top_height = border_height,
  border_left_color = border_color,
  border_right_color = border_color,
  border_bottom_color = border_color,
  border_top_color = border_color,
}

config.adjust_window_size_when_changing_font_size = false

-- Functions
--- opacity
wezterm.on("inc-opacity", function(window, pane)
  def_opacity=def_opacity+0.8
if def_opacity > 1.0 then
  def_opacity = 1.0
end
  local overrides = window:get_config_overrides() or {}
        overrides.window_background_opacity = def_opacity
    window:set_config_overrides(overrides)
end)
wezterm.on("dec-opacity", function(window, pane)
  def_opacity=def_opacity-0.12
if def_opacity < 0.0 then
  def_opacity = 0.0
end
  local overrides = window:get_config_overrides() or {}
        overrides.window_background_opacity = def_opacity
    window:set_config_overrides(overrides)
end)
--- scale
-- wezterm.on("inc-scale", function(window, pane)
	-- local overrides = window:get_config_overrides() or {}
	-- overrides.adjust_window_size_when_changing_font_size = true
	-- act.IncreaseFontSize
	-- window:set_config_overrides(overrides)
	-- overrides.adjust_window_size_when_changing_font_size = false
	-- act.DecreaseFontSize
	-- window:set_config_overrides(overrides)
-- end)
-- wezterm.on("dec-scale", function(window, pane)
	-- local overrides = window:get_config_overrides() or {}
	-- overrides.adjust_window_size_when_changing_font_size = true
	-- act.DecreaseFontSize
	-- window:set_config_overrides(overrides)
	-- overrides.adjust_window_size_when_changing_font_size = false
	-- act.IncreaseFontSize
	-- window:set_config_overrides(overrides)
-- end)

--- startup size and position
wezterm.on("gui-startup", function(cmd)
  local screen = wezterm.gui.screens().active
  local ratio = 0.4
  local width, height = screen.width * ratio, screen.height * ratio
  local tab, pane, window = wezterm.mux.spawn_window {
    position = {
      x = (screen.width - width) / 2,
      y = (screen.height - height) / 2,
      origin = 'ActiveScreen' }
  }
  window:gui_window():set_inner_size(width, height)
end)

--- Margined FullScreen size
-- wezterm.on("margin-fullscreen", function(window, pane)
  -- local screen = wezterm.gui.screens().active
  -- local ratio = 0.95
  -- local width, height = screen.width * ratio, screen.height * ratio
  -- local overrides = window:get_config_overrides() or {}
  -- window:gui_window():set_inner_size(width, height)
  -- window:set_config_overrides(overrides)
-- end)

--- Show which key table is active in the status area
wezterm.on('update-right-status', function(window, pane)
  local name = window:active_key_table()
  if name then
    name = 'TABLE: ' .. name
  end
  window:set_right_status(name or '')
end)


-- Key Bindings
config.disable_default_key_bindings = true

-- Key Tables
config.key_tables = {
-- Defines the keys that are active in our resize-pane mode.
-- Since we're likely to want to make multiple adjustments,
-- we made the activation one_shot=false. We therefore need
-- to define a key assignment for getting out of this mode.
-- 'alteration' here corresponds to the name="alteration" in
-- the key assignments above.
  alteration = {
--- Pane alteration
    { key = 'LeftArrow', action = act.AdjustPaneSize { 'Left', 1 } },
    { key = 'h', action = act.AdjustPaneSize { 'Left', 1 } },

    { key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 1 } },
    { key = 'l', action = act.AdjustPaneSize { 'Right', 1 } },

    { key = 'UpArrow', action = act.AdjustPaneSize { 'Up', 1 } },
    { key = 'k', action = act.AdjustPaneSize { 'Up', 1 } },

    { key = 'DownArrow', action = act.AdjustPaneSize { 'Down', 1 } },
    { key = 'j', action = act.AdjustPaneSize { 'Down', 1 } },
    -- Cancel the mode by pressing escape
    { key = 'Escape', action = 'PopKeyTable' },
  },
}

config.keys = {
	-- ctrl+v to paste the system clipboard 
	{ 
		key = 'v',
		mods = 'CTRL',
		action = act.PasteFrom 'Clipboard' 
	},
	{
		key = "q",
		mods = 'CTRL|ALT|SHIFT',
		action = act({ CloseCurrentPane = { confirm = false } }),
	},
--- navigate panes
    { key = 'LeftArrow', mods = 'CTRL', action = act.ActivatePaneDirection 'Left' },
    { key = 'h', mods = 'CTRL', action = act.ActivatePaneDirection 'Left' },

    { key = 'RightArrow', mods = 'CTRL', action = act.ActivatePaneDirection 'Right' },
    { key = 'l', mods = 'CTRL', action = act.ActivatePaneDirection 'Right' },

    { key = 'UpArrow', mods = 'CTRL', action = act.ActivatePaneDirection 'Up' },
    { key = 'k', mods = 'CTRL', action = act.ActivatePaneDirection 'Up' },

    { key = 'DownArrow', mods = 'CTRL', action = act.ActivatePaneDirection 'Down' },
    { key = 'j', mods = 'CTRL', action = act.ActivatePaneDirection 'Down' },
--- add panes
	{ key = 'LeftArrow', mods = 'CTRL|ALT', action = act.SplitPane { direction = 'Left' }},
    { key = 'h', mods = 'CTRL|ALT', action = act.SplitPane { direction = 'Left' }},

    { key = 'RightArrow', mods = 'CTRL|ALT', action = act.SplitPane { direction = 'Right' }},
    { key = 'l', mods = 'CTRL|ALT', action = act.SplitPane { direction = 'Right' }},

    { key = 'UpArrow', mods = 'CTRL|ALT', action = act.SplitPane { direction = 'Up' }},
    { key = 'k', mods = 'CTRL|ALT', action = act.SplitPane { direction = 'Up' }},

    { key = 'DownArrow', mods = 'CTRL|ALT', action = act.SplitPane { direction = 'Down' }},
    { key = 'j', mods = 'CTRL|ALT', action = act.SplitPane { direction = 'Down' }},
--- font size
    { key = '=', mods = 'CTRL', action = act.IncreaseFontSize },
	{ key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
--- opacity
	{ key = '=', mods = 'CTRL|ALT', action = act.EmitEvent("inc-opacity"),},
	{ key = '-', mods = 'CTRL|ALT', action = act.EmitEvent("dec-opacity"),},
--- scale
	-- { key = ']', mods = 'CTRL|ALT', action = act.EmitEvent("inc-scale"),},
	-- { key = '[', mods = 'CTRL|ALT', action = act.EmitEvent("dec-scale"),},
--- key tables	
	{
		key = 'a',
		mods = 'CTRL|ALT|SHIFT',
		action = act.ActivateKeyTable {name = 'alteration', one_shot = false},
	},
}



return config
