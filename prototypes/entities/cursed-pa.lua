
local obj = util.table.deepcopy(data.raw["decorative"]["brown-asterisk"])
obj.name = "cursed-pa"
obj.icon = "__Cursed-PI__/graphics/pa/cursed-pa-icon.png"
obj.collision_mask = {}
obj.order = "a1"
obj.selectable_in_game = false
obj.render_layer = "radius-visualization"
obj.autoplace = nil
obj.pictures =
	{
		{
			filename = "__Cursed-PI__/graphics/pa/cursed-pa-icon.png",
			width = 32,
			height = 32,
		}
	}
data.raw[obj.type][obj.name] = obj