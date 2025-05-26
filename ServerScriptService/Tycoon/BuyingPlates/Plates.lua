local plateList = require(script.Parent.PlatesList)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService('ReplicatedStorage')
TycoonBasePlate = workspace.Build.TycoonBaseplate


local function spawn_plate(plateId)
	local plateConfig = plateList[plateId]
	local plate = plateConfig.model:Clone()
	
	if not plateConfig.spawned and not plateConfig.destroyed then
		
		plate.Name = plateConfig.plateName
		plate.Parent = TycoonBasePlate
		plate.Anchored = true
		plateConfig.spawned = true
		
		local baseplatePart = TycoonBasePlate.BaseplateBuild
		
		local offsetY = baseplatePart.Size.Y / 2 + plate.Size.Y / 2
		plate:PivotTo(baseplatePart.CFrame * plateConfig.position)
		
		local billboardGui = Instance.new('BillboardGui')
		local textLabel = Instance.new('TextLabel')
		
		billboardGui.Size = UDim2.new(0, 200, 0, 50)
		billboardGui.MaxDistance = 100
		billboardGui.AlwaysOnTop = true
		billboardGui.StudsOffset = Vector3.new(0,3,0)
		billboardGui.Parent = plate
		
		textLabel.Text = plateConfig.textLabel
		textLabel.Size = UDim2.new(1, 0, 1, 0)
		textLabel.BackgroundTransparency = 1
		textLabel.TextColor3 = Color3.new(1,1,1)
		textLabel.TextScaled = false
		textLabel.TextSize = 40
		textLabel.Parent = billboardGui
	
	end
	
	plate.Touched:Connect(function(other_part)
		if not plateConfig.rebounce then
			plateConfig.rebounce = true
		
			local character = other_part:FindFirstAncestorOfClass("Model")
			local player = character and Players:GetPlayerFromCharacter(character)
			
			if player then
				local eventPlatePressed = game.ServerScriptService.Events.PlatesPressedEvent
				local message = {
					plateType = plateConfig.plateType,
					targetId = plateConfig.targetId,
					plateId = plateId
				}
				
				eventPlatePressed:Fire(message)
				plate:Destroy()
				
			end
		end
	end)
end


local plateSpawnEvent = game.ServerScriptService.Events.PlatesSpawnEvent
plateSpawnEvent.Event:Connect(function(message)
	spawn_plate(message)
end)

spawn_plate(1)

