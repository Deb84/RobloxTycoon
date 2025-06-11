local ServerScriptService = game:GetService('ServerScriptService')
local Router = require(ServerScriptService.ModuleRouter.ModuleRouter)
Router.modulesInit(script.Name, 'ModuleList')
local teamsList, InstanceRegistry, modulesList = Router.getModules(script.Name, {'TeamsList', 'InstanceRegistry', 'ModuleList'})
local TeamsHandler = {}





function TeamsHandler.teamsInit(team)
	
	local function folderInit(team)
		
		-- Workspace
		if not workspace:WaitForChild('Teams'):FindFirstChild(team.name) then
			local teamFolder = Instance.new('Folder')
			
			teamFolder.Name = team.name
			teamFolder.Parent = workspace.Teams
			InstanceRegistry.addPathTo('TeamsWorkspaceFolder', {'Teams', team.name}, teamFolder)
			
		end

		if not workspace:WaitForChild('Teams'):WaitForChild(team.name):FindFirstChild('DroppedParts') then
			local droppedPartsFolder = Instance.new('Folder')

			droppedPartsFolder:SetAttribute('Team', team.name)
			droppedPartsFolder.Name = 'DroppedParts'
			droppedPartsFolder.Parent = workspace:WaitForChild('Teams'):WaitForChild(team.name)
			InstanceRegistry.addPathTo('DroppedParts', {'Teams', team.name}, droppedPartsFolder)
		end
		
		-- ServerScriptService
		if not ServerScriptService:WaitForChild('Game'):WaitForChild('Teams'):FindFirstChild(team.name) then
			local teamFolder = Instance.new('Folder')

			teamFolder.Name = team.name
			teamFolder.Parent = ServerScriptService.Game.Teams
			InstanceRegistry.addPathTo('TeamSSSFolder', {'Teams', team.name}, teamFolder)
		end
	end
	
	local function pathUtilsInit(team)
		InstanceRegistry.addTableTo(team.name, 'Teams')
	end
	
	local function listInit(team)
		local lists = modulesList.teamsLists
		for _, list in pairs(lists) do
			local newList = list:Clone()
			newList.Parent = InstanceRegistry.getPath('TeamSSSFolder', {'Teams', team.name})
			InstanceRegistry.addPathTo(newList.name, {'Teams', team.name}, newList)
		end
	end
	
	pathUtilsInit(team)
	folderInit(team)
	listInit(team)
	print(InstanceRegistry.getPaths())
	return true
end

function TeamsHandler.AddPlayer(player, team)
	local team = teamsList[team.name]
	if not team then return end
	team.players[player.UserId] = player
end

function TeamsHandler.RemovePlayer(player)
	for _, team in pairs(teamsList) do
		team.players[player.UserId] = nil
	end
end


function TeamsHandler.GetPlayerTeams(player)
	local playerTeams = {}
	for _, team in pairs(teamsList) do
		if team.players[player.UserId] then
			table.insert(playerTeams, team)
		end
	end
end


function TeamsHandler.getTeams()
	return teamsList
end

function TeamsHandler.getTeam(teamName)
	return teamsList[teamName]
end


return TeamsHandler
