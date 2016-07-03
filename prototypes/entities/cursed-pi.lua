
function cursedPI_addEntity(base,name,icon,energy,energyMult,others)
	local obj = util.table.deepcopy(data.raw["inserter"][base])
	obj.name = "cursed-ins-" .. name
	obj.minable.result = obj.name
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
end
