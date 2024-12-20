local function safeRequire(moduleName)
	local success, result = pcall(require, moduleName)
	if success then
		return result
	else
		return nil
	end
end

local wezterm = require("wezterm")
local glocal = safeRequire("overrides")

-- local font_name = "BlexMono Nerd Font"
-- local font_name = "MonaspiceNe Nerd Font"
-- local font_name = "Hack Nerd Font"
-- local font_name = "Iosevka Nerd Font"
-- local font_name = "JetBrainsMono Nerd Font"
local font_name = "JetBrains Mono"
local color_scheme = "Tokyo Night"
local config = wezterm.config_builder()
config.color_scheme = color_scheme
config.hide_tab_bar_if_only_one_tab = true
config.automatically_reload_config = true
config.warn_about_missing_glyphs = false
config.window_background_opacity = 1
config.front_end = "OpenGL"
-- config.freetype_load_flags = "NO_HINTING"
-- config.freetype_load_target = "Normal"
-- config.animation_fps = 120
-- config.cursor_blink_rate = 1000
-- config.cursor_blink_ease_in = "Linear"
-- config.cursor_blink_ease_out = "Linear"
-- config.default_cursor_style = "BlinkingBlock"

-- config.custom_block_glyphs = true
-- config.dpi = 150
config.font_size = 9.5
config.font = wezterm.font_with_fallback({
	font_name,
	{ family = "Symbols Nerd Font", scale = 1 },
})
config.use_cap_height_to_scale_fallback_fonts = true
-- config.font = wezterm.font(font_name, { weight = "Light" })
-- config.font_rules = {
-- 	{
-- 		italic = true,
-- 		font = wezterm.font(font_name, { weight = "Light", italic = true }), -- Italic varyantı
-- 	},
-- 	{
-- 		intensity = "Bold",
-- 		font = wezterm.font(font_name, { weight = "Bold", bold = true }), -- Bold varyantı
-- 	},
-- 	{
-- 		italic = true,
-- 		intensity = "Bold",
-- 		font = wezterm.font(font_name, { weight = "Bold", italic = true }), -- Bold Italic varyantı
-- 	},
-- }
-- config.cell_width = 1.2
config.line_height = 1.6
if glocal ~= nil then
	config = glocal.overrides(config)
end
return config
