ServerScriptService = game:GetService('ServerScriptService')
local ModulesList = {}

-- Globals lists
ModulesList.modulesLists = {
	TeamsList = ServerScriptService.Teams.TeamsList,
	StartPlatesList = ServerScriptService.Tycoon.Start.StartPlatesList,
	
	ModuleList = script
}

-- Teams Lists, relative to a team
ModulesList.teamsLists = {
	ConveyorsList = ServerScriptService.Tycoon.Conveyors.ConveyorsList,
	DroppersList = ServerScriptService.Tycoon.Droppers.DroppersList,
	PlatesList = ServerScriptService.Tycoon.BuyingPlates.PlatesList
}


ModulesList.moduleInit = {
	FoldersInit = ServerScriptService.Init.ServerStart.FoldersInit,
	TeamsInit = ServerScriptService.Teams.TeamsHandler.TeamsInit,
	TeamsFoldersInit = ServerScriptService.Teams.TeamsHandler.TeamsInit.TeamsFoldersInit,
	InstanceRegistryTeamsInit = ServerScriptService.Teams.TeamsHandler.TeamsInit.InstanceRegistryTeamsInit,
	TeamsListsInit = ServerScriptService.Teams.TeamsHandler.TeamsInit.TeamsListsInit
}


-- Managers
ModulesList.modulesManagers = {
	ModuleRouter = ServerScriptService.ModuleRouter.ModuleRouter,
	PlatesOrder = ServerScriptService.Tycoon.BuyingPlates.PlatesOrder,
	TeamsHandler = ServerScriptService.Teams.TeamsHandler
}

-- Utils
ModulesList.modulesUtils = {
	CoinsUtils = ServerScriptService.Leaderboard.CoinsUtils,
	InstanceRegistry = ServerScriptService.Utils.InstanceRegistry,
	PlacementUtils = ServerScriptService.Utils.PlacementUtils
}

-- Parts
ModulesList.modulesParts = {
	StartPlates = ServerScriptService.Teams.TeamsHandler.TeamsInit.StartPlates,
	Droppers = ServerScriptService.Tycoon.Droppers.Droppers,
	Plates = ServerScriptService.Tycoon.BuyingPlates.Plates,
	Conveyors = ServerScriptService.Tycoon.Conveyors.Conveyors,
	BuildParts = ServerScriptService.Tycoon.BuildParts.BuildParts,
}

ModulesList.moduleLogs = {
	ErrorHandler = ServerScriptService.Logs.ErrorHandler,
	Errors = ServerScriptService.Logs.Messages.Errors,
	Warns = ServerScriptService.Logs.Messages.Warns
}

ModulesList.map = {
	ConveyorsList = ModulesList.teamsLists,
	PlatesList = ModulesList.teamsLists,
	DroppersList = ModulesList.teamsLists,
	
	FoldersInit = ModulesList.moduleInit,
	TeamsInit = ModulesList.moduleInit,
	TeamsFoldersInit = ModulesList.moduleInit,
	InstanceRegistryTeamsInit = ModulesList.moduleInit,
	TeamsListsInit = ModulesList.moduleInit,
	
	TeamsList = ModulesList.modulesLists,
	StartPlatesList = ModulesList.modulesLists,
	ModuleList = ModulesList.modulesLists,
	
	ModuleRouter = ModulesList.modulesManagers,
	PlatesOrder = ModulesList.modulesManagers,
	TeamsHandler = ModulesList.modulesManagers,
	
	CoinsUtils = ModulesList.modulesUtils,
	InstanceRegistry = ModulesList.modulesUtils,
	PlacementUtils = ModulesList.modulesUtils,
	
	StartPlates = ModulesList.modulesParts,
	Droppers = ModulesList.modulesParts,
	Plates = ModulesList.modulesParts,
	Conveyors = ModulesList.modulesParts,
	BuildParts = ModulesList.modulesParts,
	
	ErrorHandler = ModulesList.moduleLogs,
	Errors = ModulesList.moduleLogs,
	Warns = ModulesList.moduleLogs
}


function ModulesList.getModulePath(moduleName)
	if not ModulesList.map[moduleName] then
		error()
	end
	
	local mapPath = ModulesList.map[moduleName]
	if not mapPath[moduleName] then
		error()
	end
	return mapPath[moduleName]
end

return ModulesList
