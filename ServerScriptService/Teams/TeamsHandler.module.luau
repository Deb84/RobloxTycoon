local ServerScriptService = game:GetService('ServerScriptService')
local Router = require(ServerScriptService.Utils.ModuleRouter)
local teamsList, PathUtils = Router.getModules(script.Name, 'TeamsList', 'PathUtils')
local TeamsHandler = {}





function TeamsHandler.teamsInit(team)
	
	local function folderInit(team)
		
		-- Workspace
		if not workspace:WaitForChild('Teams'):FindFirstChild(team.name) then
			local teamFolder = Instance.new('Folder')
			
			teamFolder.Name = team.name
			teamFolder.Parent = workspace.Teams
			PathUtils.addPathTo('TeamsWorkspaceFolder', {'Teams', team.name}, teamFolder)
			
		end

		if not workspace:WaitForChild('Teams'):WaitForChild(team.name):FindFirstChild('DroppedParts') then
			local droppedPartsFolder = Instance.new('Folder')

			droppedPartsFolder:SetAttribute('Team', team.name)
			droppedPartsFolder.Name = 'DroppedParts'
			droppedPartsFolder.Parent = workspace:WaitForChild('Teams'):WaitForChild(team.name)
			PathUtils.addPathTo('DroppedParts', {'Teams', team.name}, droppedPartsFolder)
		end
		
		-- ServerScriptService
		if not ServerScriptService:WaitForChild('Game'):WaitForChild('Teams'):FindFirstChild(team.name) then
			local teamFolder = Instance.new('Folder')

			teamFolder.Name = team.name
			teamFolder.Parent = ServerScriptService.Game.Teams
			PathUtils.addPathTo('TeamSSSFolder', {'Teams', team.name}, teamFolder)
		end
	end
	
	local function pathUtilsInit(team)
		PathUtils.addTableTo(team.name, 'Teams')
	end
	
	local function listInit(team)
		local modulesList = Router.getModules(script.Name, 'ModulesList')
		local lists = modulesList.teamsLists
		for _, list in pairs(lists) do
			local newList = list:Clone()
			newList.Parent = PathUtils.getPath('TeamSSSFolder', {'Teams', team.name})
			PathUtils.addPathTo(newList.name, {'Teams', team.name}, newList)
		end
	end
	pathUtilsInit(team)
	folderInit(team)
	listInit(team)
	print(PathUtils.getPaths())
	return true
end

function TeamsHandler.AddPlayer(player, team)
	print(team.name)
	print(player.UserId)
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
