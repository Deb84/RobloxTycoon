build = workspace.Build
local droppers_list = require(script.Parent.DroppersList)
DroppedParts = Instance.new('Folder')
DroppedParts.Name = 'DroppedParts'
DroppedParts.Parent = workspace
TycoonBasePlate = workspace.Build.TycoonBaseplate




local function dropper(dropper_id)
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
				print('a')


				local it = 0
				if not dropper.state then
					dropper.state = true
				
					while dropper.state do

						task.wait(dropper.speed)
						local new_part = dropper.partModel:Clone()
						
						local newPartChildren = new_part:GetChildren()
						if #newPartChildren > 2 then
							for i, part in pairs(newPartChildren) do
								if part:IsA('MeshPart') and part ~= new_part.PrimaryPart then
									local weld = Instance.new('WeldConstraint')
									weld.Part0 = new_part.PrimaryPart
									weld.Part1 = part
									weld.Parent = new_part.PrimaryPart
								end

							end

							
						end
			
						new_part.Parent = DroppedParts
						new_part:PivotTo(extruder.CFrame * dropper.partSpawnPos)
						
					end
				end
			end
		end
		
		
		
		if not dropper.spawned then
			
			dropper_model.Parent = TycoonBasePlate
			
			local baseplatePart = TycoonBasePlate.BaseplateBuild
			
			
			local offsetY = baseplatePart.Size.Y / 2 + dropper_model:GetExtentsSize().Y / 2
			dropper_model:PivotTo(baseplatePart.CFrame * dropper.position)
			
			dropper.spawned = true
			spawn_part()
		else
			spawn_part()	
		end
		
		
	
end


local eventPlatePressed = game.ServerScriptService.Events.PlatesPressedEvent
eventPlatePressed.Event:Connect(function(message)
	print('b')
	if message.plateType == 'Default' then
		if message.targetId then
			
			print('c')
			dropper(message.targetId)
			task.wait(3)
		end
	end
end)
