local ServerStorage = game:GetService("ServerStorage")
local tycoon = ServerStorage:WaitForChild('Tycoon')

local plateList = {
	[1] = {
		spawned = false,
		destroyed = false,
		rebounce = false,
		plateType = 'Default',
		plateName = 'P-D-D-Dropper_1', -- Plate, Default, Dropper, Dropper 1
		targetType = 'Dropper',
		targetId = 1,
		targetPrice = 100,
		model = tycoon:WaitForChild('Plates'):WaitForChild('BuyingPlates'):WaitForChild('DefaultPlate'),
		position = CFrame.new(0,2.5,50) * CFrame.fromOrientation(0, math.rad(0), 0),
		textLabel = 'Dropper 1',
		nextPlates = {}
	},
	[2] = {
		spawned = false,
		destroyed = false,
		rebounce = false,
		plateType = 'Default',
		plateName = 'P-D-D-Dropper_2', -- Plate, Default, Dropper, Dropper 1
		targetType = 'Dropper',
		targetId = 2,
		targetPrice = 100,
		model = tycoon:WaitForChild('Plates'):WaitForChild('BuyingPlates'):WaitForChild('DefaultPlate'),
		position = CFrame.new(50,2.5,50) * CFrame.fromOrientation(0, math.rad(0), 0),
		textLabel = 'Dropper 2',
		nextPlates = {}
	},
	[3] = {
		spawned = false,
		destroyed = false,
		rebounce = false,
		plateType = 'Default',
		plateName = 'P-D-D-Dropper_3', -- Plate, Default, Dropper, Dropper 1
		targetType = 'Dropper',
		targetId = 1,
		targetPrice = 100,
		model = tycoon:WaitForChild('Plates'):WaitForChild('BuyingPlates'):WaitForChild('DefaultPlate'),
		position = CFrame.new(50,2.5,0) * CFrame.fromOrientation(0, math.rad(0), 0),
		textLabel = 'Dropper 3',
		nextPlates = {}
	},
	[4] = {
		spawned = false,
		destroyed = false,
		rebounce = false,
		plateType = 'Default',
		plateName = 'P-D-D-Dropper_4', -- Plate, Default, Dropper, Dropper 1
		targetType = 'Dropper',
		targetId = 1,
		targetPrice = 100,
		model = tycoon:WaitForChild('Plates'):WaitForChild('BuyingPlates'):WaitForChild('DefaultPlate'),
		position = CFrame.new(75,2.5,75) * CFrame.fromOrientation(0, math.rad(0), 0),
		textLabel = 'Dropper 4a',
		nextPlates = {}
	}
}

return plateList
