local ServerScriptService = game:GetService('ServerScriptService')
local Router = require(ServerScriptService.Utils.ModuleRouter)
local teamsList, PathUtils = Router.getModules('teamsList', 'PathUtils')
local TeamsHandler = {}





function TeamsHandler.teamsInit(team)
	
	local function folderInit(team)
		if not workspace:FindFirstChild('Teams') then
			local teamsFolder = Instance.new('Folder')
			teamsFolder.Name = 'Teams'
			teamsFolder.Parent = workspace
		end

		if not workspace:WaitForChild('Teams'):FindFirstChild(team.name) then
			local teamFolder = Instance.new('Folder')
			
			teamFolder.Name = team.name
			teamFolder.Parent = workspace:WaitForChild('Teams')
			PathUtils.addPathTo('TeamFolder', PathUtils.join('Teams', team.name), teamFolder)
		end

		if not workspace:WaitForChild('Teams'):WaitForChild(team.name):FindFirstChild('DroppedParts') then
			local droppedPartsFolder = Instance.new('Folder')

			droppedPartsFolder:SetAttribute('Team', team.name)
			droppedPartsFolder.Name = 'DroppedParts'
			droppedPartsFolder.Parent = workspace:WaitForChild('Teams'):WaitForChild(team.name)
			PathUtils.addPathTo('DroppedParts', PathUtils.join('Teams', team.name), droppedPartsFolder)
			print(PathUtils.getPaths())
		end
	end
	
	local function pathUtilsInit(team)
		PathUtils.addTableTo(team.name, PathUtils.join('Teams'))
	end
	
	local function listInit(team)
		print('v')
	end
	
	pathUtilsInit(team)
	folderInit(team)
	
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
