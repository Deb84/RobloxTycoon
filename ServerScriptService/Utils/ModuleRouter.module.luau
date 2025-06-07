local ModulesLists = require(script:FindFirstChild('ModulesList'))
local ModuleRegistery = require(script:FindFirstChild('ModuleRegistery'))
local ModuleExecuter = require(script:FindFirstChild('ModuleExecuter'))
local ModuleLoader = require(script:FindFirstChild('ModuleLoader'))
local moduleRouter = {}


local modules = {}


-- For the recursive imports
function moduleRouter.modulesInit(caller, moduleName, ...)
	
	local function moduleListRegister(modulesList)
		for _, module in pairs(modulesList) do
			if not modules[module] then
				moduleRouter.Register(module.name, require(module))
			end
		end
		return true	
	end
	
	local function moduleRegister(moduleName)
		local map = ModulesLists.map
		local moduleList = map[moduleName]
		local module = moduleList[moduleName]
		moduleRouter.Register(module.name, require(module))
		return true
	end
	
	local function initEveryModules(modulesTypesList)
		local moduleInitSatusTable = {}
		for k, moduleList in pairs(modulesTypesList) do
			local response = moduleListRegister(moduleList)
			moduleInitSatusTable[k] = response
		end
		return moduleInitSatusTable
	end
	
	local function checkResponse(responses)
		if responses then
			if type(responses) == 'table' then
				for _, response in ipairs(responses) do
					return true
				end
				return
			else
				if responses then
					return true
				else return end
			end
		else return end
	end
	
	local modulesTypesList = {
		lists = ModulesLists.modulesLists,
		teamsLists = ModulesLists.teamsLists,
		managers = ModulesLists.modulesManagers,
		utils = ModulesLists.modulesUtils,
		parts = ModulesLists.modulesParts,
	}
	
	
	local modulesResponse
	
	-- handle module init per type
	if moduleName and type(moduleName) == 'table' and moduleName['type'] then
		
		if moduleName['type'] == 'lists' then
			-- TODO
		else
			warn('Unable to initialize the module type "'..moduleName..'" [module:'..script.Name..'/function:modulesInit/caller:'..caller..']')
		end
		
	-- handle init of all modules
	elseif not moduleName then
		
		modulesResponse = initEveryModules(modulesTypesList)
	
	-- handle single and multiple init
	elseif moduleName and type(moduleName) == 'string' then
		if ... then
			local moduleNamesPack = table.pack(...)
			for _, modulesName in ipairs(moduleNamesPack) do
				local response = moduleRegister(modulesName)
				if not response then return end
			end
		end
		modulesResponse = moduleRegister(moduleName)
	end
	
	print(modules)
	
	if checkResponse(modulesResponse) then
		return true
	else
		if type(moduleName) == 'string' then
			warn('Unable to initialize the module "'..moduleName..'" [module:'..script.Name..'/function:modulesInit/caller:'..caller..']')
		end
		return
	end
end


function moduleRouter.Register(targetName, module)
	modules[targetName] = module
end


-- Allow to execute a module from this module
function moduleRouter.execute(message)
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
		if not message or not message.targetModule or not modules then 
			return nil, warn('Uncorrect module call [module:'..message.targetModule..'/caller:'..message.caller..']')
		end
		
		local module = modules[message.targetModule]
		
		if module and module[message.targetFunction] then 
			return module 
		else 
			warn('Uncorrect function call [module:'..message.targetModule..'/targetedFunction:'..message.targetFunction..'/caller:'..message.caller..']')
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
				warn('Response set to true but retourned nil, returned nil [module:'..message.targetModule..'/targetedFunction:'..message.targetFunction..'/caller:'..message.caller..']')
				return nil
			end
			return moduleResponse
		end
	end
end


-- Classic module utils
function moduleRouter.addModule(moduleName, module)
	local function try(module)
		local reqModule = require(module)
		reqModule = nil
	end

	if not modules[moduleName]  then
		local sucess, err = pcall(function()
			try(module)
		end)

		if err then
			return warn('Unable to add '..moduleName..' to the list')
		end

		modules[moduleName] = require(module)
	end
end

function moduleRouter.removeModule(moduleName)
	modules[moduleName] = nil
end

function moduleRouter.getModule(caller, moduleName)
	if modules[moduleName] then
		return modules[moduleName]
	else
		warn(caller)
		warn('Unable to get '..moduleName..' in the list')
		return
	end
end

function moduleRouter.getModules(caller, ...)
	local moduleNames = {...}
	local moduleList = {}

	for _, moduleName in pairs(moduleNames) do
		if modules[moduleName] then
			table.insert(moduleList, modules[moduleName])
		else
			warn('Unable to find the module "'..moduleName..'" [modules:'..script.Name..'/function:getModules/caller:'..caller..']')
		end
	end

	if moduleList then
		return table.unpack(moduleList)
	end
end

function moduleRouter.getModulesAndInit(caller, ...)
	caller = caller..' in '..script.name..' via function:getModulesAndInit'
	if moduleRouter.modulesInit(caller, ...) then
		return moduleRouter.getModules(caller, ...)
	end
end



return moduleRouter
