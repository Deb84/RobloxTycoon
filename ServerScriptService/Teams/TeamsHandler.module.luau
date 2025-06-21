local ServerScriptService = game:GetService('ServerScriptService')
local MLM = require(ServerScriptService.ModuleRouter.ModuleListManager)
local Router = require(MLM.getModulePath('ModuleRouter'))
local teamsList, InstanceRegistry = Router.getModules(script.Name, {'TeamsList', 'InstanceRegistry'})
local TeamsInit = Router.getModulesAndInit(script.Name, 'TeamsInit')

local TeamsHandler = {}


-- TODO add team list and team verification

function TeamsHandler.teamsInit(teamList)
	print(teamsList)
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
