--require("defines")

local posOut =
{
	{ 1,2,3,4,5,6,7,8,9 },
	{ 1,2,3,4,5,6,7,8,9 },
	{ 7,4,1,8,5,2,9,6,3 },
	{ 3,6,9,2,5,8,1,4,7 },
	{ },
	{ 7,4,1,8,5,2,9,6,3 },
	{ 3,6,9,2,5,8,1,4,7 },
	{ 9,8,7,6,5,4,3,2,1 },
	{ 9,8,7,6,5,4,3,2,1 },
}
local dir = { 0,0,2,6,5,2,6,4,4 }

script.on_init(function()
	for k,force in pairs(game.forces) do
		if force.technologies["automation"].researched == true then
			force.technologies["cursed-automation"].enabled = true
		end
		if force.technologies["logistics"].researched == true then
			force.technologies["cursed-logistics"].enabled = true
		end
		if force.technologies["electronics"].researched == true then
			force.technologies["cursed-electronics"].enabled = true
		end
		if force.technologies["logistics-2"].researched == true then
			force.technologies["cursed-logistics-2"].enabled = true
			force.technologies["cursed-logistics-3"].enabled = true
		end
	end
	fillGlobal()
end)

script.on_load(function()
	fillGlobal()
end)

script.on_event(defines.events.on_built_entity, function(event)
	if event.created_entity.name == "cursed-pa" then
		local player = game.players[event.player_index]
		if player.selected ~= nil and player.selected.type == "assembling-machine" then
			showGuiAssembler(event)
		end
		player.insert({name="cursed-pa",count = 1})
		event.created_entity.destroy()
	elseif global.cursedPIconfig[event.created_entity.name] ~= nil then
		local player = game.players[event.player_index]
		showGui(event,player)
	end
end)


script.on_event(defines.events.on_gui_click, function(event)
	if string.sub(event.element.name,1,8) == "datosPI_" then
		if event.element.parent.name == "tablePI1" or event.element.parent.name == "tablePI2" then
			valButtons(event)
		elseif event.element.name == "datosPI_Accept" then
			local parent = event.element.parent
			local valueIn
			local valueOut 
			for i = 1,9 do
				if i ~= 5 then
					if parent["tablePI1"]["datosPI_" .. i].state == true then
						valueIn = i
					end
				end
			end
			for i = 1,9 do
				if i ~= 5 then
					if parent["tablePI2"]["datosPI_" .. i].state == true then
						valueOut = i
					end
				end
			end
			if valueIn ~= nil and valueOut ~= nil and valueIn ~= valueOut then
				local inserter = global.cursedPI[event.player_index]
				local posx = (valueIn % 2) * -1 + 2
				local posy = posOut[valueIn][valueOut]
				inserter.surface.create_entity{name=inserter.name .. "_" .. posx .. "_" .. posy,position = inserter.position,force = inserter.force,direction = dir[valueIn]}
				inserter.destroy()
			end
			global.cursedPI[event.player_index] = nil
			parent.parent.destroy()
		end
	elseif string.sub(event.element.name,1,8) == "datosPA_" then
		local player = game.players[event.player_index]
		if event.element.parent.name == "tablePA" then
			showGui(nil,player,string.sub(event.element.name,9))
		elseif event.element.name == "datosPA_Accept" then
			local parent = event.element.parent
			local valueIn
			local valueOut 
			for i = 1,9 do
				if i ~= 5 then
					if parent["tablePI1"]["datosPI_" .. i].state == true then
						valueIn = i
					end
				end
			end
			for i = 1,9 do
				if i ~= 5 then
					if parent["tablePI2"]["datosPI_" .. i].state == true then
						valueOut = i
					end
				end
			end
			if valueIn ~= nil and valueOut ~= nil and valueIn ~= valueOut then
				local inserter = global.cursedPI[event.player_index].inserter
				local assembler = global.cursedPI[event.player_index].assembler
				local posx = (valueIn % 2) * -1 + 2
				local posy = posOut[valueIn][valueOut]
				assembler[1].recipe = player.force.recipes[inserter .. "_" .. posx .. "_" .. posy]
			end
			global.cursedPI[event.player_index] = nil
			parent.parent.destroy()
		elseif event.element.name == "datosPA_Cancel" then
			if player.gui.center.framePI ~= nil then
				player.gui.center.framePI.destroy()
			end
			global.cursedPI[player.index] = nil
		end
	elseif event.element.name == "framePI_5" then
		event.element.state = true
	end
end)

function showGui(event,player,button_sel)
	if player.gui.center.framePI ~= nil then
		player.gui.center.framePI.destroy()
	end
	if event ~= nil then
		global.cursedPI[player.index] = event.created_entity
	else
		global.cursedPI[player.index].inserter = button_sel
	end
	local framePI = player.gui.center.add({ type="frame", name="framePI", direction="vertical" })
	if event ~= nil then
		framePI.add({ type="label", name="lbl1",caption={"entity-name."..event.created_entity.name} })
	else
		framePI.add({ type="label", name="lbl1",caption={"entity-name."..button_sel} })
	end
	local tablePI = framePI.add({ type="table", name="tablePI", colspan = 3,style="cursed-PI-table" })
	local tablePI1 = tablePI.add({ type="table", name="tablePI1", colspan = 3,style="cursed-PI-table" })
	tablePI.add({ type="label", name="lbl2",caption="-->     " })
	local tablePI2 = tablePI.add({ type="table", name="tablePI2", colspan = 3,style="cursed-PI-table" })
	makeTable(tablePI1)
	makeTable(tablePI2)
	tablePI.add({ type="label", name="lbl3",caption=" " })
	tablePI.add({ type="label", name="lbl4",caption=" " })
	tablePI.add({ type="label", name="lbl5",caption=" " })
	if event ~= nil then
		tablePI.add({ type="button", name="datosPI_Accept", caption = "Accept",style="button_style" })
	elseif button_sel ~= nil then
		tablePI.add({ type="button", name="datosPA_Accept", caption = "Accept",style="button_style" })
	end
end

function showGuiAssembler(event)
	local player = game.players[event.player_index]
	if player.gui.center.framePI ~= nil then
		player.gui.center.framePI.destroy()
	end
	global.cursedPI[player.index] = {}
	global.cursedPI[player.index].assembler = event.created_entity.surface.find_entities_filtered({area={{math.floor(event.created_entity.position.x),math.floor(event.created_entity.position.y)},{math.ceil(event.created_entity.position.x),math.ceil(event.created_entity.position.y)}},type = "assembling-machine"})
	local framePI = player.gui.center.add({ type="frame", name="framePI", direction="vertical" })
	framePI.add({ type="label", name="lbl1",caption={"gui-assembling-machine.choose-recipe"} })
	local tablePA = framePI.add({ type="table", name="tablePA", colspan = 1,style="cursed-PI-table" })
	
	local del = true
	for k,v in pairs(global.cursedPIconfig) do
		if player.force.recipes[v.recipe].enabled == true then
			tablePA.add({ type="button", name="datosPA_" .. v.recipe, caption = {"entity-name." .. v.entity},style="cursed-PI-button" })
			del = false
		end
	end
	
	framePI.add({ type="button", name="datosPA_Cancel", caption = "Cancel",style="button_style" })
	if del == true then
		player.gui.center.framePI.destroy()
	end
end

function makeTable(parent,type)

	parent.add({ type="checkbox", name="datosPI_1", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="datosPI_2", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="datosPI_3", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="datosPI_4", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="framePI_5", state = true, style = "cursed-PI-base" })
	parent.add({ type="checkbox", name="datosPI_6", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="datosPI_7", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="datosPI_8", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="datosPI_9", state = false, style = "cursed-PI-hand" })
	
end

function fillGlobal()
	if global.cursedPI == nil then
		global.cursedPI = {}
	end
	if global.cursedPIconfig == nil then 
		global.cursedPIconfig =
		{
			["cursed-burner-inserter"] = { ["entity"] = "cursed-burner-inserter", ["recipe"] = "cursed-burner-inserter" },
			["cursed-inserter"] = { ["entity"] = "cursed-inserter", ["recipe"] = "cursed-inserter" },
			["cursed-long-handed-inserter"] = { ["entity"] = "cursed-long-handed-inserter", ["recipe"] = "cursed-long-handed-inserter" },
			["cursed-fast-inserter"] = { ["entity"] = "cursed-fast-inserter", ["recipe"] = "cursed-fast-inserter" },
			["cursed-filter-inserter"] = { ["entity"] = "cursed-filter-inserter", ["recipe"] = "cursed-filter-inserter" },
			["cursed-stack-filter-inserter"] = { ["entity"] = "cursed-stack-filter-inserter", ["recipe"] = "cursed-stack-filter-inserter" },
			["cursed-stack-inserter"] = { ["entity"] = "cursed-stack-inserter", ["recipe"] = "cursed-stack-inserter" }
		}
	end
end

function valButtons(event)
	local active = tonumber(string.sub(event.element.name,-1))
	for i = 1,9 do
		if i ~= 5 and i ~= active then
			event.element.parent["datosPI_" .. i].state = false
		end
	end
end


remote.add_interface("Cursed-PI",
{
addInserter = function(inserter)
	if inserter == nil then
		return "inserter nil"
	elseif inserter.name == nil then
		return "inserter.name nil"
	elseif inserter.entity == nil then
		return "inserter.entity nil"
	elseif inserter.recipe == nil then
		return "inserter.recipe nil"
	end
	global.cursedPIconfig[inserter.name] = { ["entity"] = inserter.entity, ["recipe"] = inserter.recipe }
end,
})
