local ServerScriptService = game:GetService('ServerScriptService')
local platesOrderList = require(ServerScriptService.Tycoon.BuyingPlates.PlatesOrderList)
local ModuleRouter = require(ServerScriptService.Utils.ModuleRouter)
local platesOrder = {}


function platesOrder.nextPlate(PlatePressedId, baseplate, team)

	if platesOrderList[PlatePressedId] then
		local PlatePressedNext = platesOrderList[PlatePressedId]

		if PlatePressedNext.nextPlates then
			for i, plateId in ipairs(PlatePressedNext.nextPlates) do
				
				ModuleRouter.execute({targetModule = 'Plates', targetFunction = 'spawnPlate', args = {plateId, baseplate, team}})
				
			end
		end
	end
end


return platesOrder
