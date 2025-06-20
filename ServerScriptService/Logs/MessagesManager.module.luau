-- Refactorisation :
	-- centralize the error messages


local SSS = game:GetService('ServerScriptService')

local MessagesManager = {}

local CONFIG = {
	FALLBACK_ERRORS = {
		INFO = string.format('Unable to find the module "Info" [error_location="%s"]', script.Name),
		ERROR = string.format('Unable to find the module "Error" [error_location="%s"]', script.Name),
		WARN = string.format('Unable to find the module "Warn" [error_location="%s"]', script.Name),
		
		INCORRECT_PATH = 'Unable to find the messages module "%s" [error_location="%s"]',
		
	},
	MODULES = {
		INFO = 'Info',
		ERROR = 'Error',
		WARN = 'Warn'
	},
	BASE_PATH = SSS.Logs.Messages
}

-- Always normalize the level with uppercase !


local moduleCache = {}

--local function traceback()
--	print(debug.traceback())
--end

local function init()
	local function moduleInit() -- require the modules of CONFIG.MODULES
		for key, moduleName in pairs(CONFIG.MODULES) do
			local normKey = string.upper(key) -- normalize the key
			
			
			local path = CONFIG.BASE_PATH:FindFirstChild(moduleName)
			
			if not path  then
				error(string.format(CONFIG.FALLBACK_ERRORS.INCORRECT_PATH, moduleName, script.Name)) -- raise an error if the module doesn't exist
			end
			
			if not moduleCache[normKey] then -- check if the module is already cached
				
				local success, result = pcall(require, path)
				if success then
					moduleCache[normKey] = result -- if the pcall is successfull, add the module to the cache
				else
					error(CONFIG.FALLBACK_ERRORS[normKey]) -- if the pcall fails, raise an error
				end
				
			end
			

		end
	end
	
	local function flattenMessagesTable(t: table, list: table) -- put the messages in a flat table
		list = list or {}
		
		for key, item in pairs(t) do
			if type(item) == 'table' then
				flattenMessagesTable(item, list)
			else
				list[key] = item
			end
		end
		return list
	end
	
	MessagesManager['msg'] = {} -- set a new table "msg" to contains the module flat tables
	
	moduleInit()
	
	for key, module in pairs(moduleCache) do -- put each modules in a flat table
		if next(module) and key then
			MessagesManager.msg[key] = flattenMessagesTable(module)
		end
	end
	
	print(moduleCache) -- TODELETE
	print(MessagesManager.msg) -- TODELETE
	
end


local function getMessage(level: string, code: string, stringFormatArgs: table | string)
	
	local function getMsg(level, code) -- get the message from the flat
		if not MessagesManager.msg[level]  then
			error(string.format('Incorrect log level "%s" [error_location="%s"]', level, script.Name))
		end
		
		local levelModule: table = MessagesManager.msg[level]
		
		if not levelModule[code] then
			error(string.format('Incorrect code "%s" [error_location="%s"]', code, script.Name))
		end
		
		local msg: string = levelModule[code]
		
		return msg
	end
	
	
	local function formatMessage(msg: string, args) -- format the message with string format and args
		local msgBuild
		
		if args  then
			if type(args) ~= 'table' then
				args = {args}
			end
			
			-- check the number of args required & received
			local _, countArgsRequired = string.gsub(msg, "%%s", "")
			local countArgsGived = #args
			if countArgsGived ~= countArgsRequired then
				error(string.format('Incorrect number of arguments, expected : %i, receive : %i [error_location="%s"]', countArgsRequired, countArgsRequired, script.Name))
			end
			
			
			msgBuild = string.format(msg, table.unpack(args))
		else
			msgBuild = msg
		end
		
		return msgBuild
	end
	
	-- check if level & code exist
	if not level then
		error(string.format('Level indexed to "nil" [error_location="%s"]', script.Name))
	elseif not code then
		error(string.format('Code indexed to "nil" [error_location="%s"]', script.Name))
	end
	
	level = string.upper(level) -- normalize the level
	
	
	-- get the message and return the formated code
	
	local msg = getMsg(level, code)
	
	return formatMessage(msg, stringFormatArgs)
end


MessagesManager.init = init
MessagesManager.getMessage = getMessage


return MessagesManager
