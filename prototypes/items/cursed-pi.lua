
function cursedPI_addItem(base,name,icon,others)
	local obj = util.table.deepcopy(data.raw["item"][base])
	obj.name = "cursed-ins-" .. name
	obj.icon = icon
	obj.place_result = obj.name
	if others ~= nil then
		for k,v in pairs(others) do
			obj[k] = v
		end
	end
	data.raw[obj.type][obj.name] = obj
end
