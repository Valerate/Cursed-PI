
if data.raw["item-group"]["cursed-noshow"] == nil then
	local obj = util.table.deepcopy(data.raw["item-group"]["other"])
	obj.name = "cursed-noshow"
	obj.icon = "__Cursed-PI__/graphics/group/group.png"
	data.raw[obj.type][obj.name] = obj
end

local obj = util.table.deepcopy(data.raw["item-subgroup"]["other"])
obj.name = "cursed-noshow-inserter"
obj.group = "cursed-noshow"
obj.order = "5"
data.raw[obj.type][obj.name] = obj

		--[equipment]--
require("prototypes.entities.cursed-pi")
require("prototypes.entities.cursed-pa")

		--[Items]--
require("prototypes.items.cursed-pi")
require("prototypes.items.cursed-pa")

		--[Recipes]--
require("prototypes.recipes.cursed-pi")
require("prototypes.recipes.cursed-pa")

		--[Technologies]--
require("prototypes.technology.cursed-pi")

		--[styles]--
require("prototypes.styles")

function cursedPI_addInserter(name,baseRecipe,baseItem,baseEntity,icon,ingredients,ingMult,energy,energyMult,distIn,distOut,othersRecipe,othersItem,othersEntity)
	cursedPI_addEntity(baseEntity,name,icon,name,energy,energyMult,distIn,distOut,othersEntity)
	cursedPI_addItem(baseItem,name,icon,name,othersItem)
	cursedPI_addRecipe(baseRecipe,name,icon,ingredients,ingMult,othersRecipe)
end

cursedPI_addInserter("cursed-burner-inserter","burner-inserter","burner-inserter","burner-inserter","__Cursed-PI__/graphics/burner-inserter/cursed-burner-inserter.png",nil,3,nil,3,1,1)
cursedPI_addInserter("cursed-inserter","inserter","inserter","inserter","__Cursed-PI__/graphics/inserter/cursed-inserter.png",nil,3,nil,3,1,1,{enabled = false})
cursedPI_addInserter("cursed-long-handed-inserter","long-handed-inserter","long-handed-inserter","long-handed-inserter","__Cursed-PI__/graphics/long-handed-inserter/cursed-long-handed-inserter.png",nil,3,nil,3,2,2,{enabled = false})
cursedPI_addInserter("cursed-fast-inserter","fast-inserter","fast-inserter","fast-inserter","__Cursed-PI__/graphics/fast-inserter/cursed-fast-inserter.png",nil,3,nil,3,1,1,{enabled = false})
cursedPI_addInserter("cursed-filter-inserter","filter-inserter","filter-inserter","filter-inserter","__Cursed-PI__/graphics/filter-inserter/cursed-filter-inserter.png",nil,3,nil,3,1,1,{enabled = false})
cursedPI_addInserter("cursed-stack-filter-inserter","stack-filter-inserter","stack-filter-inserter","stack-filter-inserter","__Cursed-PI__/graphics/stack-filter-inserter/cursed-stack-filter-inserter.png",nil,3,nil,3,1,1,{enabled = false})
cursedPI_addInserter("cursed-stack-inserter","stack-inserter","stack-inserter","stack-inserter","__Cursed-PI__/graphics/stack-inserter/cursed-stack-inserter.png",nil,3,nil,3,1,1,{enabled = false})