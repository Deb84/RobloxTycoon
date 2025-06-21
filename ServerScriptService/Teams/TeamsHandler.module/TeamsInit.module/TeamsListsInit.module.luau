local SSS = game:GetService('ServerScriptService')
local MLM = require(SSS.ModuleRouter.ModuleListManager)
local Router = require(MLM.getModulePath('ModuleRouter'))
local InstanceRegistry = Router.getModule(script.Name, 'InstanceRegistry')

local TeamsListsInit = {}

function TeamsListsInit.teamListsInit(teamName)
	-- Create a table with list in teams list (create a global settings teams)
	--local lists = ModuleList.teamsLists
	--for _, list in pairs(lists) do
	--	local newList = list:Clone()
	--	newList.Parent = InstanceRegistry.getPath('TeamSSSFolder', {'Teams', teamName})
	--	InstanceRegistry.addPathTo(newList.name, {'Teams', teamName}, newList)
	--end
end

return TeamsListsInit
