local overrides = function(config)
	config.window_padding = {
		left = 0,
		right = 0,
		top = 18,
		bottom = 0,
	}
	config.line_height = 1.4
	config.font_size = 10
	return config
end
return {
	overrides = overrides,
}
