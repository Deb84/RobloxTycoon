local platesOrderList = require(script.Parent.PlatesOrderList)

local eventPlatePressed = game.ServerScriptService.Events.PlatesPressedEvent
local plateSpawnEvent = game.ServerScriptService.Events.Spawn.PlatesSpawn

eventPlatePressed.Event:Connect(function(message)
	
	local PlatePressedId = message.plateId
	
	if platesOrderList[PlatePressedId] then
		local PlatePressedNext = platesOrderList[PlatePressedId]
		
		if PlatePressedNext.nextPlates then
			for i, plateId in ipairs(PlatePressedNext.nextPlates) do
				
				message['plateId'] = plateId
				
				plateSpawnEvent:Fire(message)
				
			end
		end
	end
end)

