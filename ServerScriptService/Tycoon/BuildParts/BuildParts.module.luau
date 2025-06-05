local ServerScriptService = game:GetService('ServerScriptService')
local Tycoon = ServerScriptService:WaitForChild('Tycoon')
local BuildPartList = require(ServerScriptService.Tycoon.BuildParts.BuildPartsList)
local PlacementUtils = require(ServerScriptService.Utils.PlacementUtils)

local buildParts = {}

local function BuildPartListing()
	local BuildParts = {}
	for _, item in pairs(BuildPartList) do

		if typeof(item) == 'table' then

			if item.__name == 'Parts' then
				continue
			end

			for _, listItem in ipairs(item) do
				table.insert(BuildParts, listItem)
			end
		end	
	end

	for _, item in ipairs(BuildParts) do
		table.insert(BuildPartList.PartList, item)
	end

	return true
end


local BPL = BuildPartListing()

function buildParts.partSpawn(partId, baseplate, team)
	if not BPL then
		task.wait(1)
		if not BPL then
			return
		end
	end

	local partConfig = BuildPartList.PartList[partId]

	if not partConfig.spawned then
		partConfig.spawned = true

		local partModel = partConfig.model:Clone()

		partModel:SetAttribute('Team', team.name)
		partModel:SetAttribute('Build', partConfig.parentBuilding)
		partModel.Name = partConfig.name

		local collide = true
		if not partConfig.Collision then
			collide = false
		end

		if partModel:IsA('Model') then
			for _, child in ipairs(partModel:GetChildren()) do
				child:SetAttribute('Team', team.name)
				child.Anchored = true
				child.CanCollide = collide
			end
		end


		local baseplatePart = baseplate.BaseplateBuild

		local offsetY = PlacementUtils.offsetY(baseplate, partModel)
		partModel:PivotTo(offsetY * partConfig.position)

		if partConfig.Parent then
			partModel.Parent = partConfig.parent
		else
			partModel.Parent = baseplatePart.Parent.Parent
		end

	end
end


return buildParts
