--// ZASZ HUB DELTA FIX

repeat task.wait() until game.Players.LocalPlayer.Character

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- SETTINGS
local Settings = {
    Hitbox = 10,
    ESP = false
}

-- GUI (FIXED)
local gui = Instance.new("ScreenGui")
gui.Name = "ZASZ HUB"
gui.Parent = player:WaitForChild("PlayerGui")

-- MAIN FRAME
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 300, 0, 360)
main.Position = UDim2.new(0, 50, 0.2, 0)
main.BackgroundColor3 = Color3.fromRGB(20,20,25)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

-- TITLE
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,40)
title.Text = "ZASZ HUB"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(0,255,200)
title.TextScaled = true

-- HITBOX LABEL
local label = Instance.new("TextLabel", main)
label.Position = UDim2.new(0,10,0,60)
label.Size = UDim2.new(1,-20,0,20)
label.Text = "Hitbox: 10"
label.TextColor3 = Color3.new(1,1,1)
label.BackgroundTransparency = 1

-- SLIDER
local bar = Instance.new("Frame", main)
bar.Position = UDim2.new(0,10,0,90)
bar.Size = UDim2.new(1,-20,0,10)
bar.BackgroundColor3 = Color3.fromRGB(40,40,40)
Instance.new("UICorner", bar)

local fill = Instance.new("Frame", bar)
fill.Size = UDim2.new(0.1,0,1,0)
fill.BackgroundColor3 = Color3.fromRGB(0,255,200)
Instance.new("UICorner", fill)

local dragging = false

bar.InputBegan:Connect(function(i)
    if i.UserInputType.Name:find("Mouse") or i.UserInputType.Name=="Touch" then
        dragging = true
    end
end)

bar.InputEnded:Connect(function()
    dragging = false
end)

bar.InputChanged:Connect(function(i)
    if dragging then
        local pos = (i.Position.X - bar.AbsolutePosition.X)/bar.AbsoluteSize.X
        pos = math.clamp(pos,0,1)
        fill.Size = UDim2.new(pos,0,1,0)
        Settings.Hitbox = math.floor(5 + (95*pos))
        label.Text = "Hitbox: "..Settings.Hitbox
    end
end)

-- ESP BUTTON
local espBtn = Instance.new("TextButton", main)
espBtn.Position = UDim2.new(0,10,0,140)
espBtn.Size = UDim2.new(1,-20,0,40)
espBtn.Text = "ESP OFF"
espBtn.BackgroundColor3 = Color3.fromRGB(30,30,35)
espBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", espBtn)

espBtn.MouseButton1Click:Connect(function()
    Settings.ESP = not Settings.ESP
    espBtn.Text = Settings.ESP and "ESP ON" or "ESP OFF"
end)

-- ESP SYSTEM
local function applyESP(plr)
    if plr == player then return end

    plr.CharacterAdded:Connect(function(char)
        local head = char:WaitForChild("Head",5)
        if not head then return end

        local bill = Instance.new("BillboardGui", head)
        bill.Size = UDim2.new(0,100,0,40)
        bill.AlwaysOnTop = true

        local txt = Instance.new("TextLabel", bill)
        txt.Size = UDim2.new(1,0,1,0)
        txt.BackgroundTransparency = 1
        txt.TextColor3 = Color3.fromRGB(0,255,200)
        txt.TextScaled = true

        RunService.RenderStepped:Connect(function()
            if not Settings.ESP then
                bill.Enabled = false
                return
            end

            bill.Enabled = true
            txt.Text = plr.Name
        end)

        -- skeleton glow
        for _,v in pairs(char:GetChildren()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.Neon
                v.Transparency = 0.3
            end
        end
    end)
end

for _,p in pairs(Players:GetPlayers()) do
    applyESP(p)
end
Players.PlayerAdded:Connect(applyESP)

-- HITBOX LOOP
RunService.RenderStepped:Connect(function()
    for _,p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.Size = Vector3.new(Settings.Hitbox, Settings.Hitbox, Settings.Hitbox)
                hrp.Transparency = 0.6
                hrp.CanCollide = false
            end
        end
    end
end)
``
