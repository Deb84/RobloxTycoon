SSS = game:GetService('ServerScriptService')
LogMsg = require(SSS.Logs.LogsMessagesManager) -- Logs mgmt

local Registry = {}


local modulesCache = {} -- a table that contains all the modules initialized


-- check if a module is registered in the module cache
local function isRegistered(caller: string, moduleName: string)
	return modulesCache[moduleName] ~= nil
end

-- register a module in the module cache with his name and table
function Registry.register(caller: string, moduleName: string, module: table)
	-- check args existence
	if not moduleName then
		error(LogMsg.get('error', 'MREG_NO_REGI_TG', caller))
	elseif not module then
		error(LogMsg.get('error', 'MREG_NO_REGI_MOD', caller))
	end
	
	
	if not isRegistered(caller, moduleName) then -- check if the module is already registered
		modulesCache[moduleName] = module
	else
		if module == modulesCache[moduleName] then
			warn(LogMsg.get('warn', 'MREG_MOD_ALREADY_REGI', {moduleName, caller})) -- warn if the module is already registered
		else
			warn(LogMsg.get('warn', 'MREG_REGI_OW', {moduleName, caller})) -- warn if the a module with the same name got overwritten
		end
	end
end


-- return the entire module cache table
-- !! ONLY FOR DEBUG !!
function Registry.getRegistry(caller: string)
	if not next(modulesCache) then
		warn(LogMsg.get('warn', 'MREG_MOD_TBL_EMPTY', caller))
	end
	return modulesCache
end


-- return a module by his name
function Registry.getModule(caller: string, moduleName: string) -- existence verification to do in the caller script if an error is needed
	if not moduleName then -- check args existence
		error(LogMsg.get('error', 'MREG_GET_NO_MOD_NAME', {'moduleName', caller}))
	end
	
	if not isRegistered(caller, moduleName) then -- check if the module is registered
		error(LogMsg.get('error', 'MREG_FAIL_GET', {moduleName, caller}))
		return
	end
	return modulesCache[moduleName]
end

-- return a package of function in a table
function Registry.getModules(caller: string, moduleNames: table | string)
	if not moduleNames then
		error(LogMsg.get('error', 'MREG_GET_NO_MOD_NAME', {'moduleNames', caller}))
	end
	
	if type(moduleNames) ~= 'table' then -- put moduleNames in a table if is it not
		moduleNames = {moduleNames}
	end
	
	local moduleList = {} -- create a temporary cache for the modules
	
	for _, moduleName in pairs(moduleNames) do -- for each module requested, verify the existence in module cache and add it to the temporary cache
		if isRegistered(caller, moduleName) then
			table.insert(moduleList, modulesCache[moduleName])
		else
			error(LogMsg.get('error', 'MREG_FAIL_GET', {moduleName, caller}))
		end
	end

	return moduleList
end


-- remove a module from the module cache
function Registry.removeModule(caller: string, moduleName: string)
	if not moduleName then -- check args existence
		error(LogMsg.get('error', 'MREG_RMV_NO_MOD_NAME', caller))
	end
	
	if not isRegistered(caller, moduleName) then -- check if the module is registered
		warn(LogMsg.get('error', 'MREG_RMV_NO_MOD_REGI', caller))
		return
	end
	
	modulesCache[moduleName] = nil -- set the module as nil (remove it)
end


-- clear the entire module cache
-- !! ONLY FOR DEBUG !!
function Registry.clearRegistry(caller: string)
	if next(modulesCache) then
		modulesCache = {}
		warn(LogMsg.get('warn', 'MREG_REG_CLEAR', caller))
	end
end

Registry.isRegistered = isRegistered -- expose the function, avoid to write Registry.isRegistered each time here


return Registry
