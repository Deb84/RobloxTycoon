local player = game.Players.LocalPlayer
local ContextActionService = game:GetService("ContextActionService")
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local defaultSpeed = 16
local sprintSpeed = 50


local function sprint(actionName, inputState)
	if inputState == Enum.UserInputState.Begin then
		humanoid.WalkSpeed = sprintSpeed 
	end
	if inputState == Enum.UserInputState.End then
		humanoid.WalkSpeed = defaultSpeed 
	end
	
end

ContextActionService:BindAction('Sprint', sprint, true, Enum.KeyCode.LeftShift)
