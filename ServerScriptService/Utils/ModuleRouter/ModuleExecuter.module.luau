local ServerScriptService = game:GetService('ServerScriptService')
local Registry = require(script.Parent:FindFirstChild('ModuleRegistry'))
local Initializer = require(script.Parent:FindFirstChild('ModuleInitializer'))
local ErrorMessages = require(ServerScriptService.Messages.Errors)
local WarnMessages = require(ServerScriptService.Messages.Warns)
local ModuleExecutor = {}

assert(ErrorMessages, string.format('Unable to load "Errors" [error_location=%s]', script.Name))
assert(ErrorMessages.executor, string.format('Unable to load Errors.executor [error_location=%s]', script.Name))
local moduleErrorsMsg = ErrorMessages.executor

assert(WarnMessages, string.format(moduleErrorsMsg.NO_WARNS, script.Name))
assert(WarnMessages.executor, string.format(moduleErrorsMsg.NO_WARNS_EXECUTOR, script.Name))
local moduleWarnMsg = WarnMessages.executor

assert(Registry, string.format(moduleErrorsMsg.NO_REGISTRY, script.Name))

if not Initializer then
	warn(string.format(moduleWarnMsg.NOT_INITIALIZER, script.Name))
elseif not Initializer.modulesInit then
	warn(string.format(moduleWarnMsg.NOTINITIALIZER_MODULEINIT, script.Name))
end







function ModuleExecutor.execute(caller, msg)
	local scriptCaller = string.format('%s[from=%s]', caller, script.Name)

	local moduleName = msg.module
	local funcName = msg.func
	local args = msg.args

	local function checkMessage(msg, moduleName, funcName, args, caller) -- Check if the message is correct
		if not msg then -- Check if the message exist
			error(string.format(moduleErrorsMsg.NOT_MESSAGE, script.Name, caller))
		elseif type(msg) ~= 'table' then
			error(string.format(moduleErrorsMsg.MSG_ISNT_TABLE, script.Name, caller))
		elseif not moduleName then -- Check if the message have the module name
			error(string.format(moduleErrorsMsg.NOT_TARGET_MODULE_IN_MESSAGE, script.Name, caller))
		elseif not funcName then -- Check if the message have the function name
			error(string.format(moduleErrorsMsg.NOT_TARGETED_FUNCTION_IN_MESSAGE, script.Name, caller))
		elseif msg.argsReq and not args then -- Check if the message have the arguments when required
			error(string.format(moduleErrorsMsg.ARGS_REQ_BUT_NOT_ARGS, moduleName, funcName, caller))
		else
			return true
		end
	end

	--message = {
	--	module = 'targeted module',
	--	func = 'function to call in the module',
	--	args = {}
	-- async = bool (optional, default false)
	-- argsReq = bool (optional, default false) 
	-- response = bool (optional, default false)
	-- pcall = bool (optional, default false) TODO
	-- init = bool (optional, default true) DO
	--}


	local function ensureModuleInit(moduleName, funcName, scriptCaller, caller)
		if not Registry.isRegistered(scriptCaller, moduleName) then
			if msg.init == false then
				error(string.format(moduleErrorsMsg.MODULE_NO_REGISTERED_INIT_FALSE, moduleName, script.Name, moduleName, funcName, caller))
			end
		end

		Initializer.modulesInit(scriptCaller, moduleName, caller)

		if not Registry.isRegistered(scriptCaller, moduleName) then
			error(string.format(moduleErrorsMsg.MODULE_NO_INIT, moduleName, script.Name, moduleName, funcName, caller))
		end
	end

	local function getModule(moduleName, caller)
		local module = Registry.modules[moduleName]
		if module then
			return module
		else
			error(string.format(moduleErrorsMsg.NO_MODULE, moduleName, script.Name, moduleName, funcName, caller))
		end
	end

	local function funcExist(module, moduleName, funcName, caller)
		if not module[funcName] then
			error(string.format(moduleErrorsMsg.FUNC_DOESNT_EXISTS, funcName, script.Name, moduleName, funcName, caller))
		end
	end


	local function execute(module, funcName, args, msg, caller)
		local result

		-- execute the function and give args if required
		local function callFunc()
			if msg.argsReq and args then
				return module[funcName](table.unpack(args))
			else
				return module[funcName]()
			end
		end


		-- if async true, launch a task
		if msg.async then
			local co = task.spawn(module[funcName], table.unpack(args))
			-- TODO, register the coroutine
		else
			result = callFunc()
		end

		return result
	end

	local function executeInPcall(module, funcName, args, msg, caller)	
		local success, result = pcall(function()
			execute(module, funcName, args, msg, caller)
		end)
		if success then
			return result
		else
			error(string.format(moduleErrorsMsg.ERR_PCALL, script.Name, moduleName, funcName, caller, result))
		end
	end


	if checkMessage(msg, moduleName, funcName, args, caller) then

		ensureModuleInit(moduleName, funcName, scriptCaller, caller)

		local module = getModule(moduleName)
		
		funcExist(module, moduleName, funcName, caller)

		local result
		if msg.pcall  then
			result = executeInPcall(module, funcName, args, msg, caller)
		else
			result = execute(module, funcName, args, msg, caller)
		end

		if msg.result and not result then
			error(string.format(moduleErrorsMsg.NO_RESULT, script.Name, moduleName, funcName, caller))
		end
		
		return result -- return the result
	end


end

return ModuleExecutor
