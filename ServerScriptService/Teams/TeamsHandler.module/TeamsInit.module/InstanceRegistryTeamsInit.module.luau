local SSS = game:GetService('ServerScriptService')
local ModuleList = require(SSS.ModuleRouter.ModuleList)
local Router = require(ModuleList.getModulePath('ModuleRouter'))
local InstanceRegistry = Router.getModule(script.Name, 'InstanceRegistry')

local InstanceRegistryTeamsInit = {}

function InstanceRegistryTeamsInit.InstanceRegistryAddTeamsTable(teamName)
	InstanceRegistry.addTableTo(teamName, 'Teams')
end

return InstanceRegistryTeamsInit
