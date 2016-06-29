
function cursedPI_addRecipe(base,name,icon,ingredients,ingMult,others)
	local obj = util.table.deepcopy(data.raw["recipe"][base])
	obj.name = name
	obj.icon = icon
	if ingredients ~= nil then
		obj.ingredients = ingredients
	elseif ingMult ~= nil then
		for _,ing in ipairs(obj.ingredients) do
			ing[2] = ing[2] * ingMult
		end
	end
	obj.result = nil
	obj.results = {}
	obj.results[1] = {}
	obj.results[1].type = "item"
	obj.results[1].name = name
	obj.results[1].amount = 1
	if others ~= nil then
		for k,v in pairs(others) do
			obj[k] = v
		end
	end
	data.raw[obj.type][obj.name] = obj
	
	
	for i1 = -1, -1 do
		for j1 = -1, 0 do
			for i2 = -1, 1 do
				for j2 = -1, 1 do
					if not (i1 == i2 and j1 == j2) and not(i2 == 0 and j2 == 0) then
						local obj = util.table.deepcopy(data.raw["recipe"][name])
						obj.name = name .. "_" .. 3*(i1+1)+(j1+2) .. "_" .. 3*(i2+1)+(j2+2)
						if data.raw["recipe"][obj.name] == nil then
							obj.enabled = false
							obj.ingredients =
							{
								{name, 1},
							}
							obj.energy_required = 1
							obj.results[1].name = obj.name
							data.raw[obj.type][obj.name] = obj
						end
					end
				end
			end
		end
	end
end