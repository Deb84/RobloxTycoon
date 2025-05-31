local build = workspace.Build
local droppers_list = require(script.Parent.DroppersList)
local workspaceTeams = workspace:WaitForChild('Teams')


local function dropper(dropper_id, baseplate, team)
		local DroppedParts = workspaceTeams:WaitForChild(team.name):WaitForChild('DroppedParts')
		local dropper = droppers_list[dropper_id]

		local dropper_model = dropper.model:Clone()
		local dropper_child = dropper_model:GetChildren()
		local extruder

		for i, parts in pairs(dropper_child) do
			parts.Anchored = true

			if parts.Name == dropper.partSpawnPart then
				extruder = parts
			end
		end
		
		local function spawn_part()
			if dropper.spawned then

				if not dropper.state then
					dropper.state = true
				
					while dropper.state do

						task.wait(dropper.speed)
						local new_part = dropper.partModel:Clone()
						
						local newPartChildren = new_part:GetChildren()
						
						for i, part in pairs(newPartChildren) do
							part:SetAttribute('Team', team.name)
							part:SetAttribute('CoinsValue', dropper.partValue)
							part:SetAttribute('IsADroppedPart', true)
							
							if #newPartChildren > 2 then
								
								if part:IsA('MeshPart') and part ~= new_part.PrimaryPart then
									local weld = Instance.new('WeldConstraint')
									weld.Part0 = new_part.PrimaryPart
									weld.Part1 = part
									weld.Parent = new_part.PrimaryPart
								end
							end
						end
						
						new_part:SetAttribute('Team', team.name)
						new_part:SetAttribute('CoinsValue', dropper.partValue)
						new_part.Parent = DroppedParts
						new_part:PivotTo(extruder.CFrame * dropper.partSpawnPos)
						
					end
				end
			end
		end
		
		
		if not dropper.spawned then
			
			dropper_model:SetAttribute('Team', team.name)
			dropper_model.Parent = baseplate.Parent
			
			local baseplatePart = baseplate.BaseplateBuild
			
			local offsetY = baseplatePart:GetPivot().Y + (baseplatePart.Size.Y / 2) + (dropper_model.PrimaryPart.Size.Y / 2)
			dropper_model:PivotTo(CFrame.new(baseplatePart.CFrame.X,offsetY,baseplatePart.CFrame.Z) * dropper.position)
				
				
				dropper.spawned = true
			spawn_part()
		else
			spawn_part()	
		end	
end


local eventPlatePressed = game.ServerScriptService.Events.Spawn.DroppersSpawn
eventPlatePressed.Event:Connect(function(message)
	if message.plateType == 'Default' then
		if message.targetId then

			dropper(message.targetId, message.baseplate, message.team)
			task.wait(3)
		end
	end
end)
