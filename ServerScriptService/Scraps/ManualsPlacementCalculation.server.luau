local baseplate = workspace.Build.TycoonBaseplate.BaseplateBuild 
local model = workspace.Build.Conveyor1

local baseplatePivot = baseplate:GetPivot()
local modelPivot = model:GetPivot()

local offsetCFrame = baseplatePivot:Inverse() * modelPivot

local baseplateHeight = baseplate.Size.Y
local modelHeight = model:GetExtentsSize().Y
local heightOffset = (baseplateHeight / 2) + (modelHeight / 2)

-- Corrige la hauteur en soustrayant ce heightOffset
local correctedY = offsetCFrame.Y - heightOffset

print(string.format("config.position = CFrame.new(%.3f, %.3f, %.3f) * CFrame.Angles(%.3f, %.3f, %.3f)",
	offsetCFrame.X, correctedY, offsetCFrame.Z,
	offsetCFrame:ToEulerAnglesXYZ()))
