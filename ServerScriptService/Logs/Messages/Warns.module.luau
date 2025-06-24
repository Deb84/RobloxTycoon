local Warns = {}

Warns.globals = {
	
}

Warns.ServerStart = {


	FolderInit = {

	},

	TeamsInit = {

	}
}




Warns.ModuleRouter = {
	
	
	ModuleExecutor = {
		EXE_NOT_INITIALIZER = 'Unable to load "Initializer" [error_location=%s]',
		EXE_NOTINITIALIZER_MODULEINIT = 'Unable to load "Initializer.modulesInit" [error_location=%s]',
		
		EXE_ERR_PCALL= 'An error ocurred from the Pcall [error_location="%s" callee_module="%s" callee_function ="%s", caller_module="%s"] \n %s',
	},
	
	ModuleRegistry = {
		MREG_MOD_TBL_EMPTY = '[MODULE REGISTRY] modulesCache table is empty [caller_module="%s"]',
		
		MREG_MOD_ALREADY_REGI = '[MODULE REGISTRY] Module "%s" already registered [caller="%s"]',
		
		MREG_FAIL_GET = '[MODULE REGISTRY] Unable to get the module "%s" [caller_module="%s"]',
		MREG_GET_ML_EMPTY = '[MODULE REGISTRY] ModuleList is empty [caller_module="%s"]',
		
		MREG_RMV_NO_MOD_REGI = '[MODULE REGISTRY] Unable to remove the module "%s" : indexed nil [caller_module="%s"]',
		
		MREG_REG_CLEAR = '[MODULE REGISTRY] Modules registry has been cleared [caller="%s"]'
	}
}


return Warns
