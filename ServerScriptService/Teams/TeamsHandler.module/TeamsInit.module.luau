local SSS = game:GetService('ServerScriptService')
local MLM = require(SSS.ModuleRouter.ModuleListManager)
local Router = require(MLM.getModulePath('ModuleRouter'))
local StartPlates = Router.getModulesAndInit(script.Name, 'StartPlates')
local LogsMsg = require(SSS.Logs.LogsMessagesManager)

local TeamsInit = {}


-- TODO
local Teamslist, InstanceRegistry = Router.getModules(script.Name, {'TeamsList','InstanceRegistry'})
local InstanceRegistryTeamsInit = Router.getModulesAndInit(script.Name, 'InstanceRegistryTeamsInit')
local TeamsFoldersInit = Router.getModulesAndInit(script.Name, 'TeamsFoldersInit')
local TeamsListsInit = Router.getModulesAndInit(script.Name, 'TeamsListsInit')


function TeamsInit.teamsInit(teamList)
	
	local function checkTeam(team)
		assert(team)
		assert(typeof(team) == 'table')
		assert(typeof(team.name) == 'string')
		assert(typeof(team.displayedName) == 'string')
		assert(typeof(team.defaultCoinsValue) == 'number')
		assert(typeof(team.coins) == 'number')
		assert(typeof(team.color3) == 'Color3')
		assert(typeof(team.brickColor) == 'BrickColor')
		assert(team.baseplateModel:IsA('Model'))
		assert(typeof(team.baseplatePos) == 'CFrame')
	end
	
	
	local function spawnBaseplate(team)
		local baseplate = team.baseplateModel:Clone()
		
		baseplate:PivotTo(team.baseplatePos)
		baseplate:SetAttribute('Team', team.name)
		
		for _, part in baseplate:GetChildren() do
			part:SetAttribute('Team', team.name)
			part.Anchored = true
		end
		
		baseplate.Parent = workspace:WaitForChild('Teams'):WaitForChild(team.name)	-- Set the parent as the team folder in workspace.Teams (existence already checked by FolderInit)
		
		return baseplate
	end
	
	
	for _, team in pairs(Teamslist) do
		checkTeam(team)
		
		InstanceRegistryTeamsInit.InstanceRegistryAddTeamsTable(team.name)
		TeamsListsInit.teamListsInit(team.name)
		TeamsFoldersInit.TeamsFoldersInit(team.name)
		
		local baseplate = spawnBaseplate(team)
		
		Router.execute(script.Name, {module = 'StartPlates', func = 'spawnStartPlate', args = {baseplate, team}, argsReq = true, async = true})
		
	end
end




return TeamsInit
