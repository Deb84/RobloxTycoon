local ServerScriptService = game:GetService('ServerScriptService')
local Tycoon = ServerScriptService:WaitForChild('Tycoon')
local conveyorsList = require(Tycoon.Conveyors.ConveyorsList)
local beltUtils = require(ServerScriptService.Tycoon.Conveyors.Belt)
local destroyer = require(ServerScriptService.Tycoon.Conveyors.Destroyer)


function spawnConveyor(conveyorId, baseplate, team)
	local conveyorConfig = conveyorsList.conveyorsList[conveyorId]
	if not conveyorConfig.spawned then
		conveyorConfig.spawned = true
	
		local conveyor = conveyorConfig.model:Clone()
		conveyor:SetAttribute('Team', team.name)
		
		if conveyor:IsA('Model') then
			for _, part in pairs(conveyor:GetChildren()) do
				part:SetAttribute('Team', team.name)
				part.Anchored = true
				
				if part.Name == 'Belt' then
					
					beltUtils.belt(conveyorConfig, part, baseplate)
					
				end	
			end
		end
		
		conveyor.Name = conveyorConfig.name
		
		local baseplatePart = baseplate.BaseplateBuild
		
		local offsetY = baseplatePart:GetPivot().Y + (baseplatePart.Size.Y / 2) + (conveyor:GetExtentsSize().Y / 2)
		conveyor:PivotTo(CFrame.new(baseplatePart.CFrame.X,offsetY,baseplatePart.CFrame.Z) * conveyorConfig.position)
		
		conveyor.Parent = baseplate.Parent
		
		if conveyorConfig['destroyerId'] then
			
			destroyer.Destroyer(conveyorConfig.destroyerId, baseplate, team)
			
		end
	
	end
	
end


local conveyorSpawnEvent = ServerScriptService.Events.Spawn.ConveyorsSpawn
conveyorSpawnEvent.Event:Connect(function(message)
	
	spawnConveyor(message.targetId, message.baseplate, message.team)
end)
