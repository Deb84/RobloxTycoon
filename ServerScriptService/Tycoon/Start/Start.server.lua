local ServerScriptService = game:GetService('ServerScriptService')
local ServerStorage = game:GetService('ServerStorage')
local Players = game:GetService('Players')
local startPlatesList = require(ServerScriptService.Tycoon.Start.StartPlatesList)
local teamsList = require(ServerScriptService.Teams.TeamsList)
local startPlateTouchedEvent = ServerScriptService.Events.StartPlateTouched


local function teamLeaderboard(player, team)
	local leaderstats = player:WaitForChild('leaderstats')
	local leaderboardTeam = leaderstats:WaitForChild('Team')
	leaderboardTeam.Value = team.displayedName
end


if not workspace:FindFirstChild('Teams') then
	local teamsFolder = Instance.new('Folder')
	teamsFolder.Name = 'Teams'
	teamsFolder.Parent = workspace
end

local function folderInit(team)
	if not workspace:WaitForChild('Teams'):FindFirstChild(team.name) then
		local teamFolder = Instance.new('Folder')
		teamFolder.Name = team.name
		teamFolder.Parent = workspace:WaitForChild('Teams')
	end
	
	if not workspace:WaitForChild('Teams'):WaitForChild(team.name):FindFirstChild('DroppedParts') then
		local droppedPartsFolder = Instance.new('Folder')
		
		droppedPartsFolder:SetAttribute('Team', team.name)
		droppedPartsFolder.Name = 'DroppedParts'
		droppedPartsFolder.Parent = workspace:WaitForChild('Teams'):WaitForChild(team.name)
	end
	
end

for _, team in pairs(teamsList) do
	
	folderInit(team)
	
	local baseplate = team.baseplateModel:Clone()
	
	baseplate:PivotTo(team.baseplatePos)
	baseplate:SetAttribute('Team', team.name)
	
	if baseplate:IsA('Model') then
		for _, part in baseplate:GetChildren() do
			part:SetAttribute('Team', team.name)
			part.Anchored = true
		end
	elseif baseplate:IsA('BasePart') then
		baseplate.Anchored = true
	end
	
	baseplate.Parent = workspace:WaitForChild('Teams'):WaitForChild(team.name)
	
	local teamStartPlate = startPlatesList[team.name]
	local startPlate = teamStartPlate.model:Clone()
	
	if not teamStartPlate.spawned then
		
		startPlate:SetAttribute('Team', team.name)
		startPlate.Transparency = teamStartPlate.transparency
		startPlate.Color = teamStartPlate.color
		startPlate.Anchored = true
		
		local offsetY = baseplate:GetExtentsSize().Y / 2 + startPlate.Size.Y / 2
		startPlate:PivotTo(baseplate:GetPivot() * teamStartPlate.position)
		
		startPlate.Parent = baseplate
		
		if startPlate then
			
			startPlate.Touched:Connect(function(other_part)
				
				if not teamStartPlate.rebounce then
					teamStartPlate.rebounce = true
				
					local character = other_part:FindFirstAncestorOfClass("Model")
					local player = character and Players:GetPlayerFromCharacter(character)
					
					if player then
						
						teamLeaderboard(player, team)
						
						startPlate.Transparency = teamStartPlate.newTransparency
						
						team['player'] = player
						
						local message = {
							team = team,
							teamBaseplate = baseplate -- cloned model
						}
						
						startPlateTouchedEvent:Fire(message)
				
					end
					
				end
			end)
		end
	end
end


