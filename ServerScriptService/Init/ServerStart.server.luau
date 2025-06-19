local SSS = game:GetService('ServerScriptService')
local ModuleList = require(SSS.ModuleRouter.ModuleList)
local ModuleListManager = require(SSS.ModuleRouter.ModuleListManager)
local MessagesManager = require(SSS.Logs.MessagesManager)

MessagesManager.init()
error(MessagesManager.getMessage('error', 'EXE_NO_WARNS', script.Name))

--ModuleListManager.Init(ModuleList)



--assert(ModuleList)

--local ModuleAssertion = require(ServerScriptService.Init.ServerStart.ModuleAssertion)
--assert(ModuleAssertion and ModuleAssertion.ModuleAssertion)

--local Router = require(ModuleList.getModulePath('ModuleRouter'))

--Router.modulesInit(script.Name, 'InstanceRegistry')

--local FolderInit = require(script:FindFirstChild('FoldersInit'))

--Router.modulesInit(script.Name, {'StartPlatesList', 'TeamsList'})

--local TeamsHandler = require(ModuleList.getModulePath('TeamsHandler'))




--FolderInit.GameScriptFolderInit()
--FolderInit.TeamsWorkspaceFolder()
--TeamsHandler.teamsInit()







