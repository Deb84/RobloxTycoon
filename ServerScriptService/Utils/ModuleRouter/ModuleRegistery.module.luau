local Registery = {}

Registery.modules = {}


function Registery.Register(caller, targetName, module)
	if not Registery.modules[targetName] then
		Registery.modules[targetName] = module
	end
end

function Registery.isRegistered(caller, module)
	if Registery.modules[module] then
		return true
	else
		return false
	end
end

function Registery.getModuleTable(caller)
	return Registery.modules
end



function Registery.getModule(caller, moduleName)
	if Registery.modules[moduleName] then
		return Registery.modules[moduleName]
	else
		warn(caller)
		warn('Unable to get '..moduleName..' in the list')
		return
	end
end

function Registery.getModules(caller, moduleNames)
	local moduleList = {}
	for _, moduleName in pairs(moduleNames) do
		if Registery.modules[moduleName] then
			table.insert(moduleList, Registery.modules[moduleName])
		else
			warn('Unable to find the module "'..moduleName..'" [modules:'..script.Name..'/function:getModules/caller:'..caller..']')
		end
	end

	if moduleList then
		return table.unpack(moduleList)
	end
end


function Registery.addModule(caller, moduleName, module)
	local function try(module)
		local reqModule = require(module)
		reqModule = nil
	end

	if not Registery.modules[moduleName]  then
		local sucess, err = pcall(function()
			try(module)
		end)

		if err then
			return warn('Unable to add '..moduleName..' to the list')
		end

		Registery.modules[moduleName] = require(module)
	end
end

function Registery.removeModule(caller, moduleName)
	if Registery.modules[moduleName] then
		Registery.modules[moduleName] = nil
	end
end




return Registery
