local Players = game:GetService('Players')

local beltUtils = {}


function beltUtils.belt(config, part, baseplate)

	part.Touched:Connect(function(other_part)
		if not other_part:FindFirstChild('ConveyorVelocity') then
			
			local character = other_part:FindFirstAncestorOfClass("Model")
			local playerTouched = character and Players:GetPlayerFromCharacter(character)
			
			local function applyVelocity()

					local attachement = Instance.new('Attachment')
					attachement.Name = 'ConveyorVelocity'

					local lv = Instance.new('LinearVelocity')
					lv.Attachment0 = attachement
					lv.RelativeTo = Enum.ActuatorRelativeTo.World

					local WorldRelativeConveyor = part.CFrame.LookVector
					local LocalRelativeBaseplate = baseplate.BaseplateBuild.CFrame:VectorToObjectSpace(WorldRelativeConveyor)

					if config.directionInv then
						lv.VectorVelocity = Vector3.new(LocalRelativeBaseplate.Z,0,LocalRelativeBaseplate.X) * config.speed  --need to inverse X and Y
					else
						lv.VectorVelocity = Vector3.new(-LocalRelativeBaseplate.Z,0,-LocalRelativeBaseplate.X) * config.speed
					end
					lv.MaxForce = 1e5
					lv.Parent = attachement
					attachement.Parent = other_part
			
			end
			
			if config.playerAllowed and playerTouched then
				applyVelocity()
			elseif not playerTouched then
				applyVelocity()
			end

		end
	end)

	part.TouchEnded:Connect(function(other_part)
		if other_part:FindFirstChild('ConveyorVelocity') then
			other_part.ConveyorVelocity:Destroy()
		end
	end)
end

return beltUtils
