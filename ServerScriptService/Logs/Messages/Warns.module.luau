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
	
	
	Executor = {
		NOT_INITIALIZER = 'Unable to load "Initializer" [error_location=%s]',
		NOTINITIALIZER_MODULEINIT = 'Unable to load "Initializer.modulesInit" [error_location=%s]',
		
		ERR_PCALL= 'An error ocurred from the Pcall [error_location="%s" callee_module="%s" callee_function ="%s", caller_module="%s"] \n %s',
	}
}


return Warns
