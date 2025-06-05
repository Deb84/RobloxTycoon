local PlacementUtils = {}


function PlacementUtils.offsetY(baseModel, targetModel)
	
	if baseModel and targetModel then
		
		if baseModel.Name == 'TycoonBaseplate' then
			baseModel = baseModel:FindFirstChild('BaseplateBuild')
		end
		
		local function getSizeY(model)
			local modelSize
			
			if model:IsA('Model') then
				if model.PrimaryPart then
					modelSize = model.PrimaryPart.Size.Y
				else
					modelSize = model:GetExtentsSize().Y
				end

			elseif model:IsA('BasePart') then
				modelSize = model.Size.Y
			end
			
			return modelSize
		end
		
		local baseModelSize = getSizeY(baseModel)
		local targetModelSize = getSizeY(targetModel)
		
		if baseModelSize and targetModelSize then

			local offsetY = baseModel:GetPivot().Y + (baseModelSize /2) + (targetModelSize /2)

			if baseModel:IsA('BasePart') then			
				return CFrame.new(baseModel.CFrame.X, offsetY, baseModel.CFrame.Z)
				
			elseif baseModel:IsA('Model') then
				local baseModelPivot = baseModel:GetPivot().Position
				return CFrame.new(baseModelPivot.X, offsetY, baseModelPivot.Z)

			else 
				return nil, error('Inexpected type of baseModel')
			end
		end
	end
end


return PlacementUtils
