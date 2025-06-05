local ServerScriptService = game:GetService('ServerScriptService')
local moduleRouter = {}

local modules = {
	-- Lists
	PlateList = require(ServerScriptService.Tycoon.BuyingPlates.PlatesList),
	startPlatesList = require(ServerScriptService.Tycoon.Start.StartPlatesList),
	teamsList = require(ServerScriptService.Teams.TeamsList),
	-- Utils
	CoinsUtils = require(ServerScriptService.Leaderboard.CoinsUtils),
	PathUtils = require(ServerScriptService.Utils.PathUtils),
	PlacementUtils = require(ServerScriptService.Utils.PlacementUtils),
	
}

-- For the recursive imports
function moduleRouter.modulesInit(moduleName)
	-- Parts
	local modulesList = {
		-- Parts
		Droppers = ServerScriptService.Tycoon.Droppers.Droppers,
		Plates = ServerScriptService.Tycoon.BuyingPlates.Plates,
		Conveyors = ServerScriptService.Tycoon.Conveyors.Conveyors,
		BuildParts = ServerScriptService.Tycoon.BuildParts.BuildParts,
		-- Manager
		PlateOrder = ServerScriptService.Tycoon.BuyingPlates.PlatesOrder,
		TeamsHandler = ServerScriptService.Teams.TeamsHandler
	}
	if not moduleName then
		for _, module in pairs(modulesList) do
			if not modules[module] then
				moduleRouter.Register(module.Name, require(module))
			end
		end
		
	elseif modulesList[moduleName] then
		if not modules[moduleName] then
			moduleRouter.Register(modulesList[moduleName].Name, require(modulesList[moduleName]))
		end
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

function moduleRouter.getModule(moduleName)
	if modules[moduleName] then
		return modules[moduleName]
	else
		warn('Unable to get '..moduleName..' in the list')
		return
	end
end

function moduleRouter.getModules(...)
	local moduleName = {...}
	local moduleList = {}

	for _, list in pairs(moduleName) do
		if modules[list] then
			table.insert(moduleList, modules[list])
		end
	end

	if moduleList then
		return table.unpack(moduleList)
	end
end



return moduleRouter
