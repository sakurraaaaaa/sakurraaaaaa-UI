--[[ 
    🌸 SAKURAAAAA UI V16.5 - Ultra Small Classic Executor
    Minimal Size • Big Code Box • Smooth • Bottom-Right Notification
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer

-- Theme
local Theme = {
    Main = Color3.fromRGB(18, 15, 24),
    Dark = Color3.fromRGB(26, 22, 33),
    Accent = Color3.fromRGB(255, 140, 185),   -- Soft sakura pink
    Glow = Color3.fromRGB(255, 205, 230),
    Text = Color3.fromRGB(255, 245, 255),
}

-- Cleanup
for _, v in pairs(CoreGui:GetChildren()) do
    if v.Name == "SakurraaaaaaUI" then v:Destroy() end
end

local Screen = Instance.new("ScreenGui")
Screen.Name = "SakurraaaaaaUI"
Screen.Parent = CoreGui
Screen.IgnoreGuiInset = true
Screen.ResetOnSpawn = false

-- ULTRA SMALL MAIN FRAME
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Parent = Screen
Main.BackgroundColor3 = Theme.Main
Main.BackgroundTransparency = 0.12
Main.Position = UDim2.new(0.5, -310, 0.5, -205)
Main.Size = UDim2.new(0, 620, 0, 410)   -- Much smaller now
Main.Active = true
Main.ClipsDescendants = true

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 16)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Theme.Accent
Stroke.Thickness = 1.6

-- Breathing glow
task.spawn(function()
    while Main.Parent do
        TweenService:Create(Stroke, TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Transparency = 0.3}):Play()
        task.wait(8)
    end
end)

-- Minimal Top Bar
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 42)
TopBar.BackgroundColor3 = Theme.Dark
TopBar.BackgroundTransparency = 0.45
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 16)

local Title = Instance.new("TextLabel", TopBar)
Title.Text = "sakex"
Title.Font = Enum.Font.GothamBlack
Title.TextColor3 = Theme.Accent
Title.TextSize = 21
Title.Position = UDim2.new(0, 16, 0.5, -10)
Title.BackgroundTransparency = 1

local Clock = Instance.new("TextLabel", TopBar)
Clock.Size = UDim2.new(0.4, 0, 1, 0)
Clock.Position = UDim2.new(0.58, 0, 0, 0)
Clock.Font = Enum.Font.Code
Clock.TextColor3 = Theme.Accent
Clock.TextSize = 14.5
Clock.TextXAlignment = Enum.TextXAlignment.Right
Clock.BackgroundTransparency = 1

RunService.Heartbeat:Connect(function()
    Clock.Text = os.date("%I:%M") .. " 🌸"
end)

-- Big Code Box (Classic Executor Style)
local CodeBox = Instance.new("TextBox", Main)
CodeBox.Size = UDim2.new(0.96, 0, 0, 255)
CodeBox.Position = UDim2.new(0.02, 0, 0, 55)
CodeBox.BackgroundColor3 = Theme.Dark
CodeBox.BackgroundTransparency = 0.4
CodeBox.MultiLine = true
CodeBox.ClearTextOnFocus = false
CodeBox.Text = "-- 🌸 SAKURAAAAA UI Loaded\n-- Paste script here and hit EXECUTE"
CodeBox.Font = Enum.Font.Code
CodeBox.TextColor3 = Theme.Text
CodeBox.TextSize = 15
CodeBox.TextXAlignment = Enum.TextXAlignment.Left
CodeBox.TextYAlignment = Enum.TextYAlignment.Top
CodeBox.TextWrapped = true
Instance.new("UICorner", CodeBox).CornerRadius = UDim.new(0, 12)

-- Buttons
local ExecuteBtn = Instance.new("TextButton", Main)
ExecuteBtn.Size = UDim2.new(0.47, 0, 0, 45)
ExecuteBtn.Position = UDim2.new(0.02, 0, 0, 325)
ExecuteBtn.BackgroundColor3 = Theme.Accent
ExecuteBtn.Text = "EXECUTE"
ExecuteBtn.Font = Enum.Font.GothamBold
ExecuteBtn.TextColor3 = Color3.new(0,0,0)
ExecuteBtn.TextSize = 18
Instance.new("UICorner", ExecuteBtn).CornerRadius = UDim.new(0, 11)

ExecuteBtn.MouseButton1Click:Connect(function()
    local success, err = pcall(function()
        loadstring(CodeBox.Text)()
    end)
    if success then
        print("🌸 Executed")
    else
        warn("[SAKURAAAAA] Error: " .. tostring(err))
    end
end)

local ClearBtn = Instance.new("TextButton", Main)
ClearBtn.Size = UDim2.new(0.47, 0, 0, 45)
ClearBtn.Position = UDim2.new(0.51, 0, 0, 325)
ClearBtn.BackgroundColor3 = Theme.Dark
ClearBtn.Text = "CLEAR"
ClearBtn.Font = Enum.Font.GothamBold
ClearBtn.TextColor3 = Theme.Accent
ClearBtn.TextSize = 17
Instance.new("UICorner", ClearBtn).CornerRadius = UDim.new(0, 11)

ClearBtn.MouseButton1Click:Connect(function()
    CodeBox.Text = ""
end)

-- Smooth Drag
local dragging, dragStart, startPos = false
Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

-- F to Toggle
local uiVisible = true
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.F then
        uiVisible = not uiVisible
        if uiVisible then
            Main.Visible = true
            TweenService:Create(Main, TweenInfo.new(0.3), {BackgroundTransparency = 0.12}):Play()
        else
            TweenService:Create(Main, TweenInfo.new(0.25), {BackgroundTransparency = 1}):Play()
            task.wait(0.28)
            Main.Visible = false
        end
    end
end)

-- Real Roblox-style Badge Notification (Bottom Right Corner)
local function ShowNotification()
    local Notif = Instance.new("Frame")
    Notif.Size = UDim2.new(0, 260, 0, 68)
    Notif.Position = UDim2.new(1, 20, 1, -90)   -- Start off-screen right bottom
    Notif.BackgroundColor3 = Color3.fromRGB(30, 25, 35)
    Notif.BackgroundTransparency = 0.1
    Notif.Parent = Screen
    Instance.new("UICorner", Notif).CornerRadius = UDim.new(0, 12)

    local Icon = Instance.new("ImageLabel", Notif)
    Icon.Size = UDim2.new(0, 38, 0, 38)
    Icon.Position = UDim2.new(0, 12, 0.5, -19)
    Icon.BackgroundTransparency = 1
    Icon.Image = "rbxassetid://7071759179"  -- Pink sakura petal
    Instance.new("UICorner", Icon).CornerRadius = UDim.new(1, 0)

    local Label = Instance.new("TextLabel", Notif)
    Label.Text = "SAKURAAAAA UI\nLoaded Successfully! 🌸"
    Label.Font = Enum.Font.GothamSemibold
    Label.TextColor3 = Theme.Accent
    Label.TextSize = 15
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextYAlignment = Enum.TextYAlignment.Center
    Label.Position = UDim2.new(0, 62, 0, 0)
    Label.Size = UDim2.new(1, -80, 1, 0)
    Label.BackgroundTransparency = 1

    -- Slide in from right
    TweenService:Create(Notif, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {
        Position = UDim2.new(1, -280, 1, -90)
    }):Play()

    -- Auto hide after 3.5 seconds
    task.delay(3.5, function()
        if Notif.Parent then
            TweenService:Create(Notif, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {
                Position = UDim2.new(1, 20, 1, -90),
                BackgroundTransparency = 1
            }):Play()
            task.wait(0.8)
            Notif:Destroy()
        end
    end)
end

-- Intro Animation + Notification
Main.BackgroundTransparency = 1
Main.Position = UDim2.new(0.5, -310, 0.7, 0)

TweenService:Create(Main, TweenInfo.new(0.85, Enum.EasingStyle.Quint), {
    BackgroundTransparency = 0.12,
    Position = UDim2.new(0.5, -310, 0.5, -205)
}):Play()

task.wait(0.7)
ShowNotification()

print("🌸 SAKURAAAAA UI V16.5 Loaded - Ultra Small Classic Edition")
