local ServerScriptService = game:GetService('ServerScriptService')
local Registry = require(script:FindFirstChild('ModuleRegistry'))
local Executor = require(script:FindFirstChild('ModuleExecutor'))
local Initializer = require(script:FindFirstChild('ModuleInitializer'))
local ErrorHandler = require(ServerScriptService.Logs.ErrorHandler)
local moduleRouter = {}



-- For the recursive imports
function moduleRouter.modulesInit(caller, moduleNames)
	local success, result = xpcall(function()
		return Initializer.modulesInit(caller, moduleNames)
	end, ErrorHandler.warnHandler)
	if success then
		return result
	end
end


-- Allow to execute a module from this module
function moduleRouter.execute(caller, message)
	local success, result = xpcall(function()
		return Executor.execute(caller, message)
	end, ErrorHandler.warnHandler)
	if success then
		print('sucess: '..message.module)
		return result
	end
end


-- Classic module utils
function moduleRouter.addModule(caller, moduleName, module)
	local success, result = xpcall(function()
		Registry.addModule(caller, moduleName, module)
	end, ErrorHandler.warnHandler)
end

function moduleRouter.removeModule(caller, moduleName)
	local success, result = xpcall(function()
		Registry.removeModule(caller, moduleName)
	end, ErrorHandler.warnHandler)
end

function moduleRouter.getModule(caller, moduleName)
	local success, result = xpcall(function()
		return Registry.getModule(caller, moduleName)
	end, ErrorHandler.warnHandler)
	if success then
		return result
	end
end

function moduleRouter.getModules(caller, modulesNames)
	local success, result = xpcall(function()
		return Registry.getModules(caller, modulesNames)
	end, ErrorHandler.warnHandler)
	if success then
		return table.unpack(result)
	end
end

function moduleRouter.getModulesAndInit(caller, moduleNames)
	caller = {script.Name, caller}
	
	local success, result = xpcall(function()
		if moduleRouter.modulesInit(caller, moduleNames) then
			return Registry.getModules(caller, moduleNames)
		end
	end, ErrorHandler.warnHandler)
	if success then
		return table.unpack(result)
	end
end



return moduleRouter
