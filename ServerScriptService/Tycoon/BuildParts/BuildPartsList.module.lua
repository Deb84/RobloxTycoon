local ServerStorage = game:GetService('ServerStorage')
local Tycoon = ServerStorage:WaitForChild('Tycoon')

local BuildPartsList = {
	__name = 'Parts'
}

BuildPartsList.PartList = {}

BuildPartsList.Build1 = {
	[1] = {
		model = Tycoon.BuildParts.Part1,
		name = 'name',
		partTyper = 'type',
		parent = 'parent',
		parentBuilding = 'parent building',
		spawned = false,
		position = CFrame.new(0,0,0) * CFrame.fromOrientation(math.rad(0), math.rad(0), math.rad(0)),
		collisions = true
	}
}


return BuildPartsList
