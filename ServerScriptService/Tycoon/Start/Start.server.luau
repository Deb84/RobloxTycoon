local ServerScriptService = game:GetService('ServerScriptService')
local Services = require(ServerScriptService.Utils.Services)
local moduleRouter = require(ServerScriptService.Utils.ModuleRouter)
local ServerStorage, Players = Services:getServices('ServerStorage', 'Players')
local startPlatesList, teamsList, PathUtils = moduleRouter.getModulesAndInit(script.name, 'StartPlatesList', 'TeamsList', 'PathUtils')
local teamsHandler = require(ServerScriptService.Teams.TeamsHandler)


local function GameScriptFolderInit()
	local gameFolder = Instance.new('Folder')
	gameFolder.Name = 'Game'
	gameFolder.Parent = ServerScriptService
	PathUtils.addPath('GameSSSFolder', gameFolder)
	
	local teamsFolder = Instance.new('Folder')
	teamsFolder.Name = 'Teams'
	teamsFolder.Parent = ServerScriptService.Game
	PathUtils.addPath('TeamsSSSFolder', teamsFolder)
end

local function TeamsWorkspaceFolder()
	if not workspace:FindFirstChild('Teams') then
		local teamsFolder = Instance.new('Folder')
		teamsFolder.Name = 'Teams'
		teamsFolder.Parent = workspace
	end
end

GameScriptFolderInit()
TeamsWorkspaceFolder()

moduleRouter.modulesInit('Plates')
local plates = moduleRouter.getModule(script.Name, 'Plates')

local function teamLeaderboard(player, team)
	local leaderstats = player:WaitForChild('leaderstats')
	local leaderboardTeam = leaderstats:WaitForChild('Team')
	leaderboardTeam.Value = team.displayedName
end


for _, team in pairs(teamsList) do
	if not teamsHandler.teamsInit(team) then 
		error('An error has occured during the team initialization [Team:'..team.name..']')
	end
	
	local baseplate = team.baseplateModel:Clone()
	
	baseplate:PivotTo(team.baseplatePos)
	baseplate:SetAttribute('Team', team.name)
	
	if baseplate:IsA('Model') then
		for _, part in baseplate:GetChildren() do
			part:SetAttribute('Team', team.name)
			part.Anchored = true
		end
	elseif baseplate:IsA('BasePart') then
		baseplate.Anchored = true
	end
	
	baseplate.Parent = workspace:WaitForChild('Teams'):WaitForChild(team.name)
	
	local teamStartPlate = startPlatesList[team.name]
	local startPlate = teamStartPlate.model:Clone()
	
	if not teamStartPlate.spawned then
		
		startPlate:SetAttribute('Team', team.name)
		startPlate.Transparency = teamStartPlate.transparency
		startPlate.Color = teamStartPlate.color
		startPlate.Anchored = true
		
		local offsetY = baseplate:GetExtentsSize().Y / 2 + startPlate.Size.Y / 2
		startPlate:PivotTo(baseplate:GetPivot() * teamStartPlate.position)
		
		startPlate.Parent = baseplate
		
		if startPlate then
			
			startPlate.Touched:Connect(function(other_part)
				
				if not teamStartPlate.rebounce then
					teamStartPlate.rebounce = true
				
					local character = other_part:FindFirstAncestorOfClass("Model")
					local player = character and Players:GetPlayerFromCharacter(character)
					
					if player then
						
						
						teamLeaderboard(player, team)
						
						startPlate.Transparency = teamStartPlate.newTransparency
						
						teamsHandler.AddPlayer(player, team)
						
						
						plates.spawnPlate(1, baseplate, team)
						
				
					end
					
				end
			end)
		end
	end
end



