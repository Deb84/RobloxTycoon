local Errors = {}

Errors.globals = {
	
}

Errors.executor = {
	-- FORMAT = '[error_location="%s" callee_module="%s" callee_function ="%s", caller_module="%s"]',
	NO_WARNS = 'Unable to load "Warns" [error_location=%s]',
	NO_WARNS_EXECUTOR = 'Unable to load Warns.executor [error_location=%s]',
	NO_REGISTRY = 'Unable to load "moduleRegistry" [error_location=%s]',
	
	NO_MSG = 'Message missing for "%s" from "%s"',
	MSG_ISNT_TABLE = `Message is'nt a table [error_location="%s" caller_module="%s"]`,
	NO_MODULE_IN_MSG = 'Module missing [error_location="%s" caller_module="%s"]',
	NO_FUNC_IN_MSG = 'Function missing for "%s" from "%s"',
	ARGS_NIL = 'Args required but indexed "nil" [module:%s/targetFunction:%s/caller:%s]',
	
	MODULE_NO_REG_INIT_FALSE = 'Module "%s" is unregistered and not initialized [error_location="%s" callee_module="%s" callee_function ="%s", caller_module="%s"]',
	MODULE_NO_INIT = 'Unable to initialize the module "%s" [error_location="%s" callee_module="%s" callee_function ="%s", caller_module="%s"]',
	
	ARGS_NOT_TABLE = 'Args are not a table [error_location="%s" callee_module="%s" callee_function ="%s", caller_module="%s"]',
	
	FUNC_DOESNT_EXISTS = 'Unable to get the function "s%" [error_location="%s" callee_module="%s" callee_function ="%s", caller_module="%s"]',
	
	NO_MODULE = 'Unable to get the module "%s" [error_location="%s" callee_module="%s" callee_function ="%s", caller_module="%s"]',
	
	ERR_PCALL= 'An error ocurred from the Pcall [error_location="%s" callee_module="%s" callee_function ="%s", caller_module="%s"] \n %s',
	
	NO_RESULT = 'Result expected but indexed nil [error_location="%s" callee_module="%s" callee_function ="%s", caller_module="%s"]'
}

return Errors
