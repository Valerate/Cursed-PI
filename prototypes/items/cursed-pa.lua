
local obj = util.table.deepcopy(data.raw["item"]["storage-tank"])
obj.name = "cursed-pa"
obj.icon = "__Cursed-PI__/graphics/pa/cursed-pa-icon.png"
obj.subgroup = "inserter"
obj.place_result = "cursed-pa"
data.raw[obj.type][obj.name] = obj
