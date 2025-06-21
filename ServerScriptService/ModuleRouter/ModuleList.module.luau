SSS = game:GetService('ServerScriptService')
local ModulesList = {}

ModulesList.ModuleMap = {}

ModulesList.orderedList = {
	Init = {
		ServerStart = {
			FoldersInit = SSS.Init.ServerStart.FoldersInit

		}
	},
	Leaderboard = {
		CoinsUtils = SSS.Leaderboard.CoinsUtils
	},
	Logs = {
		Messages = {
			Error = SSS.Logs.Messages.Error,
			Warn = SSS.Logs.Messages.Warn,
			Info = SSS.Logs.Messages.Info
		},
		ErrorHandler = SSS.Logs.ErrorHandler,
		LogsMessagesManager = SSS.Logs.LogsMessagesManager
	},
	ModuleRouter = {
		ModuleList = script,
		ModuleRouter = {
			ModuleRouter = SSS.ModuleRouter.ModuleRouter,
			ModuleExecutor = SSS.ModuleRouter.ModuleRouter.ModuleExecutor,
			ModuleInitializer = SSS.ModuleRouter.ModuleRouter.ModuleInitializer,
			ModuleRegistry = SSS.ModuleRouter.ModuleRouter.ModuleRegistry
		}
	},
	PlayersHandler = {
		
	},
	Teams = {
		TeamsHandler = {
			TeamsHandler = SSS.Teams.TeamsHandler,
			TeamsInit = {
				TeamsInit = SSS.Teams.TeamsHandler.TeamsInit,
				InstanceRegistryTeamsInit = SSS.Teams.TeamsHandler.TeamsInit.InstanceRegistryTeamsInit,
				StartPlates = SSS.Teams.TeamsHandler.TeamsInit.StartPlates,
				TeamsFoldersInit = SSS.Teams.TeamsHandler.TeamsInit.TeamsFoldersInit,
				TeamsListsInit = SSS.Teams.TeamsHandler.TeamsInit.TeamsListsInit
			}
		},
		TeamsList = SSS.Teams.TeamsList
	},
	Tycoon = {
		BuildParts = {
			BuildParts = SSS.Tycoon.BuildParts.BuildParts,
			BuildPartsList = SSS.Tycoon.BuildParts.BuildPartsList
		},
		BuyingPlates = {
			Plates = SSS.Tycoon.BuyingPlates.Plates,
			PlatesList = SSS.Tycoon.BuyingPlates.PlatesList,
			PlatesOrder = SSS.Tycoon.BuyingPlates.PlatesOrder,
			PlatesOrderList = SSS.Tycoon.BuyingPlates.PlatesOrderList
		},
		Conveyors = {
			Belt = SSS.Tycoon.Conveyors.Belt,
			Conveyors = SSS.Tycoon.Conveyors.Conveyors,
			ConveyorsList = SSS.Tycoon.Conveyors.ConveyorsList,
			Destroyer = SSS.Tycoon.Conveyors.Destroyer
		},
		Droppers = {
			Droppers = SSS.Tycoon.Droppers.Droppers,
			DroppersList = SSS.Tycoon.Droppers.DroppersList
		},
		Start = {
			StartPlatesList = SSS.Tycoon.Start.StartPlatesList
		}
	},
	Utils = {
		AsyncManager = SSS.Utils.AsyncManager,
		InstanceRegistry = SSS.Utils.InstanceRegistry,
		PlacementUtils = SSS.Utils.PlacementUtils,
	}
	
}

-- init
-- vérifier que tout les path sont bons
-- Mettre tout les modules dans une grande liste globale (vérifier les nom doubles)



return ModulesList
