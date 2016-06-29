
	local obj = util.table.deepcopy(data.raw["recipe"]["inserter"])
	obj.name = "cursed-pa"
	obj.enabled = true
	obj.ingredients = {}
	obj.result = nil
	obj.results = {}
	obj.results[1] = {}
	obj.results[1].type = "item"
	obj.results[1].name = "cursed-pa"
	obj.results[1].amount = 1
	obj.order = "a1"
	data.raw[obj.type][obj.name] = obj