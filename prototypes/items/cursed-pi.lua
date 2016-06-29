
function cursedPI_addItem(base,name,icon,resultPlace,others)
	local obj = util.table.deepcopy(data.raw["item"][base])
	obj.name = name
	obj.icon = icon
	obj.place_result = resultPlace
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
						local obj = util.table.deepcopy(data.raw["item"][name])
						obj.name = name .. "_" .. 3*(i1+1)+(j1+2) .. "_" .. 3*(i2+1)+(j2+2)
						if data.raw[obj.type][obj.name] == nil then
							obj.subgroup = "cursed-noshow-inserter"
							obj.place_result = obj.name
							data.raw[obj.type][obj.name] = obj
						end
					end
				end
			end
		end
	end
end
