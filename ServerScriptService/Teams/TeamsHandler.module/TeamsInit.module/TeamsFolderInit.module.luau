local SSS = game:GetService('ServerScriptService')
local MLM = require(SSS.ModuleRouter.ModuleListManager)
local Router = require(MLM.getModulePath('ModuleRouter'))
local InstanceRegistry = Router.getModule(script.Name, 'InstanceRegistry')
local TeamsFoldersInit = {}

function TeamsFoldersInit.TeamsFoldersInit(teamName)
	local function SSSTeamsFoldersInit(teamName)
		if not SSS.Game:FindFirstChild('Teams') then -- Create a folder "Teams" in Workspace
			
			local teamsFolder = Instance.new('Folder')
			teamsFolder.Name = 'Teams'
			teamsFolder.Parent = SSS.Game
			InstanceRegistry.addPath('TeamsSSSFolder', teamsFolder)
		end
		
		if not SSS.Game.Teams:FindFirstChild(teamName) then -- -- Create a folder for a team in ServerScriptService.Game.Teams
			local teamFolder = Instance.new('Folder')

			teamFolder:SetAttribute('Team', teamName)
			teamFolder.Name = teamName
			teamFolder.Parent = SSS.Game.Teams
			InstanceRegistry.addPathTo('SSSTeamFolder', {'Teams', teamName}, teamFolder)
		end
	end

	local function WorkspaceTeamsFoldersInit(teamName)
		if not workspace.Teams:FindFirstChild(teamName) then -- Create a folder for a team ("teamName") in Workspace.Teams
			local teamFolder = Instance.new('Folder')
			
			teamFolder:SetAttribute('Team', teamName)
			teamFolder.Name = teamName
			teamFolder.Parent = workspace.Teams
			InstanceRegistry.addPathTo('WorkspaceTeamFolder', {'Teams', teamName}, teamFolder)

		end

		if not workspace:WaitForChild('Teams'):WaitForChild(teamName):FindFirstChild('DroppedParts') then -- Create a folder DroppedParts in Workspace.Teams."TeamName"
			local droppedPartsFolder = Instance.new('Folder')

			droppedPartsFolder:SetAttribute('Team', teamName)
			droppedPartsFolder.Name = 'DroppedParts'
			droppedPartsFolder.Parent = workspace.Teams:WaitForChild(teamName)
			InstanceRegistry.addPathTo('DroppedParts', {'Teams', teamName}, droppedPartsFolder)
		end
		
	end
	
	SSSTeamsFoldersInit(teamName)
	WorkspaceTeamsFoldersInit(teamName)
	
end

return TeamsFoldersInit
