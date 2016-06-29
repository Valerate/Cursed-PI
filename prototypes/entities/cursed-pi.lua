
function cursedPI_addEntity(base,name,icon,result,energy,energyMult,distIn,distOut,others)
	local obj = util.table.deepcopy(data.raw["inserter"][base])
	obj.name = name
	obj.minable.result = result
	if energy ~= nil then
		if energy.energy_per_movement ~= nil then
			obj.energy_per_movement = energy.energy_per_movement
		end
		if energy.energy_per_rotation ~= nil then
			obj.energy_per_rotation = energy.energy_per_rotation
		end
	elseif energyMult ~= nil then
		obj.energy_per_movement = obj.energy_per_movement * energyMult
		obj.energy_per_rotation = obj.energy_per_rotation * energyMult
	end
	if obj.energy_source.effectivity ~= nil then
		if energy ~= nil and energy.effectivity ~= nil then
			obj.energy_source.effectivity = energy.effectivity
		elseif energyMult ~= nil then
			obj.energy_source.effectivity = obj.energy_source.effectivity / energyMult
		end
	elseif obj.energy_source.drain ~= nil then
		if energy ~= nil and energy.drain ~= nil then
			obj.energy_source.drain = energy.drain
		elseif energyMult ~= nil then
			obj.energy_source.drain = (tonumber(string.sub(obj.energy_source.drain,1,-3)) * energyMult) .. string.sub(obj.energy_source.drain,-2)
		end
	end
	obj.working_sound.match_progress_to_activity = false
	obj.icon = icon
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
					if not (i1 == i2 and j1 == j2) and not (i1 == 0 and j1 == 0) and not(i2 == 0 and j2 == 0) then
						local obj = util.table.deepcopy(data.raw["inserter"][name])
						obj.name = name .. "_" .. 3*(i1+1)+(j1+2) .. "_" .. 3*(i2+1)+(j2+2)
						if data.raw[obj.type][obj.name] == nil then
							if distIn ~= nil then
								obj.pickup_position = {j1*distIn, i1*distIn}
							else
								obj.pickup_position = {j1, i1}
							end
							if distOut ~= nil then
								obj.insert_position = {j2*(distOut + 0.2) , i2*(distOut + 0.2)}
							else
								obj.insert_position = {j2*1.2, i2*1.2}
							end
							data.raw[obj.type][obj.name] = obj
						end
					end
				end
			end
		end
	end
end
