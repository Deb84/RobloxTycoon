local SSS = game:GetService('ServerScriptService')
local MLM = require(SSS.ModuleRouter.ModuleListManager)
local Router = require(MLM.getModulePath('ModuleRouter'))
local InstanceRegistry = Router.getModule(script.Name, 'InstanceRegistry')

local InstanceRegistryTeamsInit = {}

function InstanceRegistryTeamsInit.InstanceRegistryAddTeamsTable(teamName)
	InstanceRegistry.addTableTo(teamName, 'Teams')
end

return InstanceRegistryTeamsInit
