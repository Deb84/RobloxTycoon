local Players = game:GetService("Players")


local function leaderboardSetup(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player
	
	local coins = Instance.new('IntValue')
	coins.Name = 'Coins'
	coins.Value = 0
	coins.Parent = leaderstats
	
	local Team = Instance.new('StringValue')
	Team.Name = 'Team'
	Team.Value = 'None'
	Team.Parent = leaderstats
end


Players.PlayerAdded:Connect(leaderboardSetup)
