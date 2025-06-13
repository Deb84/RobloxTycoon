local SSS = game:GetService('ServerScriptService')
local ModuleList = require(SSS.ModuleRouter.ModuleList)
local Router = require(ModuleList.getModulePath('ModuleRouter'))
local InstanceRegistry = Router.getModule(script.Name, 'InstanceRegistry')

local TeamsListsInit = {}

function TeamsListsInit.teamListsInit(teamName)
	local lists = ModuleList.teamsLists
	for _, list in pairs(lists) do
		local newList = list:Clone()
		newList.Parent = InstanceRegistry.getPath('TeamSSSFolder', {'Teams', teamName})
		InstanceRegistry.addPathTo(newList.name, {'Teams', teamName}, newList)
	end
end

return TeamsListsInit
