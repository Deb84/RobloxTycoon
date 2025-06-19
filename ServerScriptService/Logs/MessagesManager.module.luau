SSS = game:GetService('ServerScriptService')

local MessagesManager = {}

local CONFIG = {
	FALLBACK_ERRORS = {
		INFO = string.format('Unable to find the module "Info" [error_location=%s]', script.Name),
		ERROR = string.format('Unable to find the module "Error" [error_location=%s]', script.Name),
		WARN = string.format('Unable to find the module "Warn" [error_location=%s]', script.Name),
		
		INCORRECT_PATH = 'Unable to find the messages module "%s" [error_location=%s]',
		
		UNKNOW_TYPE = string.format('Unable to find the message type [error_location=%s]', script.Name),
		TYPE_NIL = string.format('Logs type indexed as "nil" [error_location=%s]', script.Name),
		UNKNOW_CODE = string.format('Unknown log code [error_location=%s]', script.Name),
		CODE_NIL = string.format('Log code indexed as "nil" [error_location=%s]', script.Name),
		ARGS_NIL = string.format('Log message args indexed as "nil" [error_location=%s]', script.Name)
	},
	MODULES = {
		INFO = 'Info',
		ERROR = 'Error',
		WARN = 'Warn'
	},
	BASE_PATH = SSS.Logs.Messages
}

local moduleCache = {}

local function traceback()
	print(debug.traceback())
end

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
	
	local function putInFlatTable(t: table, list: table) -- put the messages in a flat table
		list = list or {}
		
		for key, item in pairs(t) do
			if type(item) == 'table' then
				putInFlatTable(item, list)
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
			MessagesManager.msg[key] = putInFlatTable(module)
		end
	end
	
	print(moduleCache)
	print(MessagesManager.msg)
	
end


local function getMessage(level: string, code: string, stringFormatArgs: table | string)
	level = string.upper(level)
	
	local function getMsg(level, code)
		if not MessagesManager.msg[level]  then
			error(string.format('Uncorret log level "%s" [error_location=%s]', level, script.Name))
		end
		
		local levelModule: table = MessagesManager.msg[level]
		
		if not levelModule[code] then
			error(string.format('Uncorrect code "%s" [error_location=%s]', code, script.Name))
		end
		
		local msg: string = levelModule[code]
		
		if not msg then
			error(string.format('Invalid code "%s" [error_location=%s]', code, script.Name))
		end
		
		return msg
	end
	
	
	local function formatMessage(msg: string, args)
		if type(args) ~= 'table' then
			args = {args}
		end
		
		local msgBuild = string.format(msg, table.unpack(args))
		return msgBuild
	end
	
	
	local msg = getMsg(level, code)
	
	return formatMessage(msg, stringFormatArgs)
end


MessagesManager.init = init
MessagesManager.getMessage = getMessage


return MessagesManager
