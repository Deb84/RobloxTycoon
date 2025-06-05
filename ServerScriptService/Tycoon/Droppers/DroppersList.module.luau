local ServerStorage = game:GetService("ServerStorage")
local tycoon = ServerStorage:WaitForChild('Tycoon')

local dropper_list = {
	[1] = {
		model = tycoon:WaitForChild("Droppers"):WaitForChild("Dropper_1"),
		name = 'Dropper_1',
		spawned = false,
		state = false,
		position = CFrame.new(0,0,0) * CFrame.fromOrientation(0, math.rad(0), 0),
		partModel = tycoon:WaitForChild('Droppers'):WaitForChild('DroppersParts'):WaitForChild('Part1'), 
		partValue = 5,
		speed = 1, -- seconds for a part
		partSpawnPart = 'Extruder',
		partSpawnPos = CFrame.new(0,-1.5,0)
	},
	[2] = {
		model = tycoon:WaitForChild("Droppers"):WaitForChild("Dropper_1"),
		name = 'Dropper_1',
		spawned = false,
		state = false,
		position = CFrame.new(0,0,-50) * CFrame.fromOrientation(0, math.rad(0), 0),
		partModel = tycoon:WaitForChild('Droppers'):WaitForChild('DroppersParts'):WaitForChild('Part2'), 
		partValue = 5,
		speed = 1, -- seconds for a part
		partSpawnPart = 'Extruder',
		partSpawnPos = CFrame.new(0,-1.5,0)
	}
}



return dropper_list
