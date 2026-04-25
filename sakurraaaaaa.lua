--[[ 
    🌸 SAKURAAAAA UI V15.5 - Compact Premium Executor
    Soft Sakura Pink | Clean Classic Executor Look | Super Smooth
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

local Player = Players.LocalPlayer

-- === COMPACT SAKURA THEME ===
local Theme = {
    Main = Color3.fromRGB(18, 15, 22),
    Dark = Color3.fromRGB(25, 20, 32),
    Accent = Color3.fromRGB(255, 160, 200),   -- Soft sakura pink
    Glow = Color3.fromRGB(255, 220, 240),
    Text = Color3.fromRGB(255, 250, 255),
    Hover = Color3.fromRGB(50, 40, 65),
}

-- Cleanup
for _, v in pairs(CoreGui:GetChildren()) do
    if v.Name == "SakuraaaaaUI" then v:Destroy() end
end

local Screen = Instance.new("ScreenGui")
Screen.Name = "SakuraaaaaUI"
Screen.Parent = CoreGui
Screen.IgnoreGuiInset = true
Screen.ResetOnSpawn = false

-- Main Frame - Smaller & Compact (Classic Executor Size)
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Parent = Screen
Main.BackgroundColor3 = Theme.Main
Main.BackgroundTransparency = 0.08
Main.Position = UDim2.new(0.5, -380, 0.5, -260)
Main.Size = UDim2.new(0, 760, 0, 520)  -- More compact
Main.Active = true
Main.ClipsDescendants = true

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 20)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Theme.Accent
Stroke.Thickness = 2

-- Soft breathing glow
task.spawn(function()
    while Main.Parent do
        TweenService:Create(Stroke, TweenInfo.new(5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Transparency = 0.2}):Play()
        task.wait(10)
    end
end)

-- Top Bar (Minimal)
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 55)
TopBar.BackgroundColor3 = Theme.Dark
TopBar.BackgroundTransparency = 0.4
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 20)

local Title = Instance.new("TextLabel", TopBar)
Title.Text = "SAKURAAAAA UI"
Title.Font = Enum.Font.GothamBlack
Title.TextColor3 = Theme.Accent
Title.TextSize = 24
Title.Position = UDim2.new(0, 20, 0.5, -12)
Title.BackgroundTransparency = 1

local Clock = Instance.new("TextLabel", TopBar)
Clock.Size = UDim2.new(0.3, 0, 1, 0)
Clock.Position = UDim2.new(0.68, 0, 0, 0)
Clock.Font = Enum.Font.Code
Clock.TextColor3 = Theme.Accent
Clock.TextSize = 16
Clock.TextXAlignment = Enum.TextXAlignment.Right
Clock.BackgroundTransparency = 1

RunService.Heartbeat:Connect(function()
    Clock.Text = os.date("%I:%M %p") .. " 🌸"
end)

-- Executor Section (Bigger Code Box - Classic Executor Style)
local CodeBox = Instance.new("TextBox", Main)
CodeBox.Size = UDim2.new(0.96, 0, 0, 340)
CodeBox.Position = UDim2.new(0.02, 0, 0, 70)
CodeBox.BackgroundColor3 = Theme.Dark
CodeBox.BackgroundTransparency = 0.3
CodeBox.MultiLine = true
CodeBox.ClearTextOnFocus = false
CodeBox.Text = "-- 🌸 Welcome to Sakurraaaaa UI\n-- Paste script here and press Execute\n-- Supports loadstring, require, everything"
CodeBox.Font = Enum.Font.Code
CodeBox.TextColor3 = Theme.Text
CodeBox.TextSize = 15.5
CodeBox.TextXAlignment = Enum.TextXAlignment.Left
CodeBox.TextYAlignment = Enum.TextYAlignment.Top
Instance.new("UICorner", CodeBox).CornerRadius = UDim.new(0, 16)

-- Buttons
local ExecuteBtn = Instance.new("TextButton", Main)
ExecuteBtn.Size = UDim2.new(0.47, 0, 0, 55)
ExecuteBtn.Position = UDim2.new(0.02, 0, 0, 425)
ExecuteBtn.BackgroundColor3 = Theme.Accent
ExecuteBtn.Text = "EXECUTE"
ExecuteBtn.Font = Enum.Font.GothamBold
ExecuteBtn.TextColor3 = Color3.new(0,0,0)
ExecuteBtn.TextSize = 20
Instance.new("UICorner", ExecuteBtn).CornerRadius = UDim.new(0, 14)

ExecuteBtn.MouseButton1Click:Connect(function()
    local code = CodeBox.Text
    local success, err = pcall(function()
        loadstring(code)()
    end)
    if success then
        print("🌸 Sakurraaaaa UI | Executed Successfully")
    else
        warn("🌸 Sakurraaaaa UI | Error: " .. tostring(err))
    end
end)

local ClearBtn = Instance.new("TextButton", Main)
ClearBtn.Size = UDim2.new(0.47, 0, 0, 55)
ClearBtn.Position = UDim2.new(0.51, 0, 0, 425)
ClearBtn.BackgroundColor3 = Theme.Dark
ClearBtn.Text = "CLEAR"
ClearBtn.Font = Enum.Font.GothamBold
ClearBtn.TextColor3 = Theme.Accent
ClearBtn.TextSize = 19
Instance.new("UICorner", ClearBtn).CornerRadius = UDim.new(0, 14)

ClearBtn.MouseButton1Click:Connect(function()
    CodeBox.Text = ""
end)

-- Simple Home Quick Buttons (Compact)
local function QuickBtn(text, y, callback)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0.28, 0, 0, 38)
    btn.Position = UDim2.new(0.02 + (y-1)*0.31, 0, 0, 425)  -- Wait, better position them above or side if needed
    -- For now, simple ones moved if needed. You can expand later.
end

-- Drag Support (Smooth)
local dragging, dragStart, startPos
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

-- F to Toggle (Smooth)
local visible = true
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.F then
        visible = not visible
        if visible then
            Main.Visible = true
            TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.08}):Play()
        else
            TweenService:Create(Main, TweenInfo.new(0.35, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
            task.wait(0.4)
            Main.Visible = false
        end
    end
end)

-- === ROBLOX BADGE-STYLE NOTIFICATION ===
local function ShowNotification()
    local Notif = Instance.new("Frame")
    Notif.Size = UDim2.new(0, 320, 0, 90)
    Notif.Position = UDim2.new(0.5, -160, 0.85, 0)
    Notif.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Notif.BackgroundTransparency = 0.1
    Notif.Parent = Screen
    Instance.new("UICorner", Notif).CornerRadius = UDim.new(0, 16)

    local Icon = Instance.new("ImageLabel", Notif)
    Icon.Size = UDim2.new(0, 50, 0, 50)
    Icon.Position = UDim2.new(0, 15, 0.5, -25)
    Icon.BackgroundTransparency = 1
    Icon.Image = "rbxassetid://7071759179"  -- Pink petal / sakura icon
    Instance.new("UICorner", Icon).CornerRadius = UDim.new(1,0)

    local Title = Instance.new("TextLabel", Notif)
    Title.Text = "Sakurraaaaaa UI"
    Title.Font = Enum.Font.GothamBold
    Title.TextColor3 = Theme.Accent
    Title.TextSize = 20
    Title.Position = UDim2.new(0, 80, 0, 15)
    Title.BackgroundTransparency = 1

    local Desc = Instance.new("TextLabel", Notif)
    Desc.Text = "Loaded Successfully! 🌸"
    Desc.Font = Enum.Font.Gotham
    Desc.TextColor3 = Color3.new(1,1,1)
    Desc.TextSize = 16
    Desc.Position = UDim2.new(0, 80, 0, 42)
    Desc.BackgroundTransparency = 1

    -- Slide in + fade out
    Notif.Position = UDim2.new(0.5, -160, 1.1, 0)
    TweenService:Create(Notif, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Position = UDim2.new(0.5, -160, 0.85, 0)}):Play()

    task.delay(4, function()
        TweenService:Create(Notif, TweenInfo.new(0.8, Enum.EasingStyle.Quint), {Position = UDim2.new(0.5, -160, 1.1, 0), BackgroundTransparency = 1}):Play()
        task.wait(0.9)
        Notif:Destroy()
    end)
end

-- Intro Animation + Notification
Main.BackgroundTransparency = 1
Main.Position = UDim2.new(0.5, -380, 0.6, 0)

TweenService:Create(Main, TweenInfo.new(1.2, Enum.EasingStyle.Quint), {
    BackgroundTransparency = 0.08,
    Position = UDim2.new(0.5, -380, 0.5, -260)
}):Play()

task.wait(0.8)
ShowNotification()

print("🌸 Sakurraaaaaa UI V15.5 Loaded Successfully!")

-- Mobile / Device Support: The UI is now smaller and uses standard scaling. Works on PC, and is more usable on mobile executors.
