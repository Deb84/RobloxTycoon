SSS = game:GetService('ServerScriptService')
LogMsg = require(SSS.Logs.LogsMessagesManager)

local Registry = {}


local modulesCache = {}


local function isRegistered(caller: string, moduleName: string)
	if modulesCache[moduleName] then
		return true
	end
	return false
end


function Registry.Register(caller: string, moduleName: string, module: table)
	if not moduleName then
		error(LogMsg.get('error', 'MREG_NO_REGI_TG', caller))
	elseif not module then
		error(LogMsg.get('error', 'MREG_NO_REGI_MOD', caller))
	end
	
	
	if not isRegistered(caller, moduleName) then
		modulesCache[moduleName] = module
	else
		warn(LogMsg.get('warn', 'MREG_MOD_ALREADY_REGI', {moduleName, caller}))
	end
end


function Registry.getRegistry(caller: string)
	if not next(modulesCache) then
		warn(LogMsg.get('warn', 'MREG_MOD_TBL_EMPTY', caller))
	end
	return modulesCache
end



function Registry.getModule(caller: string, moduleName: string) -- existence verification to do in the caller script if an error is needed
	if not moduleName then
		error(LogMsg.get('error', 'MREG_GET_NO_MOD_NAME', {'moduleName', caller}))
	end
	
	if not isRegistered(caller, moduleName) then
		warn(LogMsg.get('warn', 'MREG_FAIL_GET', {moduleName, caller}))
		return
	end
	return modulesCache[moduleName]
end

function Registry.getModules(caller: string, moduleNames: table | string)
	if not moduleNames then
		error(LogMsg.get('error', 'MREG_GET_NO_MOD_NAME', {'moduleNames', caller}))
	end
	
	if type(moduleNames) ~= 'table' then
		moduleNames = {moduleNames}
	end
	
	local moduleList = {}
	
	for _, moduleName in pairs(moduleNames) do
		if isRegistered(caller, moduleName) then
			table.insert(moduleList, modulesCache[moduleName])
		else
			warn(LogMsg.get('warn', 'MREG_FAIL_GET', caller))
		end
	end

	if not next(moduleList) then
		warn(LogMsg.get('warn', 'MREG_GET_ML_EMPTY', caller))
	end
	return moduleList
end


function Registry.removeModule(caller: string, moduleName: string)
	if not moduleName then
		error(LogMsg.get('error', 'MREG_RMV_NO_MOD_NAME', caller))
	end
	
	if not isRegistered(caller, moduleName) then
		warn(LogMsg.get('warn', 'MREG_RMV_NO_MOD_REGI', caller))
		return
	end
	
	modulesCache[moduleName] = nil
end

local function clearRegistry(caller: string)
	if next(modulesCache) then
		modulesCache = {}
		warn(LogMsg.get('warn', 'MREG_REG_CLEAR', caller))
	end
end

Registry.isRegistered = isRegistered
Registry.clearRegistry = clearRegistry


return Registry
