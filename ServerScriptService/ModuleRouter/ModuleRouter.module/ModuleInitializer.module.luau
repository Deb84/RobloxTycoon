local ModuleRegistry = require(script.Parent.ModuleRegistry)
local MLM = require(script.Parent.Parent.ModuleListManager)

local ModuleInitializer = {}


function ModuleInitializer.modulesInit(caller, moduleNames)
	caller = string.format('> %s > %s ', caller, script.Name)
	
	
	local function moduleListRegister(modulesList)
		for _, module in pairs(modulesList) do
			if not ModuleRegistry.isRegistered(caller, module) then
				ModuleRegistry.register(caller, module.name, require(module))
			end
		end
		return true	
	end

	local function moduleRegister(moduleName: string)
		local modulePath = MLM.getModulePath(moduleName)
		ModuleRegistry.register(caller, modulePath.Name, require(modulePath))
		return true
	end

	--local function initEveryModules(modulesTypesList)
	--	local moduleInitSatusTable = {}
	--	for k, moduleList in pairs(modulesTypesList) do
	--		local response = moduleListRegister(moduleList)
	--		moduleInitSatusTable[k] = response
	--	end
	--	return moduleInitSatusTable
	--end

	local function checkResponse(responses)
		if responses then
			if type(responses) == 'table' then
				for _, response in ipairs(responses) do
					return true
				end
				return false
			else
				if responses then
					return true
				else return false end
			end
		else return false end
	end


	local modulesResponse

	-- handle module init per type
	if moduleNames and type(moduleNames) == 'table' and moduleNames['type'] then

		if moduleNames['type'] == 'lists' then
			-- TODO
		else
			warn('Unable to initialize the module type "'..moduleNames..'" [module:'..script.Name..'/function:modulesInit/caller:'..caller..']')
		end

		-- handle init of all modules
	elseif not moduleNames then

		--modulesResponse = initEveryModules(modulesTypesList)

		-- handle single and multiple init
	elseif moduleNames then
		
		if type(moduleNames) == 'table' then
			for _, moduleName in pairs(moduleNames) do
				local response = moduleRegister(moduleName)
				
				if not response then 
					return false 
				else 
					modulesResponse = true
				end
			end
			
		elseif type(moduleNames) == 'string' then
			modulesResponse = moduleRegister(moduleNames)
		end
	end

	
	if checkResponse(modulesResponse) then
		return true
	else
		if type(moduleNames) == 'string' then
			warn('Unable to initialize the module "'..moduleNames..'" [module:'..script.Name..'/function:modulesInit/caller:'..caller..']')
		end
		return
	end
end

return ModuleInitializer
