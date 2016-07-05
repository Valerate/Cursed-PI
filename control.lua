
local posInOut =
{
	{x = -1.2, y = -1.2, d = {x = 0.4, y = 0.4} },
	{x = 0, y = -1.2, d = {x = 0, y = 0.4}},
	{x = 1.2, y = -1.2, d = {x = -0.4, y = 0.4}},
	{x = -1.2, y = 0, d = {x = 0.4, y = 0}},
	{ },
	{x = 1.2, y = 0, d = {x = -0.4, y = 0}},
	{x = -1.2, y = 1.2, d = {x = 0.4, y = -0.4}},
	{x = 0, y = 1.2, d = {x = 0, y = -0.4}},
	{x = 1.2, y = 1.2},
	{x = -2.2, y = -2.2},
	{x = -1.2, y = -2.2},
	{x = 0, y = -2.2},
	{x = 1.2, y = -2.2},
	{x = 2.2, y = -2.2},
	{x = -2.2, y = -1.2},
	{x = 2.2, y = -1.2},
	{x = -2.2, y = 0},
	{x = 2.2, y = 0},
	{x = -2.2, y = 1.2},
	{x = 2.2, y = 1.2},
	{x = -2.2, y = 2.2},
	{x = -1.2, y = 2.2},
	{x = 0, y = 2.2},
	{x = 1.2, y = 2.2},
	{x = 2.2, y = 2.2}
}

local inserters =
{
	"burner-inserter",
	"fast-inserter",
	"filter-inserter",
	"inserter",
	"long-handed-inserter",
	"stack-filter-inserter",
	"stack-inserter"
}

script.on_init(function()
	for _,force in pairs(game.forces) do
		for _,inserter in ipairs(inserters) do
			local tech = force.technologies["cursed-ins-tech-"..inserter]
			if (tech ~= nil and tech.researched) then
				force.recipes[inserter].enabled = true
			elseif (tech ~= nil and tech.prerequisites ~= nil) then
				local allright = true
				for _,prerequisite in ipairs(tech.prerequisites) do
					if force.technologies[prerequisite].researched == false then
						allright = false
					end
				end
				if allright then
					tech.enabled = true
				end
			end
		end
	end
	if global.cursedPI == nil then
		global.cursedPI = {}
	end
end)

script.on_load(function()
	if global.cursedPI == nil then
		global.cursedPI = {}
	end
end)

script.on_event(defines.events.on_built_entity, function(event)
	if string.sub(event.created_entity.name,1,11) == "cursed-ins-" then
		local player = game.players[event.player_index]
		showGui(event,player)
	end
end)


script.on_event(defines.events.on_gui_click, function(event)
	if event.element.parent.name == "tablePI1" or event.element.parent.name == "tablePI2" then
		valButtons(event)
	elseif event.element.name == "datosPI_Accept" then
		local parent = event.element.parent
		local valueIn
		local valueOut 
		local top = 9
		if (global.cursedPI[event.player_index].name == "cursed-ins-long-handed-inserter") then
			top = 25
		end
		for i = 1,top do
			if i ~= 5 then
				if parent["tablePI1"]["datosPI_" .. i].state == true then
					valueIn = i
				end
			end
		end
		for i = 1,top do
			if i ~= 5 then
				if parent["tablePI2"]["datosPI_" .. i].state == true then
					valueOut = i
				end
			end
		end
		if valueIn ~= nil and valueOut ~= nil then
			local inserter = global.cursedPI[event.player_index]
			inserter.pickup_position = {inserter.position.x + posInOut[valueIn].x,inserter.position.y + posInOut[valueIn].y}
			if event.element.parent["datosPI_Closer"].state then
				if valueOut < 10 then
					local outx = posInOut[valueOut].x - posInOut[valueOut].x / 3
					local outy = posInOut[valueOut].y - posInOut[valueOut].y / 3
					inserter.drop_position = {inserter.position.x + outx,inserter.position.y + outy}
				else
					local outx = posInOut[valueOut].x - posInOut[valueOut].x / 5.5
					local outy = posInOut[valueOut].y - posInOut[valueOut].y / 5.5
					inserter.drop_position = {inserter.position.x + outx,inserter.position.y + outy}
				end
			else
				inserter.drop_position = {inserter.position.x + posInOut[valueOut].x,inserter.position.y + posInOut[valueOut].y}
			end
		end
		global.cursedPI[event.player_index] = nil
		parent.parent.destroy()
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
	if (global.cursedPI[player.index].name == "cursed-ins-long-handed-inserter") then
		local tablePI = framePI.add({ type="table", name="tablePI", colspan = 3,style="cursed-PI-table" })
		local tablePI1 = tablePI.add({ type="table", name="tablePI1", colspan = 5,style="cursed-PI-table" })
		tablePI.add({ type="label", name="lbl2",caption="-->     " })
		local tablePI2 = tablePI.add({ type="table", name="tablePI2", colspan = 5,style="cursed-PI-table" })
		makeTableLarge(tablePI1)
		makeTableLarge(tablePI2)
		tablePI.add({ type="label", name="lbl3",caption=" " })
		tablePI.add({ type="label", name="lbl4",caption=" " })
		tablePI.add({ type="label", name="lbl5",caption=" " })
		tablePI.add({ type="label", name="lbl6",caption=" " })
		tablePI.add({ type="label", name="lbl7",caption=" " })
		tablePI.add({ type="label", name="lbl8",caption=" " })
		tablePI.add({ type="button", name="datosPI_Accept", caption = "Accept",style="button_style" })
		tablePI.add({ type="label", name="lbl9",caption=" " })
		tablePI.add({ type="checkbox", name="datosPI_Closer", caption = "Closer", state = false })
	else
		local tablePI = framePI.add({ type="table", name="tablePI", colspan = 3,style="cursed-PI-table" })
		local tablePI1 = tablePI.add({ type="table", name="tablePI1", colspan = 3,style="cursed-PI-table" })
		tablePI.add({ type="label", name="lbl2",caption="-->     " })
		local tablePI2 = tablePI.add({ type="table", name="tablePI2", colspan = 3,style="cursed-PI-table" })
		makeTable(tablePI1)
		makeTable(tablePI2)
		tablePI.add({ type="label", name="lbl3",caption=" " })
		tablePI.add({ type="label", name="lbl4",caption=" " })
		tablePI.add({ type="label", name="lbl5",caption=" " })
		tablePI.add({ type="label", name="lbl6",caption=" " })
		tablePI.add({ type="label", name="lbl7",caption=" " })
		tablePI.add({ type="label", name="lbl8",caption=" " })
		tablePI.add({ type="button", name="datosPI_Accept", caption = "Accept",style="button_style" })
		tablePI.add({ type="label", name="lbl9",caption=" " })
		tablePI.add({ type="checkbox", name="datosPI_Closer", caption = "Closer", state = false })
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

function makeTableLarge(parent,type)

	parent.add({ type="checkbox", name="datosPI_10", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="datosPI_11", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="datosPI_12", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="datosPI_13", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="datosPI_14", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="datosPI_15", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="datosPI_1", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="datosPI_2", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="datosPI_3", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="datosPI_16", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="datosPI_17", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="datosPI_4", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="framePI_5", state = true, style = "cursed-PI-base" })
	parent.add({ type="checkbox", name="datosPI_6", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="datosPI_18", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="datosPI_19", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="datosPI_7", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="datosPI_8", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="datosPI_9", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="datosPI_20", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="datosPI_21", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="datosPI_22", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="datosPI_23", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="datosPI_24", state = false, style = "cursed-PI-hand" })
	parent.add({ type="checkbox", name="datosPI_25", state = false, style = "cursed-PI-hand" })
	
end

function valButtons(event)
	local top = 9
	if (global.cursedPI[event.player_index].name == "cursed-ins-long-handed-inserter") then
		top = 25
	end
	for i = 1,top do
		if i ~= 5 then
			event.element.parent["datosPI_" .. i].state = false
		end
	end
	event.element.state = true
end