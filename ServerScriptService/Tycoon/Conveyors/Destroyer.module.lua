local ServerScriptService = game:GetService('ServerScriptService')
local Players = game:GetService('Players')
local Tycoon = ServerScriptService:WaitForChild('Tycoon')
local beltUtils = require(ServerScriptService.Tycoon.Conveyors.Belt)
local conveyorsList = require(Tycoon.Conveyors.ConveyorsList)
local CoinsUtils = require(ServerScriptService.Leaderboard.CoinsUtils)

local destroyer = {}


local function DestroyPart(destroyerModel, destroyerPart, team)
	
	local destroyerPart = destroyerModel:FindFirstChild(destroyerPart)
	
	if destroyerPart then

		destroyerPart.Touched:Connect(function(other_part)
			
			if other_part:GetAttribute('AlreadyChecked') ~= true then
				other_part:SetAttribute('AlreadyChecked', true)
				
				if other_part:GetAttribute('IsADroppedPart') and other_part:GetAttribute('Team') == team.name then

					local partValue = other_part:GetAttribute('CoinsValue')
					local partTeam = other_part:GetAttribute('Team')

					if partValue then
						CoinsUtils.addCoins(team.player, partValue)
					end
					
					other_part:Destroy()
				end
			end
			
			task.wait(0.1)
		end)

	end
	
end


function destroyer.Destroyer(destroyerId, baseplate, team)
	local destroyerConfig = conveyorsList.destroyerList[destroyerId]
	local destroyerModel = destroyerConfig.model:Clone()
	
	if destroyerConfig.spawned then
		DestroyPart(destroyerModel, destroyerConfig.destroyerPart, team)
	end
	
	if not destroyerConfig.spawned then
		destroyerConfig.spawned = true
	
		destroyerModel.Name = destroyerConfig.name
		
		local baseplatePart = baseplate.BaseplateBuild
		
		if destroyerModel:IsA('Model') then
			for _, part in pairs(destroyerModel:GetChildren()) do
				part:SetAttribute('Team', team.name)
				part.Anchored = true
				
				if part.Name == 'Belt' then
					beltUtils.belt(destroyerConfig, part, baseplate)
				end
			end
		end
		
		
		local offsetY = baseplatePart:GetPivot().Y + (baseplatePart.Size.Y / 2) + (destroyerModel:GetExtentsSize().Y / 2)
		destroyerModel:PivotTo(CFrame.new(baseplatePart.CFrame.X,offsetY,baseplatePart.CFrame.Z) * destroyerConfig.position)
		
		destroyerModel.Parent = baseplatePart.Parent.Parent
		
		
		DestroyPart(destroyerModel, destroyerConfig.destroyerPart, team)
	end
		
end


return destroyer
