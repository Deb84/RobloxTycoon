local ServerScriptService = game:GetService('ServerScriptService')
local ModuleList = require(ServerScriptService.ModuleRouter.ModuleList)
local Router = require(ModuleList.getModulePath('ModuleRouter'))
local InstanceRegistry = Router.getModule(script.Name, 'InstanceRegistry')

local FolderInit = {}

function FolderInit.GameScriptFolderInit()
	local gameFolder = Instance.new('Folder')
	gameFolder.Name = 'Game'
	gameFolder.Parent = ServerScriptService
	InstanceRegistry.addPath('GameSSSFolder', gameFolder)
	
	if not ServerScriptService:FindFirstChild('Game') then
		error()
	end

	local teamsFolder = Instance.new('Folder')
	teamsFolder.Name = 'Teams'
	teamsFolder.Parent = ServerScriptService.Game
	InstanceRegistry.addPath('TeamsSSSFolder', teamsFolder)
	
	if not ServerScriptService.Game:FindFirstChild('Teams') then
		error()
	end
end

function FolderInit.TeamsWorkspaceFolder()
	if not workspace:FindFirstChild('Teams') then
		local teamsFolder = Instance.new('Folder')
		teamsFolder.Name = 'Teams'
		teamsFolder.Parent = workspace
	end
	if not workspace:FindFirstChild('Teams') then
		error()
	end
end


return FolderInit
