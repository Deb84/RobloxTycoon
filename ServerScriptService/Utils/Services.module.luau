local Services = {
	Players = game:GetService('Players'),
	ServerScriptService = game:GetService('ServerScriptService'),
	ServerStorage = game:GetService('ServerStorage'),
	StarterGui = game:GetService('StarterGui'),
	StarterPlayer = game:GetService('StarterPlayer')
}


function Services:getService(name)
	if self[name] then
		return self[name]
	else
		warn('The service "'..name..'" is unaccessible [module:'..script.Name..'/function:getService]')
	end
end

function Services:getServices(...)
	local names = {...}
	local services = {}
	
	for _, name in pairs(names) do
		if self[name] then
			table.insert(services, self[name])
		else
			warn('The service "'..name..'" is unaccessible [module:'..script.Name..'/function:getServices]')
		end
	end
	
	if services then
		return table.unpack(services)
	end
end 


return Services
