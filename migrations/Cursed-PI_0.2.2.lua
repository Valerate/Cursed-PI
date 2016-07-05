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
	for _,force in pairs(game.forces) do
		for _,inserter in ipairs(inserters) do
			local tech = force.technologies["cursed-ins-tech-"..inserter]
			if (tech ~= nil and tech.researched) then
				force.recipes["cursed-ins-"..inserter].enabled = true
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