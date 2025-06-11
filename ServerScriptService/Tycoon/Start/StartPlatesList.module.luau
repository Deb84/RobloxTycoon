ServerStorage = game:GetService('ServerStorage')
Tycoon = ServerStorage:WaitForChild('Tycoon')

local startPlates = {
	Red = {
		model = Tycoon:WaitForChild('Start'):WaitForChild('StartPlates'):WaitForChild('StartPlate'),
		color = Color3.fromRGB(255,0,0),
		transparency = 0.50,
		newTransparency = 0.75,
		position = CFrame.new(0,0,0) * CFrame.fromOrientation(math.rad(0), math.rad(0), math.rad(0)),
		spawned = false,
		rebounce = false
	}
}

return startPlates
