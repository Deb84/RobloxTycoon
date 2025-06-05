local PathUtils = {}
local ServerScriptService = game:GetService('ServerScriptService')

local services = require(ServerScriptService.Utils.Services)
local Players = services:getService('Players')
local ServerStorage = services:getService('ServerStorage')
local StarterGui = services:getService('StarterGui')
local StarterPlayer = services:getService('StarterPlayer')


function PathUtils:addPath(pathName, path)
	self[pathName] = path
end

function PathUtils:getPath(pathName)
	if self[pathName] then
		return self[pathName]
	end
end


return PathUtils
