local ServerScriptService = game:GetService('ServerScriptService')
local Players = game:GetService("Players")
local plates = {}

local Router = require(ServerScriptService.ModuleRouter.ModuleRouter)
Router.modulesInit(script.Name, 'PlatesOrder')
local platesList, CoinsUtils, PlacementUtils = Router.getModulesAndInit(script.name, {'PlatesList', 'CoinsUtils', 'PlacementUtils'})


local function targetSelect(plateConfig, plateId, baseplate, team)
	local message = {
		plateType = plateConfig.plateType,
		targetId = plateConfig.targetId,
		plateId = plateId,
		baseplate = baseplate,
		team = team
	}	

	local scriptName = script.Name
	if plateConfig.targetType == 'Dropper' then
		Router.execute(script.Name, {module = 'Droppers', func = 'dropperSpawn', args = {plateConfig.targetId, baseplate, team}, async = true, argsReq = true})
	elseif plateConfig.targetType == 'Part' then
		Router.execute(script.Name, {module = 'BuildParts', func = 'partSpawn', args = {plateConfig.targetId, baseplate, team}, async = true, argsReq = true})
	elseif plateConfig.targetType == 'Conveyor' then
		Router.modulesInit('Conveyors')
		Router.execute(script.Name, {module = 'Conveyors', func = 'spawnConveyor', args = {plateConfig.targetId, baseplate, team}, async = true, argsReq = true})
	end

end


function plates.spawnPlate(plateId, baseplate, team)
	
	local function plateCreation(plateConfig)
		local plateModel = plateConfig.model:Clone()
	
		local function plateBillboardGui(plateModel)
			local billboardGui = Instance.new('BillboardGui')
			billboardGui.Size = UDim2.new(0, 200, 0, 50)
			billboardGui.MaxDistance = 100
			billboardGui.AlwaysOnTop = true
			billboardGui.StudsOffset = Vector3.new(0,3,0)
			billboardGui.Parent = plateModel
			return billboardGui
		end
		
		local function plateTextLabel(plateConfig, billboardGui)
			local textLabel = Instance.new('TextLabel')
			textLabel.Text = plateConfig.textLabel
			textLabel.Size = UDim2.new(1, 0, 1, 0)
			textLabel.BackgroundTransparency = 1
			textLabel.TextColor3 = Color3.new(1,1,1)
			textLabel.TextScaled = false
			textLabel.TextSize = 40
			textLabel.Parent = billboardGui
			return textLabel
		end
		

		plateModel:SetAttribute('Team', team.name)
		plateModel.Name = plateConfig.plateName
		plateModel.Parent = baseplate.Parent
		plateModel.Anchored = true
		plateConfig.spawned = true

		local baseplatePart = baseplate.BaseplateBuild

		local offsetY = PlacementUtils.offsetY(baseplate, plateModel)
		plateModel:PivotTo(offsetY * plateConfig.position)

		local billboardGui = plateBillboardGui(plateModel)
		plateTextLabel(plateConfig, billboardGui)
		
		return plateModel
	end
	
	local function plateTouch(otherPart, plateConfig, plateModel, plateId, players)

		local function getPlayerTouched(otherPart)
			local character = otherPart:FindFirstAncestorOfClass("Model")
			local playerTouched = character and Players:GetPlayerFromCharacter(character)
			return playerTouched
		end

		local function checkUserId(players, playerTouched)
			for _, player in pairs(players) do
				if player.UserId == playerTouched.UserId then
					return true
				end
			end
		end

		local function purchase(playerTouched)
			local leaderstats = playerTouched:WaitForChild('leaderstats')
			
			if leaderstats then
				local balance = leaderstats:WaitForChild('Coins').Value

				if balance >= plateConfig.targetPrice then
					CoinsUtils.removeCoins(playerTouched, plateConfig.targetPrice)
					return true
				else
					print('Pas assez ! '.. plateConfig.targetPrice - balance)
					return
				end	
			end
		end


		local playerTouched = getPlayerTouched(otherPart)
		
		if playerTouched then
			if checkUserId(players, playerTouched) then
				
				if not purchase(playerTouched) then return end
				targetSelect(plateConfig, plateId, baseplate, team)

				plateConfig.destroyed = true
				plateModel:Destroy()
				
				Router.execute(script.Name, {
					module = 'PlatesOrder', 
					func = 'nextPlate', 
					args = {plateId, baseplate, team}, 
					argsReq = true
				})
			end
		end
	end
	
	local player = team.players
	local plateConfig = platesList[plateId]
	local plateModel
	
	if not plateConfig.spawned and not plateConfig.destroyed then
		plateModel = plateCreation(plateConfig)
	end
	if plateModel then
		local touchedLock = false
		
		plateModel.Touched:Connect(function(otherPart)
			if touchedLock then return end
			touchedLock = true
			
			local success, err = pcall(function()
				plateTouch(otherPart, plateConfig, plateModel, plateId, player)
			end)
			
			if not success then
				warn(err)
			end
			touchedLock = false
		end) 
	end
	
	
end


return plates
