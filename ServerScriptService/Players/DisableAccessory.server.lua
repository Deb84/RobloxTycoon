Players = game:GetService('Players')

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)

		for _, child in pairs(character:GetChildren()) do

			if child:IsA('Accessory') then
				for _, secondChild in child:GetChildren() do
					if secondChild:IsA('Part') or secondChild:IsA('MeshPart') then
						secondChild.CanCollide = false
						secondChild.CanTouch = false
					end
				end
			end
		end
	end)
end)
