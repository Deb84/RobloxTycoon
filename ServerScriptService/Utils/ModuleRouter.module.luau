local Registery = require(script:FindFirstChild('ModuleRegistery'))
local Executer = require(script:FindFirstChild('ModuleExecuter'))
local Initializer = require(script:FindFirstChild('ModuleInitializer'))
local ErrorHandler = require(script.Parent:FindFirstChild('ErrorHandler'))
local moduleRouter = {}



-- For the recursive imports
function moduleRouter.modulesInit(caller, moduleNames)
	local success, result = xpcall(function()
		return Initializer.modulesInit(caller, moduleNames)
	end, ErrorHandler.warnHandler)
end


-- Allow to execute a module from this module
function moduleRouter.execute(caller, message)
	local success, result = xpcall(function()
		return Executer.execute(caller, message)
	end, ErrorHandler.warnHandler)
end


-- Classic module utils
function moduleRouter.addModule(caller, moduleName, module)
	local success, result = xpcall(function()
		Registery.addModule(caller, moduleName, module)
	end, ErrorHandler.warnHandler)
end

function moduleRouter.removeModule(caller, moduleName)
	local success, result = xpcall(function()
		Registery.removeModule(caller, moduleName)
	end, ErrorHandler.warnHandler)
end

function moduleRouter.getModule(caller, moduleName)
	local success, result = xpcall(function()
		return Registery.getModule(caller, moduleName)
	end, ErrorHandler.warnHandler)
end

function moduleRouter.getModules(caller, modulesNames)
	local success, result = xpcall(function()
		return Registery.getModules(caller, modulesNames)
	end, ErrorHandler.warnHandler)
end

function moduleRouter.getModulesAndInit(caller, moduleNames)
	caller = string.format('%s in %s via function:getModulesAndInit', caller, script.Name)
	
	local success, result = xpcall(function()
		if moduleRouter.modulesInit(caller, moduleNames) then
			return Registery.getModules(caller, moduleNames)
		end
	end, ErrorHandler.warnHandler)
end



return moduleRouter
