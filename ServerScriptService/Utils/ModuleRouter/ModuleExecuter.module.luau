local Registery = require(script.Parent:FindFirstChild('ModuleRegistery'))
local Initalizer = require(script.Parent:FindFirstChild('ModuleInitializer'))

local ModuleExecuter = {}

function ModuleExecuter.execute(caller, message)
	print(caller)
	if not Registery.isRegistered(script.name, message.targetModule) then
		Initalizer.modulesInit(script.name, message.targetModule)
	end
	--message = {
	--	targetModule = 'targeted module',
	-- 	caller = 'caller module',
	--	targetFunction = 'function to call in the module',
	--	args = {}
	-- async = bool (optional, default false)
	-- argsReq = bool (optional, default false) 
	-- response = bool (optional, default false)
	-- pcall = bool (optional, default false) TODO
	--}

	local function check()
		if not message or not message.targetModule or not Registery.modules then 
			return nil, warn('Uncorrect module call [module:'..message.targetModule..'/caller:'..caller..']')
		end

		local module = Registery.modules[message.targetModule]

		if module and module[message.targetFunction] then 
			return module 
		else 
			warn('Uncorrect function call [module:'..message.targetModule..'/targetedFunction:'..message.targetFunction..'/caller:'..caller..']')
		end	
	end

	local moduleResponse
	local function asyncExe(module)
		if message.async then 
			task.spawn(module[message.targetFunction], table.unpack(message.args)) 
		else 
			moduleResponse = module[message.targetFunction](table.unpack(message.args)) 
		end
	end

	local module = check()	
	if module then
		if not message.argsReq or next(message.args) then
			asyncExe(module)
		end	
		if message.response  then
			if moduleResponse == nil then 
				warn('Response set to true but retourned nil, returned nil [module:'..message.targetModule..'/targetedFunction:'..message.targetFunction..'/caller:'..caller..']')
				return nil
			end
			return moduleResponse
		end
	end
end

return ModuleExecuter
