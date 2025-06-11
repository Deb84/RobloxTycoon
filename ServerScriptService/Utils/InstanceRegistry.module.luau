local PathUtils = {}

local Paths = {}

local function tableDiving(base, parents, createMissing)
	local current = base
	if type(parents) ~= 'table' then
		parents = {parents}
	end
	
	for i, key in ipairs(parents) do
		
		if type(current[key]) ~= 'table' then
			if createMissing then
				current[key] = {}
			else
				return nil
			end
			
		end
		current = current[key]
		continue
	end
	return current
end


function PathUtils.addTable(tableName, data)
	if not Paths[tableName] then
		if data then
			Paths[tableName] = data
		else
			Paths[tableName] = {}
		end
	end
end

function PathUtils.addTableTo(tableName, parents, data)
	local parentTable = tableDiving(Paths, parents, true)
	if parentTable then
		if not parentTable[tableName]  then
			parentTable[tableName] = data or {}
		end
	end
end

function PathUtils.join(...)
	local joinArgs = table.pack(...)
	if joinArgs['n'] then
		joinArgs['n'] = nil
	end
	return joinArgs
end

function PathUtils.removeTable(tabelName)
	if Paths[tabelName] then
		Paths[tabelName] = nil
	end
end

function PathUtils.removeTableTo(tableName, parents)
	if type(parents) ~= 'table' then
		parents = {parents}
	end
	local lastKey = table.remove(parents)
	local parentTable = tableDiving(Paths, parents, false)
	if parentTable and parentTable[lastKey] then
		parentTable[lastKey][tableName] = nil
	end
end

function PathUtils.findTable(tableName, parents)
	local parentTable = tableDiving(Paths, parents, false)
	if parentTable and parentTable[tableName] then
		return true
	end
	return false
end

function PathUtils.addPath(pathName, path)
	Paths[pathName] = path
end

function PathUtils.addPathTo(pathName, parents, path)
	print('a')
	local parentTable = tableDiving(Paths, parents, true)
	if parentTable then
		if not parentTable[pathName]  then
			parentTable[pathName] = path
		end
	end
end

function PathUtils.changePathTo(pathName, parents, path)
	local parentTable = tableDiving(Paths, parents, true)
	if parentTable then
		if parentTable[pathName]  then
			parentTable[pathName] = path
		else
			warn('TODO')
		end
	end
end

function PathUtils.getPath(pathName, parents)
	if not parents then
		if Paths[pathName] then
			return Paths[pathName]
		end
	else
		local parentTable = tableDiving(Paths, parents, false)
		if parentTable then
			if parentTable[pathName] then
				return parentTable[pathName]
			end
		end
	end
end

function PathUtils.getPaths()
	return Paths
end


return PathUtils
