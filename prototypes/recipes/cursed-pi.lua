require "config"


function cursedPI_addRecipe(base,name,icon,ingredients,ingMult,others)
	local obj = util.table.deepcopy(data.raw["recipe"][base])
	obj.name = "cursed-ins-" .. name
	obj.icon = icon
	if obj.enabled == nil or obj.enable == true then
		if Replace then
			data.raw["recipe"][base].enabled = false
		end
	end
	if ingredients ~= nil then
		obj.ingredients = ingredients
	elseif ingMult ~= nil then
		for _,ing in ipairs(obj.ingredients) do
			ing[2] = ing[2] * ingMult
		end
	end
	obj.result = nil
	obj.results = {}
	obj.results[1] = {type = "item", name = obj.name, amount = 1}
	if others ~= nil then
		for k,v in pairs(others) do
			obj[k] = v
		end
	end	
	data.raw[obj.type][obj.name] = obj
end