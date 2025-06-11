local ServerScriptService = game:GetService('ServerScriptService')

local function getModuleList()
	local success, result = pcall(function()
		local moduleListPath = ServerScriptService.ModuleRouter.ModuleList
		local ModuleList = require(moduleListPath)
		return ModuleList
	end)
	if not success then print(result) end
	return result
end

local ModuleList = getModuleList()
assert(ModuleList)

local ModuleAssertion = require(ServerScriptService.Init.ServerStart.ModuleAssertion)
assert(ModuleAssertion and ModuleAssertion.ModuleAssertion)

local Router = require(ModuleList.getModulePath('ModuleRouter'))

Router.modulesInit(script.Name, 'InstanceRegistry')

local FolderInit = require(script:FindFirstChild('FolderInit'))

Router.modulesInit(script.Name, {'StartPlatesList', 'TeamsList'})

local TeamsInit = require(script:FindFirstChild('TeamsInit'))




FolderInit.GameScriptFolderInit()
FolderInit.TeamsWorkspaceFolder()
TeamsInit.teamsInit()







