local ServerScriptService = game:GetService('ServerScriptService')
local ModuleList = require(ServerScriptService.ModuleRouter.ModuleList)
local InstanceRegistry = require(ModuleList.getModulePath('InstanceRegistry'))

local FolderInit = {}

function FolderInit.GameScriptFolderInit()
	local gameFolder = Instance.new('Folder')
	gameFolder.Name = 'Game'
	gameFolder.Parent = ServerScriptService
	InstanceRegistry.addPath('GameSSSFolder', gameFolder)
	

	local teamsFolder = Instance.new('Folder')
	teamsFolder.Name = 'Teams'
	teamsFolder.Parent = ServerScriptService.Game
	InstanceRegistry.addPath('TeamsSSSFolder', teamsFolder)
	
end

function FolderInit.TeamsWorkspaceFolder()
	if not workspace:FindFirstChild('Teams') then
		local teamsFolder = Instance.new('Folder')
		teamsFolder.Name = 'Teams'
		teamsFolder.Parent = workspace
	end
	
end


return FolderInit
