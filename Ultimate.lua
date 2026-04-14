local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/7Library/UI/main/Library.lua"))()
local Window = Library:CreateWindow("CyberZ Premium", "Hitbox & Utility")

local Tab = Window:CreateTab("Main Cheats")

local Settings = {
    HitboxSize = 2,
    HitboxTransparency = 0.5,
    SpeedValue = 16,
    SkeletonESP = false
}

-- Hitbox Expander
Tab:CreateSlider("Hitbox Size", 0, 300, 2, function(val)
    Settings.HitboxSize = val
end)

-- Hitbox Transparency
Tab:CreateSlider("Hitbox Transparency %", 0, 100, 50, function(val)
    Settings.HitboxTransparency = val / 100
end)

-- Speed Changer
Tab:CreateSlider("WalkSpeed", 0, 200, 16, function(val)
    Settings.SpeedValue = val
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = val
end)

-- Skeleton ESP Toggle
Tab:CreateToggle("Skeleton ESP", function(state)
    Settings.SkeletonESP = state
end)

-- Main Loop
task.spawn(function()
    while task.wait(0.1) do
        for _, v in pairs(game:GetService("Players"):GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = v.Character.HumanoidRootPart
                hrp.Size = Vector3.new(Settings.HitboxSize, Settings.HitboxSize, Settings.HitboxSize)
                hrp.Transparency = Settings.HitboxTransparency
                hrp.BrickColor = BrickColor.new("Really blue")
                hrp.Material = Enum.Material.Neon
                hrp.CanCollide = false
            end
        end
        
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = Settings.SpeedValue
        end
    end
end)

-- Skeleton ESP Logic
local function createSkeleton(char)
    local connections = {
        {"Head", "UpperTorso"}, {"UpperTorso", "LowerTorso"},
        {"UpperTorso", "LeftUpperArm"}, {"LeftUpperArm", "LeftLowerArm"}, {"LeftLowerArm", "LeftHand"},
        {"UpperTorso", "RightUpperArm"}, {"RightUpperArm", "RightLowerArm"}, {"RightLowerArm", "RightHand"},
        {"LowerTorso", "LeftUpperLeg"}, {"LeftUpperLeg", "LeftLowerLeg"}, {"LeftLowerLeg", "LeftFoot"},
        {"LowerTorso", "RightUpperLeg"}, {"RightUpperLeg", "RightLowerLeg"}, {"RightLowerLeg", "RightFoot"}
    }
    
    task.spawn(function()
        while Settings.SkeletonESP and char.Parent do
            for _, bone in pairs(connections) do
                local p1, p2 = char:FindFirstChild(bone[1]), char:FindFirstChild(bone[2])
                if p1 and p2 then
                    -- Simple line visualization logic here or using SelectionPartLasso
                end
            end
            task.wait()
        end
    end)
end

-- GUI Show/Hide Toggle Button
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 10, 0.5, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.Text = "H"
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 20

local corner = Instance.new("UICorner", ToggleButton)
corner.CornerRadius = UDim.new(1, 0)

ToggleButton.MouseButton1Click:Connect(function()
    Library:ToggleUI()
end)
