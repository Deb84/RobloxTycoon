local Registry = {}

Registry.modules = {}


function Registry.Register(caller: string, targetName: string, module: module)
	if not Registry.modules[targetName] then
		Registry.modules[targetName] = module
	end
end

function Registry.isRegistered(caller, module)
	if Registry.modules[module] then
		return true
	else
		return false
	end
end

function Registry.getModuleTable(caller)
	return Registry.modules
end



function Registry.getModule(caller, moduleName)
	if Registry.modules[moduleName] then
		return Registry.modules[moduleName]
	else
		warn(caller)
		warn('Unable to get '..moduleName..' in the list')
		return
	end
end

function Registry.getModules(caller, moduleNames)
	if type(moduleNames) ~= 'table' then
		moduleNames = {moduleNames}
	end
	
	local moduleList = {}
	for _, moduleName in pairs(moduleNames) do
		if Registry.modules[moduleName] then
			table.insert(moduleList, Registry.modules[moduleName])
		else
			warn('Unable to find the module "'..moduleName..'" [modules:'..script.Name..'/function:getModules/caller:'..caller..']')
		end
	end

	if moduleList then
		return moduleList
	end
end


function Registry.addModule(caller, moduleName, module)
	local function try(module)
		local reqModule = require(module)
		reqModule = nil
	end

	if not Registry.modules[moduleName]  then
		local sucess, err = pcall(function()
			try(module)
		end)

		if err then
			return warn('Unable to add '..moduleName..' to the list')
		end

		Registry.modules[moduleName] = require(module)
	end
end

function Registry.removeModule(caller, moduleName)
	if Registry.modules[moduleName] then
		Registry.modules[moduleName] = nil
	end
end




return Registry
