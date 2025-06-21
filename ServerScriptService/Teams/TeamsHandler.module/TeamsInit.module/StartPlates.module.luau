local SSS = game:GetService('ServerScriptService')
local Players = game:GetService('Players')
local MLM = require(SSS.ModuleRouter.ModuleListManager)
local Router = require(MLM.getModulePath('ModuleRouter'))
local StartPlatesList, PlacementUtils = Router.getModulesAndInit(script.Name, {'StartPlatesList', 'PlacementUtils'})
local LogsMsg = require(SSS.Logs.LogsMessagesManager)


local StartPlates = {}

function StartPlates.spawnStartPlate(baseplate, team)
	print(team)
	local errorLoc = string.format('%s[spawnStartPlate]', script.Name)
	
	local function checkStartPlatesList()
		assert(StartPlatesList, LogsMsg.get('Error', 'SP_NO_STARTPLATESLIST', errorLoc))
		assert(type(StartPlatesList) == 'table', LogsMsg.get('Error', 'SP_STARTPLATESLIST_ISNT_TABLE', errorLoc))
	end
	
	local function checkAndGetTeamStartPlate(teamName)
		assert(StartPlatesList[teamName])
		local teamStartPlate = StartPlatesList[teamName]
		
		assert(type(teamStartPlate) == 'table', LogsMsg.get('Error', 'SP_TEAMSTARTPLATE_ISNT_TABLE', errorLoc))
		assert(next(teamStartPlate), LogsMsg.get('Error', 'SP_TEAMSTARTPLATE_EMPTY', errorLoc))
		assert(teamStartPlate.model:IsA('Model'), LogsMsg.get('Error', 'SP_MODEL', errorLoc))
		assert(teamStartPlate.model.PrimaryPart:IsA('BasePart'), LogsMsg.get('Error', 'SP_PRIMARY', errorLoc))
		assert(typeof(teamStartPlate.color) == 'Color3', LogsMsg.get('Error', 'SP_COLOR', errorLoc))
		assert(type(teamStartPlate.transparency) == 'number', LogsMsg.get('Error', 'SP_TRANSPARENCY', errorLoc))
		assert(type(teamStartPlate.newTransparency) == 'number', LogsMsg.get('Error', 'SP_TRANSPARENCY2', errorLoc))
		assert(typeof(teamStartPlate.position) == 'CFrame', LogsMsg.get('Error', 'SP_POSITION', errorLoc))
		assert(type(teamStartPlate.spawned) == 'boolean', LogsMsg.get('Error', 'SP_SPAWNED', errorLoc)) -- fallback possible
		assert(type(teamStartPlate.rebounce) == 'boolean', LogsMsg.get('Error', 'SP_REBOUNCE', errorLoc)) -- fallback possible
		
		return teamStartPlate
	end
	
	
	
	local function setStartPlates(teamStartPlate)
		local startPlate = teamStartPlate.model:Clone()
		
		local startPlatePart = startPlate.PrimaryPart
		
		startPlatePart:SetAttribute('Team', team.name)
		startPlatePart.Transparency = teamStartPlate.transparency
		startPlatePart.Color = teamStartPlate.color
		startPlatePart.Anchored = true
		
		
		local offsetY = PlacementUtils.offsetY(baseplate, startPlate)
		startPlate:PivotTo(offsetY * teamStartPlate.position)
		
		startPlate.Parent = baseplate
		
		return startPlate
	end
	
	
	local function startPlateTouched(otherPart, team, startPlate, teamStartPlate, event)
		
		local function teamLeaderboard(player, team) -- Update the player's leaderboar
			local leaderstats = player:WaitForChild('leaderstats')
			local leaderboardTeam = leaderstats:WaitForChild('Team')
			leaderboardTeam.Value = team.displayedName
		end

		local function getPlayer(otherPart)
			local character = otherPart:FindFirstAncestorOfClass("Model")
			local player = character and Players:GetPlayerFromCharacter(character)
			if player  then
				return player
			end
		end

		local player = getPlayer(otherPart)
		
		if player then
			teamLeaderboard(player, team)
			
			startPlate.PrimaryPart.Transparency = teamStartPlate.newTransparency
			
			print(team)
			Router.execute(script.Name, {module = 'TeamsHandler', func = 'AddPlayer', args = {player, team}, argsReq = true})
			
			Router.execute(script.Name, {module = 'Plates', func = 'spawnPlate', args = {1, baseplate, team}, argsReq = true, async = true})
			
			event:Disconnect()
		else
			teamStartPlate.rebounce = false
		end
		
		
		
	end
	
	
	checkStartPlatesList()
	local teamStartPlate = checkAndGetTeamStartPlate(team.name) -- 
	local startPlate = setStartPlates(teamStartPlate)

	if not teamStartPlate.spawned then

		if startPlate then

			local event
			event = startPlate.PrimaryPart.Touched:Connect(function(otherPart)

				if not teamStartPlate.rebounce then
					teamStartPlate.rebounce = true

					local success, err = pcall(function()
						startPlateTouched(otherPart, team, startPlate, teamStartPlate, event)
					end)

					if not success then
						warn(err)
					end
					
				end
			end)
		end
	end
end


return StartPlates
