local ServerScriptService = game:GetService('ServerScriptService')
local build = workspace.Build
local droppers_list = require(script.Parent.DroppersList)
local PlacementUtils = require(ServerScriptService.Utils.PlacementUtils)
local ModuleRouter = require(ServerScriptService.Utils.ModuleRouter)
local workspaceTeams = workspace:WaitForChild('Teams')
local droppers = {}



function droppers.dropperSpawn(dropper_id, baseplate, team)
	local DroppedParts = workspaceTeams:WaitForChild(team.name).DroppedParts
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

					for _, part in pairs(newPartChildren) do
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

		local offsetY = PlacementUtils.offsetY(baseplate, dropper_model)
		dropper_model:PivotTo(offsetY * dropper.position)


		dropper.spawned = true
		spawn_part()
	else
		spawn_part()	
	end	
end


return droppers
