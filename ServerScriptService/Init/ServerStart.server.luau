local SSS = game:GetService('ServerScriptService')
local ModuleList = require(SSS.ModuleRouter.ModuleList)
local MLM = require(SSS.ModuleRouter.ModuleListManager)
local LogMsg = require(SSS.Logs.LogsMessagesManager)
LogMsg.init()
MLM.init(ModuleList)


local Router = require(MLM.getModulePath('ModuleRouter'))
Router.modulesInit(script.Name, {'TeamsList', 'InstanceRegistry'})
Router.modulesInit(script.Name, 'TeamsHandler')
Router.modulesInit(script.Name, 'TeamsHandler')
TeamsHandler = Router.getModule(script.Name, 'TeamsHandler')
--error(LMM.get('error', 'EXE_NO_WARNS', script.Name))
MR = require(MLM.getModulePath('ModuleRegistry'))

--local ModuleAssertion = require(ServerScriptService.Init.ServerStart.ModuleAssertion)
--assert(ModuleAssertion and ModuleAssertion.ModuleAssertion)

Router.modulesInit(script.Name, 'InstanceRegistry')

local FolderInit = require(script.FoldersInit)



local TeamsList = Router.getModulesAndInit(script.Name, 'TeamsList')

FolderInit.GameScriptFolderInit()
FolderInit.TeamsWorkspaceFolder()
TeamsHandler.teamsInit(TeamsList)







