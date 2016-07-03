

function cursedPI_addTechnology(base,name,icon,ingMult,ingredients,others)
	local obj = util.table.deepcopy(data.raw["technology"][base])
	obj.name = "cursed-ins-tech-" .. name
	obj.upgrade = true
	obj.icon = icon
	obj.effects = {{ type = "unlock-recipe", recipe = "cursed-ins-" .. name }}
	obj.prerequisites = {base}
	if ingMult ~= nil then
		obj.unit.count = obj.unit.count * ingMult
	elseif ingredients ~= nil then
		obj.ingredients = ingredients
	end
	if others ~= nil then
		for k,v in pairs(others) do
			obj[k] = v
		end
	end
	data.raw[obj.type][obj.name] = obj
end