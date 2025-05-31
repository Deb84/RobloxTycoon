local plateList = require(script.Parent.PlatesList)
local Players = game:GetService("Players")
local ServerScriptService = game:GetService('ServerScriptService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local workspaceTeams = workspace:WaitForChild('Teams')
local CoinsUtils = require(ServerScriptService.Leaderboard.CoinsUtils)

local function EventMessage(plateConfig, plateId, baseplate, team)
	local message = {
		plateType = plateConfig.plateType,
		targetId = plateConfig.targetId,
		plateId = plateId,
		baseplate = baseplate,
		team = team
	}
	
	local _event = nil
	if plateConfig.targetType == 'Dropper' then
		_event = ServerScriptService.Events.Spawn.DroppersSpawn
	elseif plateConfig.targetType == 'Part' then
		_event = ServerScriptService.Events.Spawn.PartsSpawn
	elseif plateConfig.targetType == 'Conveyor' then
		_event = ServerScriptService.Events.Spawn.ConveyorsSpawn
	end
	
	
	if _event then
		local eventPlatePressed = ServerScriptService.Events.PlatesPressedEvent

		eventPlatePressed:Fire(message)
		_event:Fire(message)
	end	
end


local function spawn_plate(plateId, baseplate, team)
	local player = team.player
	local plateConfig = plateList[plateId]
	local plate = plateConfig.model:Clone()
	
	if not plateConfig.spawned and not plateConfig.destroyed then
		
		plate:SetAttribute('Team', team.name)
		plate.Name = plateConfig.plateName
		plate.Parent = baseplate.Parent
		plate.Anchored = true
		plateConfig.spawned = true
		
		local baseplatePart = baseplate.BaseplateBuild
		
		local offsetY = baseplatePart:GetPivot().Y + (baseplatePart.Size.Y / 2) + (plate.Size.Y / 2)
		plate:PivotTo(CFrame.new(baseplatePart.CFrame.X,offsetY,baseplatePart.CFrame.Z) * plateConfig.position)
		
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
		
			local character = other_part:FindFirstAncestorOfClass("Model")
			local playerTouched = character and Players:GetPlayerFromCharacter(character)
			
			if playerTouched then
				local leaderstats = playerTouched:WaitForChild('leaderstats')
				
				if leaderstats then
					local balance = leaderstats:WaitForChild('Coins').Value
					
					if balance >= plateConfig.targetPrice then
						
						CoinsUtils.removeCoins(playerTouched, plateConfig.targetPrice)

						if player.UserId == playerTouched.UserId then
							plateConfig.rebounce = true

							EventMessage(plateConfig, plateId, baseplate, team)

							plate:Destroy()

						end
					else
						print('Pas assez ! '.. plateConfig.targetPrice - balance)
					
					end
					
				end
				
			end
		
		end
	end)
end


local plateSpawnEvent = ServerScriptService.Events.Spawn.PlatesSpawn
plateSpawnEvent.Event:Connect(function(message)
	spawn_plate(message.plateId, message.baseplate, message.team)
end)

local startPlateTouchedEvent = ServerScriptService.Events.StartPlateTouched

startPlateTouchedEvent.Event:Connect(function(message)
	spawn_plate(1, message.teamBaseplate, message.team)
end)

