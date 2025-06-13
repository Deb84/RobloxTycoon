local ServerScriptService = game:GetService('ServerScriptService')
local Router = require(ServerScriptService.ModuleRouter.ModuleRouter)
Router.modulesInit(script.Name, 'ModuleList')
local teamsList, InstanceRegistry, modulesList = Router.getModules(script.Name, {'TeamsList', 'InstanceRegistry', 'ModuleList'})
local TeamsInit = require(modulesList.getModulePath('TeamsInit'))

local TeamsHandler = {}


-- TODO add team list and team verification

function TeamsHandler.teamsInit(teamList)
	
	TeamsInit.teamsInit(teamList)
	
end

function TeamsHandler.AddPlayer(player, team)
	print(team)
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
