ServerStorage = game:GetService('ServerStorage')
Tycoon = ServerStorage:WaitForChild('Tycoon')

local teamsList = {
	Red = {
		name = 'Red',
		displayedName = 'Konhoa',
		coins = 100,
		color3 = Color3.fromRGB(255,0,0),
		brickColor = BrickColor.new('Really red'),
		baseplateModel = Tycoon:WaitForChild('Start'):WaitForChild('Baseplates'):WaitForChild('TycoonBaseplate'),
		baseplatePos = CFrame.new(0,10,0) * CFrame.fromOrientation(math.rad(0), math.rad(0), math.rad(0)),
		players = {}
	}
}

return teamsList
