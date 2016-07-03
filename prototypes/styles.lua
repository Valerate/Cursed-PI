
data.raw["gui-style"]["default"]["cursed-PI-table"] =
{
	type = "table_style",
	cell_spacing = 0,
	horizontal_spacing = 0,
	vertical_spacing = 0
}

data.raw["gui-style"]["default"]["cursed-PI-base"] =
{
	type = "checkbox_style",
	font = "default",
	font_color = {r=1, g=1, b=1},
	top_padding = 0,
	right_padding = 0,
	bottom_padding = 0,
	left_padding = 0,
	width = 32,
	height = 32,
	default_background =
	{
		filename = "__Cursed-PI__/graphics/cursed-inserter.png",
		priority = "extra-high-no-scale",
		width = 32,
		height = 32
	},
	hovered_background =
	{
		filename = "__Cursed-PI__/graphics/cursed-inserter.png",
		priority = "extra-high-no-scale",
		width = 32,
		height = 32
	},
	clicked_background =
	{
		filename = "__Cursed-PI__/graphics/cursed-inserter.png",
		priority = "extra-high-no-scale",
		width = 32,
		height = 32
	},
	checked =
	{
		filename = "__Cursed-PI__/graphics/cursed-inserter.png",
		priority = "extra-high-no-scale",
		width = 32,
		height = 32
	}
}

data.raw["gui-style"]["default"]["cursed-PI-hand"] =
{
	type = "checkbox_style",
	font = "default",
	font_color = {r=1, g=1, b=1},
	top_padding = 0,
	right_padding = 0,
	bottom_padding = 0,
	left_padding = 0,
	width = 32,
	height = 32,
	default_background =
	{
		filename = "__Cursed-PI__/graphics/gui1.png",
		priority = "extra-high",
		scale = 2,
		width = 32,
		height = 32
	},
	hovered_background =
	{
		filename = "__Cursed-PI__/graphics/gui1.png",
		priority = "extra-high",
		scale = 2,
		width = 32,
		height = 32
	},
	clicked_background =
	{
		filename = "__Cursed-PI__/graphics/gui1.png",
		priority = "extra-high",
		scale = 2,
		width = 32,
		height = 32
	},
	checked =
	{
		filename = "__Cursed-PI__/graphics/cursed-inserter-hand.png",
		priority = "extra-high-no-scale",
		width = 32,
		height = 32
	}
}


data.raw["gui-style"]["default"]["cursed-PI-button"] = 
    {
	type = "button_style",
	font = "default-button",
	default_font_color={r=1, g=1, b=1},
	align = "left",
	top_padding = 0,
	right_padding = 0,
	bottom_padding = 0,
	left_padding = 0,
	minimal_width = 300,
	height = 30,
	default_graphical_set =
		{
		type = "composition",
		filename = "__core__/graphics/gui.png",
		-- priority = "extra-high-no-scale",
		corner_size = {3, 3},
		position = {0, 16}
		},
	hovered_font_color={r=0.66, g=0.93, b=0.30},
	hovered_graphical_set =
		{
		type = "composition",
		filename = "__core__/graphics/gui.png",
		-- priority = "extra-high-no-scale",
		corner_size = {3, 3},
		position = {0, 16}
		},
	clicked_font_color={r=0.66, g=0.93, b=0.30},
	clicked_graphical_set =
		{
		type = "composition",
		filename = "__core__/graphics/gui.png",
		-- priority = "extra-high-no-scale",
		corner_size = {3, 3},
		position = {0, 16}
		},
    }