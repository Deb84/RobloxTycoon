local ServerScriptService = game:GetService('ServerScriptService')
local Tycoon = ServerScriptService:WaitForChild('Tycoon')
local conveyorsList = require(Tycoon.Conveyors.ConveyorsList)
local beltUtils = require(ServerScriptService.Tycoon.Conveyors.Belt)
local ModuleRouter = require(ServerScriptService.ModuleRouter.ModuleRouter)
local destroyer = require(ServerScriptService.Tycoon.Conveyors.Destroyer)
local PlacementUtils = require(ServerScriptService.Utils.PlacementUtils)
local conveyors = {}


function conveyors.spawnConveyor(conveyorId, baseplate, team)
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

		local offsetY = PlacementUtils.offsetY(baseplate, conveyor)
		conveyor:PivotTo(offsetY * conveyorConfig.position)

		conveyor.Parent = baseplate.Parent

		if conveyorConfig['destroyerId'] then

			destroyer.Destroyer(conveyorConfig.destroyerId, baseplate, team)

		end

	end

end


return conveyors
