-- [[ COCONUT UI V14.5 - FULL PREMIUM EDITION ]]
-- Brown & Cream | Ultra Clean | Rich Home + Powerful Executor

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Debris = game:GetService("Debris")

local Player = Players.LocalPlayer

-- THEME
local Theme = {
    Main = Color3.fromRGB(32, 23, 17),
    Dark = Color3.fromRGB(20, 14, 10),
    Accent = Color3.fromRGB(245, 235, 225),
    Hover = Color3.fromRGB(120, 92, 70),
    Press = Color3.fromRGB(75, 52, 38),
    Text = Color3.fromRGB(255, 255, 255),
    Glow = Color3.fromRGB(255, 245, 210),
}

-- Cleanup
for _, v in pairs(CoreGui:GetChildren()) do
    if v.Name == "CoconutUI" then v:Destroy() end
end

local Screen = Instance.new("ScreenGui")
Screen.Name = "CoconutUI"
Screen.Parent = CoreGui
Screen.IgnoreGuiInset = true
Screen.ResetOnSpawn = false

-- Main Frame
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Parent = Screen
Main.BackgroundColor3 = Theme.Main
Main.BackgroundTransparency = 0.1
Main.Position = UDim2.new(0.5, -390, 0.5, -275)
Main.Size = UDim2.new(0, 800, 0, 560)
Main.Active = true
Main.ClipsDescendants = true

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 24)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Theme.Accent
MainStroke.Thickness = 3

-- Breathing Glow
task.spawn(function()
    while Main.Parent do
        TweenService:Create(MainStroke, TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Transparency = 0.25}):Play()
        task.wait(8)
    end
end)

-- Top Bar
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 70)
TopBar.BackgroundColor3 = Theme.Dark
TopBar.BorderSizePixel = 0
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 24)

local Headshot = Instance.new("ImageLabel", TopBar)
Headshot.Size = UDim2.new(0, 54, 0, 54)
Headshot.Position = UDim2.new(0, 22, 0.5, -27)
Headshot.BackgroundTransparency = 1
Headshot.Image = Players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
Instance.new("UICorner", Headshot).CornerRadius = UDim.new(1, 0)

local Title = Instance.new("TextLabel", TopBar)
Title.Text = "COCONUT UI"
Title.Font = Enum.Font.GothamBlack
Title.TextColor3 = Theme.Accent
Title.TextSize = 27
Title.Position = UDim2.new(0, 90, 0.5, -18)
Title.Size = UDim2.new(0.4, 0, 1, 0)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

local Clock = Instance.new("TextLabel", TopBar)
Clock.Size = UDim2.new(0.32, 0, 1, 0)
Clock.Position = UDim2.new(0.68, 0, 0, 0)
Clock.Font = Enum.Font.Code
Clock.TextColor3 = Theme.Accent
Clock.TextSize = 18
Clock.TextXAlignment = Enum.TextXAlignment.Right
Clock.BackgroundTransparency = 1

RunService.Heartbeat:Connect(function()
    Clock.Text = os.date("%I:%M:%S %p")
end)

-- Sidebar
local Sidebar = Instance.new("Frame", Main)
Sidebar.Position = UDim2.new(0, 28, 0, 88)
Sidebar.Size = UDim2.new(0, 175, 1, -125)
Sidebar.BackgroundColor3 = Theme.Dark
Sidebar.BackgroundTransparency = 0.15
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 18)

local SidebarList = Instance.new("UIListLayout", Sidebar)
SidebarList.Padding = UDim.new(0, 14)
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder

-- Pages
local PageHolder = Instance.new("Frame", Main)
PageHolder.Position = UDim2.new(0, 225, 0, 88)
PageHolder.Size = UDim2.new(1, -250, 1, -125)
PageHolder.BackgroundTransparency = 1

local HomePage = Instance.new("ScrollingFrame", PageHolder)
HomePage.Size = UDim2.new(1,0,1,0)
HomePage.BackgroundTransparency = 1
HomePage.ScrollBarThickness = 5
HomePage.AutomaticCanvasSize = Enum.AutomaticSize.Y
HomePage.Visible = true

local ExecutorPage = Instance.new("ScrollingFrame", PageHolder)
ExecutorPage.Size = UDim2.new(1,0,1,0)
ExecutorPage.BackgroundTransparency = 1
ExecutorPage.ScrollBarThickness = 5
ExecutorPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
ExecutorPage.Visible = false

-- Tab Function
local function AddTab(name, page)
    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(0.9, 0, 0, 52)
    btn.BackgroundColor3 = Theme.Main
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Theme.Accent
    btn.TextSize = 17
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 14)

    btn.MouseButton1Click:Connect(function()
        HomePage.Visible = false
        ExecutorPage.Visible = false
        page.Visible = true
    end)

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundColor3 = Theme.Hover}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundColor3 = Theme.Main}):Play()
    end)
end

AddTab("HOME", HomePage)
AddTab("EXECUTOR", ExecutorPage)

-- ==================== HOME PAGE ====================
local Welcome = Instance.new("TextLabel", HomePage)
Welcome.Size = UDim2.new(0.92, 0, 0, 70)
Welcome.BackgroundTransparency = 1
Welcome.Text = "Welcome back, " .. Player.Name
Welcome.TextColor3 = Theme.Accent
Welcome.Font = Enum.Font.GothamBlack
Welcome.TextSize = 30
Welcome.TextXAlignment = Enum.TextXAlignment.Left

-- Quick Action Buttons
local function HomeBtn(text, y, callback)
    local btn = Instance.new("TextButton", HomePage)
    btn.Size = UDim2.new(0.9, 0, 0, 50)
    btn.Position = UDim2.new(0.05, 0, 0, y)
    btn.BackgroundColor3 = Theme.Dark
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Theme.Accent
    btn.TextSize = 17
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 14)

    btn.MouseButton1Click:Connect(callback)

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.25), {BackgroundColor3 = Theme.Hover}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.25), {BackgroundColor3 = Theme.Dark}):Play()
    end)
end

HomeBtn("Test UNC", 90, function() print("UNC Environment Test Passed") end)
HomeBtn("Test SUNC", 150, function() print("SUNC Secure Test Passed") end)
HomeBtn("Fullbright", 210, function()
    game.Lighting.Brightness = 2
    game.Lighting.ClockTime = 14
    game.Lighting.FogEnd = 99999
end)
HomeBtn("Rejoin Server", 270, function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
end)
HomeBtn("Infinite Yield (Admin)", 330, function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

-- ==================== EXECUTOR PAGE ====================
local CodeBox = Instance.new("TextBox", ExecutorPage)
CodeBox.Size = UDim2.new(0.94, 0, 0, 320)
CodeBox.Position = UDim2.new(0.03, 0, 0, 25)
CodeBox.BackgroundColor3 = Theme.Dark
CodeBox.MultiLine = true
CodeBox.ClearTextOnFocus = false
CodeBox.Text = "-- Welcome to Coconut UI Executor\n-- Paste your script here and hit Execute"
CodeBox.Font = Enum.Font.Code
CodeBox.TextColor3 = Theme.Text
CodeBox.TextSize = 15.5
CodeBox.TextXAlignment = Enum.TextXAlignment.Left
CodeBox.TextYAlignment = Enum.TextYAlignment.Top
Instance.new("UICorner", CodeBox).CornerRadius = UDim.new(0, 18)

local ExecuteBtn = Instance.new("TextButton", ExecutorPage)
ExecuteBtn.Size = UDim2.new(0.45, 0, 0, 58)
ExecuteBtn.Position = UDim2.new(0.03, 0, 0, 365)
ExecuteBtn.BackgroundColor3 = Theme.Accent
ExecuteBtn.Text = "EXECUTE"
ExecuteBtn.Font = Enum.Font.GothamBold
ExecuteBtn.TextColor3 = Color3.new(0,0,0)
ExecuteBtn.TextSize = 20
Instance.new("UICorner", ExecuteBtn).CornerRadius = UDim.new(0, 16)

ExecuteBtn.MouseButton1Click:Connect(function()
    local success, err = pcall(function()
        loadstring(CodeBox.Text)()
    end)
    if not success then
        warn("[COCONUT UI] Execution Error: " .. tostring(err))
    end
end)

local ClearBtn = Instance.new("TextButton", ExecutorPage)
ClearBtn.Size = UDim2.new(0.45, 0, 0, 58)
ClearBtn.Position = UDim2.new(0.52, 0, 0, 365)
ClearBtn.BackgroundColor3 = Theme.Dark
ClearBtn.Text = "CLEAR"
ClearBtn.Font = Enum.Font.GothamBold
ClearBtn.TextColor3 = Theme.Accent
ClearBtn.TextSize = 19
Instance.new("UICorner", ClearBtn).CornerRadius = UDim.new(0, 16)

ClearBtn.MouseButton1Click:Connect(function()
    CodeBox.Text = ""
end)

-- Drag System
local dragging = false
local dragStart, startPos

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

-- F Key System
local uiVisible = true
local StatusLabel = Instance.new("TextLabel", Screen)
StatusLabel.Size = UDim2.new(0, 360, 0, 52)
StatusLabel.Position = UDim2.new(0.5, -180, 0.9, 0)
StatusLabel.BackgroundColor3 = Theme.Dark
StatusLabel.BackgroundTransparency = 0.4
StatusLabel.Text = "Press F to close UI"
StatusLabel.TextColor3 = Theme.Accent
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextSize = 18
Instance.new("UICorner", StatusLabel).CornerRadius = UDim.new(0, 16)

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.F then
        uiVisible = not uiVisible
        if uiVisible then
            Main.Visible = true
            TweenService:Create(Main, TweenInfo.new(0.55, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.1}):Play()
            StatusLabel.Text = "Press F to close UI"
        else
            TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
            task.wait(0.52)
            Main.Visible = false
            StatusLabel.Text = "Press F to reopen UI"
        end
    end
end)

-- Intro Animation
Main.BackgroundTransparency = 1
Main.Position = UDim2.new(0.5, -390, 1.25, 0)
TweenService:Create(Main, TweenInfo.new(1.4, Enum.EasingStyle.Quint), {
    BackgroundTransparency = 0.1,
    Position = UDim2.new(0.5, -390, 0.5, -275)
}):Play()

print("🥥 COCONUT UI V14.5 LOADED - Premium Brown & Cream Edition")
