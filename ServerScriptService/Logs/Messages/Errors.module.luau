local Error = {}

Error.globals = {
	-- FORMAT = '[error_location="%s" callee_module="%s" callee_function ="%s", caller_module="%s"]',
	NO_WARNS = 'Unable to load "Warns" [error_location="%s"]',
}

Error.ServerStart = {
	
	
	FolderInit = {
		FI_NO_WARNS = 'Unable to load Warns.ModuleRouter.FolderInit [error_location="%s"]'
	},
	
	StartPlates = {
		SP_NO_STARTPLATESLIST = 'StartPlatesList indexed "nil" [error_location="%s"]',
		SP_STARTPLATESLIST_ISNT_TABLE = `StartPlatesList isn't a table [error_location="%s"]`,
		
		SP_TEAMSTARTPLATE_ISNT_TABLE = `TeamStartPlate isn't a table [error_location="%s"]`,
		SP_TEAMSTARTPLATE_EMPTY = 'TeamStartPlate is empty [error_location="%s"]',
		-- SP = StartPlateList
		SP_MODEL = 'StartPlate is not a model [error_location=%s]',
		SP_PRIMARY = 'The primary part of StartPlate is not a BasePart [error_location="%s"]',
		SP_COLOR = 'StartPlate Color is not a Color3 value [error_location="%s"]',
		SP_TRANSPARENCY = 'StartPlate Transparency is not a number [error_location="%s"]',
		SP_TRANSPARENCY2 = 'StartPlate NewTransparency is not a number [error_location="%s"]',
		SP_POSITION = 'StartPlate Position is not a CFrame value [error_location="%s"]',
		SP_SPAWNED = 'StartPlate Spawned is not a boolean [error_location="%s"]',
		SP_REBOUNCE = 'StartPlate Rebounce is not a boolean [error_location="%s"]'
	}
}



Error.ModuleRouter = {
		
	ModuleExecutor = {
		EXE_NO_WARNS = 'Unable to load Warns.ModuleRouter.Executor [error_location="%s"]',
		EXE_NO_REGISTRY = 'Unable to load "moduleRegistry" [error_location="%s"]',
		EXE_NOT_INITIALIZER = 'Unable to load "moduleInitializer" [error_location="%s"]',

		EXE_NO_MSG = 'Message missing for "%s" from "%s"',
		EXE_MSG_ISNT_TABLE = `Message isn't a table [error_location="%s" caller_module="%s"]`,
		EXE_NO_MODULE_IN_MSG = 'Module missing [error_location="%s" caller_module="%s"]',
		EXE_NO_FUNC_IN_MSG = 'Function missing for "%s" from "%s"',
		EXE_ARGS_NIL = 'Args required but indexed "nil" [module:%s/targetFunction:%s/caller:"%s"]',

		EXE_MODULE_NO_REG_INIT_FALSE = 'Module "%s" is unregistered and not initialized [error_location="%s" callee_module="%s" callee_function ="%s", caller_module="%s"]',
		EXE_MODULE_NO_INIT = 'Unable to initialize the module "%s" [error_location="%s" callee_module="%s" callee_function ="%s", caller_module="%s"]',

		EXE_ARGS_NOT_TABLE = 'Args are not a table [error_location="%s" callee_module="%s" callee_function ="%s", caller_module="%s"]',

		EXE_FUNC_DOESNT_EXISTS = 'Unable to get the function "s%" [error_location="%s" callee_module="%s" callee_function ="%s", caller_module="%s"]',

		EXE_NO_MODULE = 'Unable to get the module "%s" [error_location="%s" callee_module="%s" callee_function ="%s", caller_module="%s"]',

		EXE_ERR_PCALL= 'An error ocurred from the Pcall [error_location="%s" callee_module="%s" callee_function ="%s", caller_module="%s"] \n %s', -- last %s = error

		EXE_NO_RESULT = 'Result expected but indexed nil [error_location="%s" callee_module="%s" callee_function ="%s", caller_module="%s"]'
	},
	
	ModuleRegistry = {
		
		MREG_NO_REGI_TG = '[MODULE REGISTRY] "targetName" indexed nil [caller_module="%s"]',
		MREG_NO_REGI_MOD = '[MODULE REGISTRY] "module" indexed nil [caller_module="%s"]',
		
		MREG_TBL_NIL = '[MODULE REGISTRY] Module registry indexed nil [caller_module="%s"]',
		
		MREG_GET_NO_MOD_NAME = '[MODULE REGISTRY] %s indexed as nil [caller_module="%s"]',
		
		MREG_RMV_NO_MOD_NAME = '[MODULE REGISTRY] moduleName indexed as nil [caller_module="%s"]'
	}
}


return Error
