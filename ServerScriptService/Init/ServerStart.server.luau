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

local Router = require(ModuleList.getModulePath('ModuleRouter'))
assert(Router)

Router.modulesInit(script.Name, 'InstanceRegistry')

local FolderInit = require(script:FindFirstChild('FolderInit'))
assert(FolderInit)

Router.modulesInit(script.Name, {'StartPlatesList', 'TeamsList', 'TeamsHandler'})




FolderInit.GameScriptFolderInit()
FolderInit.TeamsWorkspaceFolder()




