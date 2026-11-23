
-- SoccerSystem.lua
-- Goalkeeper movement boost
-- Client-side code

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

local BOOST_SPEED = 35
local BOOST_DURATION = 0.25
local COOLDOWN = 1

local onCooldown = false

local function boost()
    if onCooldown then return end

    local character = player.Character
    if not character then return end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")

    if not humanoid or not root then return end

    local direction = humanoid.MoveDirection
    if direction.Magnitude < 0.1 then return end

    onCooldown = true

    local velocity = Instance.new("BodyVelocity")
    velocity.MaxForce = Vector3.new(100000, 0, 100000)
    velocity.Velocity = direction.Unit * BOOST_SPEED
    velocity.Parent = root

    task.delay(BOOST_DURATION, function()
        velocity:Destroy()
    end)

    task.delay(COOLDOWN, function()
        onCooldown = false
    end)
end

UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.V then
        boost()
    end
end)

print("[SoccerSystem] Loaded!")
