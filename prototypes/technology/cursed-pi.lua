
local obj = util.table.deepcopy(data.raw["technology"]["steel-processing"])
obj.name = "cursed-basic-automation"
obj.upgrade = true
obj.icon = "__Cursed-PI__/graphics/inserter/cursed-inserter.png"
obj.effects = {}
obj.effects[2] = { type = "unlock-recipe", recipe = "cursed-inserter" }
obj.prerequisites = nil
data.raw[obj.type][obj.name] = obj

local obj = util.table.deepcopy(data.raw["technology"]["automation"])
obj.name = "cursed-automation"
obj.upgrade = true
obj.icon = "__Cursed-PI__/graphics/long-handed-inserter/cursed-long-handed-inserter.png"
obj.effects = {}
obj.effects[2] = { type = "unlock-recipe", recipe = "cursed-long-handed-inserter" }
obj.prerequisites = {"automation"}
data.raw[obj.type][obj.name] = obj

local obj = util.table.deepcopy(data.raw["technology"]["logistics"])
obj.name = "cursed-logistics"
obj.upgrade = true
obj.icon = "__Cursed-PI__/graphics/fast-inserter/cursed-fast-inserter.png"
obj.effects = {}
obj.effects[1] = { type = "unlock-recipe", recipe = "cursed-fast-inserter" }
obj.prerequisites = {"logistics"}
data.raw[obj.type][obj.name] = obj

local obj = util.table.deepcopy(data.raw["technology"]["electronics"])
obj.name = "cursed-electronics"
obj.upgrade = true
obj.icon = "__Cursed-PI__/graphics/filter-inserter/cursed-filter-inserter.png"
obj.effects = {}
obj.effects[1] = { type = "unlock-recipe", recipe = "cursed-filter-inserter" }
obj.prerequisites = {"electronics"}
data.raw[obj.type][obj.name] = obj

local obj = util.table.deepcopy(data.raw["technology"]["logistics-2"])
obj.name = "cursed-logistics-2"
obj.upgrade = true
obj.icon = "__Cursed-PI__/graphics/stack-filter-inserter/cursed-stack-filter-inserter.png"
obj.effects = {}
obj.effects[1] = { type = "unlock-recipe", recipe = "cursed-stack-filter-inserter" }
obj.prerequisites = {"logistics-2"}
data.raw[obj.type][obj.name] = obj

local obj = util.table.deepcopy(data.raw["technology"]["logistics-2"])
obj.name = "cursed-logistics-3"
obj.upgrade = true
obj.icon = "__Cursed-PI__/graphics/stack-inserter/cursed-stack-inserter.png"
obj.effects = {}
obj.effects[1] = { type = "unlock-recipe", recipe = "cursed-stack-inserter" }
obj.prerequisites = {"logistics-2"}
data.raw[obj.type][obj.name] = obj

