
if data.raw["item-group"]["cursed-noshow"] == nil then
	local obj = util.table.deepcopy(data.raw["item-group"]["other"])
	obj.name = "cursed-noshow"
	obj.icon = "__Cursed-PI__/graphics/group.png"
	data.raw[obj.type][obj.name] = obj
end

		--[equipment]--
require("prototypes.entities.cursed-pi")

		--[Items]--
require("prototypes.items.cursed-pi")

		--[Recipes]--
require("prototypes.recipes.cursed-pi")

		--[Technologies]--
require("prototypes.technology.cursed-pi")

		--[styles]--
require("prototypes.styles")


function cursedPI_addInserter(baseInserter)
	local inserter = data.raw["inserter"][baseInserter]
	local icon = inserter.hand_closed_picture.filename

	local baseItem = inserter.minable.result

	local baseRecipe
	for _,recipe in pairs(data.raw["recipe"]) do
		if recipe.results ~= nil then
			for _,result in ipairs(recipe.results) do
				if (result.name == baseItem) then
					baseRecipe = recipe.name
				end
			end
		end
		if recipe.result ~= nil then
			if (recipe.result == baseItem) then
				baseRecipe = recipe.name
			end
		end
	end

	local baseTechnology
	for _,technology in pairs(data.raw["technology"]) do
		if technology.effects ~= nil then
			for _,effect in ipairs(technology.effects) do
				if (effect.type == "unlock-recipe" and effect.recipe == baseRecipe)then
					baseTechnology = technology.name
				end
			end
		end
		if technology.effect ~= nil then
			for _,effect in ipairs(technology.effect) do
				if (effect.type == "unlock-recipe" and effect.recipe == baseRecipe)then
					baseTechnology = technology.name
				end
			end
		end
	end

	if (baseItem ~= nil and baseRecipe ~= nil) then
		cursedPI_addEntity(baseInserter,baseInserter,icon,nil,3,nil)
		cursedPI_addItem(baseItem,baseInserter,icon,nil)
		cursedPI_addRecipe(baseRecipe,baseInserter,icon,nil,3,nil)
		if (baseTechnology ~= nil) then
			cursedPI_addTechnology(baseTechnology,baseInserter,icon,2)
		end
	else
		if (baseItem == nil) then
			error("baseItem")
		end
		if (baseRecipe == nil) then
			error("baseRecipe")
		end
	end
end

cursedPI_addInserter("burner-inserter")
cursedPI_addInserter("fast-inserter")
cursedPI_addInserter("filter-inserter")
cursedPI_addInserter("inserter")
cursedPI_addInserter("long-handed-inserter")
cursedPI_addInserter("stack-filter-inserter")
cursedPI_addInserter("stack-inserter")