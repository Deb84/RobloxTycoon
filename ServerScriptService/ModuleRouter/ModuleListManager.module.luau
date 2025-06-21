local MLM = {}

MLM.ModuleList = {}

-- MLM = ModuleListManager
-- ML = ModuleList (module)




assert(MLM.ModuleList)




local function init(moduleList: module) -- inject moduleList (hierarchical table)
	
	local function InitTable(t: table, list: table?) -- create a flatten table of modules
		local list = list or {}

		for key, item in pairs(t) do
			if type(item) == "table" then
				InitTable(item, list)
			else
				list[key] = item
			end
		end
		return list
	end
	
	local ML = moduleList.orderedList -- get the hierarchical table of modules
	assert(ML)
	
	
	MLM.ModuleList = InitTable(ML) -- create a flatten table of modules and put it in a global table
	print(MLM.ModuleList) -- TODELETE --
	-- print a info like "ModuleList initialized"	
end

local function getModulePath (moduleName: string)
	local modulePath = MLM.ModuleList[moduleName]
	if not modulePath then
		error("a") --TODO
	end
	
	return modulePath
end


-- declare public functions

MLM.init = init
MLM.getModulePath = getModulePath

return MLM
