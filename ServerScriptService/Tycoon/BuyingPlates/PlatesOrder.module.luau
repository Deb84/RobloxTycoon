local ServerScriptService = game:GetService('ServerScriptService')
local platesOrderList = require(ServerScriptService.Tycoon.BuyingPlates.PlatesOrderList)
local ModuleRouter = require(ServerScriptService.ModuleRouter.ModuleRouter)
local platesOrder = {}


function platesOrder.nextPlate(PlatePressedId, baseplate, team)

	if platesOrderList[PlatePressedId] then
		local PlatePressedNext = platesOrderList[PlatePressedId]

		if PlatePressedNext.nextPlates then
			for i, plateId in ipairs(PlatePressedNext.nextPlates) do
				
				ModuleRouter.execute(script.Name, {module = 'Plates', func = 'spawnPlate', args = {plateId, baseplate, team}, argsReq = true})
				
			end
		end
	end
end


return platesOrder
