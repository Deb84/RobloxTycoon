ServerScriptService = game:GetService('ServerScriptService')
local ModulesList = {}

-- Globals lists
ModulesList.modulesLists = {
	TeamsList = ServerScriptService.Teams.TeamsList,
	
	ModuleList = script
}

-- Teams Lists, relative to a team
ModulesList.teamsLists = {
	ConveyorsList = ServerScriptService.Tycoon.Conveyors.ConveyorsList,
	DroppersList = ServerScriptService.Tycoon.Droppers.DroppersList,
	PlatesList = ServerScriptService.Tycoon.BuyingPlates.PlatesList,
	StartPlatesList = ServerScriptService.Tycoon.Start.StartPlatesList,
}


-- Managers
ModulesList.modulesManagers = {
	PlatesOrder = ServerScriptService.Tycoon.BuyingPlates.PlatesOrder,
	TeamsHandler = ServerScriptService.Teams.TeamsHandler
}

-- Utils
ModulesList.modulesUtils = {
	CoinsUtils = ServerScriptService.Leaderboard.CoinsUtils,
	PathUtils = ServerScriptService.Utils.PathUtils,
	PlacementUtils = ServerScriptService.Utils.PlacementUtils
}

-- Parts
ModulesList.modulesParts = {
	Droppers = ServerScriptService.Tycoon.Droppers.Droppers,
	Plates = ServerScriptService.Tycoon.BuyingPlates.Plates,
	Conveyors = ServerScriptService.Tycoon.Conveyors.Conveyors,
	BuildParts = ServerScriptService.Tycoon.BuildParts.BuildParts,
}

ModulesList.map = {
	ConveyorsList = ModulesList.teamsLists,
	PlatesList = ModulesList.teamsLists,
	StartPlatesList = ModulesList.teamsLists,
	DroppersList = ModulesList.teamsLists,
	
	TeamsList = ModulesList.modulesLists,
	ModuleList = ModulesList.modulesLists,
	
	PlatesOrder = ModulesList.modulesManagers,
	TeamsHandler = ModulesList.modulesManagers,
	
	CoinsUtils = ModulesList.modulesUtils,
	PathUtils = ModulesList.modulesUtils,
	PlacementUtils = ModulesList.modulesUtils,
	
	Droppers = ModulesList.modulesParts,
	Plates = ModulesList.modulesParts,
	Conveyors = ModulesList.modulesParts,
	BuildParts = ModulesList.modulesParts
}

return ModulesList
