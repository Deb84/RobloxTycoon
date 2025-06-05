local ServerStorage = game:GetService('ServerStorage')
local Tycoon = ServerStorage:WaitForChild('Tycoon')

local list = {}

list.conveyorsList = {
	[1] = {
		model = Tycoon:WaitForChild('Conveyors'):WaitForChild('Conveyor'),
		name = 'Conveyor1',
		position = CFrame.new(-39.4846,0, -49.9093) * CFrame.Angles(-0.0000, 0.0000, -0.0000),
		directionInv = true,
		speed = 20,
		spawned = false,
		destroyerId = 1,
		playerAllowed = true
	}
}

list.destroyerList = {
	[1] = {
		model = Tycoon:WaitForChild('Conveyors'):WaitForChild('Destroyer'):WaitForChild('Destroyer'),
		name = 'Destroyer1',
		position = CFrame.new(59,0,0) * CFrame.fromOrientation(math.rad(0),math.rad(0), math.rad(0)),
		directionInv = false,
		spawned = false,
		speed = 20,
		playerAllowed = false,
		destroyerPart = 'Destroyer'
	}
}

return list
