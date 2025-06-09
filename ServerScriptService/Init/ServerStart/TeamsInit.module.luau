local ServerScriptService = game:GetService('ServerScriptService')
local ModuleList = require(ServerScriptService.ModuleRouter.ModuleList)
local Router = require(ModuleList.getModulePath('ModuleRouter'))
local Teamslist, TeamsHandler, StartPlatesList, InstanceRegistry = Router.getModules(
	script.Name, {
	'TeamsList', 
	'TeamsHandler', 
	'StartPlatesList', 
	'InstanceRegistry'
})

local TeamsInit = {}




local function teamsInit(team)
	
	local function teamTeam(team)
		if not team then
			error()
		elseif type(team) ~= 'table' then
			error()
		end
		-- TO CONTINUE, BASED ON MODULE EXECUTOR CHECKMSG ARCH
	end
	
	local function teamLeaderboard(player, team) -- Update the player's leaderboar
		local leaderstats = player:WaitForChild('leaderstats')
		local leaderboardTeam = leaderstats:WaitForChild('Team')
		leaderboardTeam.Value = team.displayedName
	end
	
	local function spawnBaseplate(team)
		local baseplate = team.baseplateModel:Clone()
	end
	
	
	
	
	
	for _, team in pairs(Teamslist) do
		TeamsHandler.teamsInit(team) -- TODO add an error on the function side
		
		
		
		
		
	end
end
