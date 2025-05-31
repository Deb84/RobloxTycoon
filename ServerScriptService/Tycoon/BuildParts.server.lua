local ServerScriptService = game:GetService('ServerScriptService')
local Tycoon = ServerScriptService:WaitForChild('Tycoon')
local BuildPartList = require(ServerScriptService.Tycoon.BuildParts.BuildPartsList)

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

local function partSpawn()
	if not BPL then
		task.wait(1)
		if not BPL then
			return
		end
	end
	
	
	
	
	
	
end




local eventPlatePressed = game.ServerScriptService.Events.Spawn.PartsSpawn
eventPlatePressed.Event:Connect(function(message)
	print('b')
	if message.plateType == 'Default' then
		if message.targetId then

			print('c')
			partSpawn(message.targetId)
			task.wait(3)
		end
	end
end)
