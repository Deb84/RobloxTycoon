ServerStorage = game:GetService('ServerStorage')
Tycoon = ServerStorage:WaitForChild('Tycoon')

local teamsList = {
	Red = {
		name = 'Red',
		displayedName = 'Konhoa',
		coins = 100,
		color = Color3.new(255,0,0),
		baseplateModel = Tycoon:WaitForChild('Start'):WaitForChild('Baseplates'):WaitForChild('TycoonBaseplate'),
		baseplatePos = CFrame.new(0,10,0) * CFrame.fromOrientation(math.rad(0), math.rad(0), math.rad(0))
	}
}

return teamsList
