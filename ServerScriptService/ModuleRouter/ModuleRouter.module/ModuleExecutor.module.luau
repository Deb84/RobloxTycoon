local ServerScriptService = game:GetService('ServerScriptService')
local Registry = require(script.Parent:FindFirstChild('ModuleRegistry'))
local Initializer = require(script.Parent:FindFirstChild('ModuleInitializer'))
local LogMsg = require(ServerScriptService.Logs.LogsMessagesManager)

local ModuleExecutor = {}


assert(Registry, LogMsg.get('error', 'EXE_NO_REGISTRY', script.Name))
assert(Initializer, LogMsg.get('error','EXE_NOT_INITIALIZER', script.Name))



function ModuleExecutor.execute(caller: string, msg: {
	module: string,
	func: string,
	args: (string | table)?,
	async: boolean?,
	argsReq: boolean?,
	result: boolean?,
	pcall: boolean?,
	init: boolean?
	})
	
	local scriptCaller = string.format(':"%s" -> "%s":', caller, script.Name) -- Set a new caller message for external script
	
	-- msg is a table that contains the instructions
	-- msg structure :
	-- message = {
	--	module = 'targeted module',
	--	func = 'function to call in the module',
	--	args = {args1, args2, args3, etc}
	-- async = bool (optional, default false)
	-- argsReq = bool (optional, default false) 
	-- result = bool (optional, default false)
	-- pcall = bool (optional, default false)
	-- init = bool (optional, default true)
	--}
	

	local moduleName = msg.module
	local funcName = msg.func
	local args = msg.args

	local function checkMessage(msg, moduleName, funcName, args, caller) -- Check if the message is correct
		assert(msg, LogMsg.get('error', 'EXE_NO_MSG', {script.Name, caller})) -- check if the message exists
		assert(type(msg) == 'table', LogMsg.get('error', 'EXE_MSG_ISNT_TABLE', {script.Name, caller}))
		assert(moduleName, LogMsg.get('error', 'EXE_NO_MODULE_IN_MSG', {script.Name, caller}))
		assert(funcName, LogMsg.get('error', 'EXE_NO_FUNC_IN_MSG', {script.Name, caller}))
		assert(not (msg.argsRes == true and args == nil), LogMsg.get('error', 'EXE_ARGS_NIL', {moduleName, funcName, caller}))
		return true
	end


	local function ensureModuleInit(moduleName, funcName, scriptCaller, caller)
		if not Registry.isRegistered(scriptCaller, moduleName) then -- check if the module is registered
			if msg.init == false then -- if msg.init false, doesn't init the module
				error(LogMsg.get('error', 'EXE_MODULE_NO_REGISTERED_INIT_FALSE', {moduleName, script.Name, moduleName, funcName, caller}))
			end
		end

		Initializer.modulesInit(scriptCaller, moduleName) -- Initialize the module if msg.init is true

		if not Registry.isRegistered(scriptCaller, moduleName) then -- check a second time if the module is registered, if not raise an error
			error(LogMsg.get('error', 'EXE_MODULE_NO_INIT', {moduleName, script.Name, moduleName, funcName, caller}))
		end
	end
	
	local function argsCheckAndFormat(args, moduleName, funcName, caller)
		if type(args) == 'string' then -- If args is a string, put it in a table
			return {args} 
		elseif type(args) ~= 'table' then -- Raise an error if args is not a table
			error(LogMsg.get('error', 'EXE_ARGS_NOT_TABLE', {script.Name, moduleName, funcName, caller}))
		else
			return args -- return args if there's nothing to do
		end
	end

	local function getModule(moduleName, caller)
		local module = Registry.getModule(caller, moduleName) -- get the module in the registry
		if module then
			return module -- return the module
		else
			error(LogMsg.get('error', 'EXE_NO_MODULE', {moduleName, script.Name, moduleName, funcName, caller}))
		end
	end

	local function checkFuncExistence(module, moduleName, funcName, caller) -- Check if the targeted function exists, if not raise an error
		if not module[funcName] then
			error(LogMsg.get('error', 'EXE_FUNC_DOESNT_EXISTS', {funcName, script.Name, moduleName, funcName, caller}))
		end
	end

	
	-- execute the function
	local function executor(module, funcName, args, msg, caller)
		
		local function callFunc() -- execute the function and give args if required
			if args then
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
			return callFunc() -- return the result of the function
		end

	end

	local function executeInPcall(module, funcName, args, msg, caller)	
		local success, result = pcall(function()
			return executor(module, funcName, args, msg, caller)
		end)
		if success then
			return result -- if the pcall is successful, return the result
		else
			error(LogMsg.get('error', 'EXE_ERR_PCALL', {script.Name, moduleName, funcName, caller, result}))
		end
	end


	if checkMessage(msg, moduleName, funcName, args, caller) then

		ensureModuleInit(moduleName, funcName, scriptCaller, caller) -- check if the module is initialized (and init if possible)
		
		args = argsCheckAndFormat(args, moduleName, funcName, caller) -- check and format the args

		local module = getModule(moduleName) -- get the module from its name
		
		checkFuncExistence(module, moduleName, funcName, caller) -- check if the function exists

		local result
		if msg.pcall  then -- use pcall if msg.pcall is true
			result = executeInPcall(module, funcName, args, msg, caller)
		else
			result = executor(module, funcName, args, msg, caller)
		end

		if msg.result and not result then -- if result required and not result, raise an error
			error(LogMsg.get('error', 'EXE_NO_RESULT', {script.Name, moduleName, funcName, caller}))
		end
		
		return result -- return the result
	end


end

return ModuleExecutor
