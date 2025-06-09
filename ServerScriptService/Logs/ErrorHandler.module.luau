local ErrorHandler = {}


local function makeErrorHandler(logFunc)
	return function(err)
		logFunc(err)
		print(debug.traceback())
	end
end

ErrorHandler.warnHandler = makeErrorHandler(warn)
ErrorHandler.errorHandler = makeErrorHandler(error)
ErrorHandler.printHandler = makeErrorHandler(print)

	
return ErrorHandler
