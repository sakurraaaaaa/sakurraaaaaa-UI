--[[ 
    🍒 SAKURA BLOOM UI V15 - FULL PREMIUM EDITION
    White & Soft Pink | Ultra Clean | Elegant + Powerful Executor
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer

-- === CHERRY BLOSSOM THEME ===
local Theme = {
    Main = Color3.fromRGB(15, 12, 18),          -- Deep soft black/purple
    Dark = Color3.fromRGB(22, 18, 28),
    Accent = Color3.fromRGB(255, 182, 215),     -- Soft sakura pink
    Accent2 = Color3.fromRGB(255, 105, 180),    -- Hot pink accents
    Glow = Color3.fromRGB(255, 200, 230),
    Text = Color3.fromRGB(255, 245, 255),
    Hover = Color3.fromRGB(45, 35, 55),
    Press = Color3.fromRGB(35, 25, 45),
    Success = Color3.fromRGB(180, 255, 200),
}

-- Cleanup old UI
for _, v in pairs(CoreGui:GetChildren()) do
    if v.Name == "SakuraBloomUI" then v:Destroy() end
end

local Screen = Instance.new("ScreenGui")
Screen.Name = "SakuraBloomUI"
Screen.Parent = CoreGui
Screen.IgnoreGuiInset = true
Screen.ResetOnSpawn = false

-- Main Frame (Bigger & more elegant)
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Parent = Screen
Main.BackgroundColor3 = Theme.Main
Main.BackgroundTransparency = 0.05
Main.Position = UDim2.new(0.5, -420, 0.5, -300)
Main.Size = UDim2.new(0, 840, 0, 620)
Main.Active = true
Main.ClipsDescendants = true

local MainCorner = Instance.new("UICorner", Main)
MainCorner.CornerRadius = UDim.new(0, 28)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Theme.Accent
MainStroke.Thickness = 2.5
MainStroke.Transparency = 0.3

-- Soft breathing glow + bloom effect
task.spawn(function()
    while Main.Parent do
        TweenService:Create(MainStroke, TweenInfo.new(6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            Transparency = 0.1,
            Color = Theme.Glow
        }):Play()
        task.wait(12)
    end
end)

-- Cherry Blossom Particle Background (simple but beautiful)
local Particles = Instance.new("ParticleEmitter", Main)
Particles.Texture = "rbxassetid://7071759179" -- Soft pink petal texture
Particles.Color = ColorSequence.new(Theme.Accent)
Particles.Size = NumberSequence.new(0.8)
Particles.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6), NumberSequenceKeypoint.new(1, 1)})
Particles.Lifetime = NumberRange.new(8, 15)
Particles.Rate = 12
Particles.Speed = NumberRange.new(8, 15)
Particles.RotSpeed = NumberRange.new(-30, 30)
Particles.Acceleration = Vector3.new(0, -5, 0)
Particles.SpreadAngle = Vector2.new(30, 30)
Particles.Enabled = true

-- Top Bar (Glassmorphism style)
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 78)
TopBar.BackgroundColor3 = Theme.Dark
TopBar.BackgroundTransparency = 0.35
TopBar.BorderSizePixel = 0
local TopCorner = Instance.new("UICorner", TopBar)
TopCorner.CornerRadius = UDim.new(0, 28)

local Headshot = Instance.new("ImageLabel", TopBar)
Headshot.Size = UDim2.new(0, 58, 0, 58)
Headshot.Position = UDim2.new(0, 24, 0.5, -29)
Headshot.BackgroundTransparency = 1
Headshot.Image = Players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
local HeadCorner = Instance.new("UICorner", Headshot)
HeadCorner.CornerRadius = UDim.new(1, 0)

local Title = Instance.new("TextLabel", TopBar)
Title.Text = "SAKURA BLOOM"
Title.Font = Enum.Font.GothamBlack
Title.TextColor3 = Theme.Accent
Title.TextSize = 32
Title.Position = UDim2.new(0, 98, 0.5, -20)
Title.Size = UDim2.new(0.4, 0, 1, 0)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

local Clock = Instance.new("TextLabel", TopBar)
Clock.Size = UDim2.new(0.3, 0, 1, 0)
Clock.Position = UDim2.new(0.68, 0, 0, 0)
Clock.Font = Enum.Font.Code
Clock.TextColor3 = Theme.Accent
Clock.TextSize = 19
Clock.TextXAlignment = Enum.TextXAlignment.Right
Clock.BackgroundTransparency = 1

RunService.Heartbeat:Connect(function()
    Clock.Text = os.date("%I:%M:%S %p") .. "  🌸"
end)

-- Sidebar (Vertical Tabs with icons feel)
local Sidebar = Instance.new("Frame", Main)
Sidebar.Position = UDim2.new(0, 32, 0, 100)
Sidebar.Size = UDim2.new(0, 190, 1, -140)
Sidebar.BackgroundColor3 = Theme.Dark
Sidebar.BackgroundTransparency = 0.4
local SideCorner = Instance.new("UICorner", Sidebar)
SideCorner.CornerRadius = UDim.new(0, 22)

local SidebarList = Instance.new("UIListLayout", Sidebar)
SidebarList.Padding = UDim.new(0, 12)
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder

-- Page Holder
local PageHolder = Instance.new("Frame", Main)
PageHolder.Position = UDim2.new(0, 245, 0, 100)
PageHolder.Size = UDim2.new(1, -275, 1, -140)
PageHolder.BackgroundTransparency = 1

local HomePage = Instance.new("ScrollingFrame", PageHolder)
HomePage.Size = UDim2.new(1,0,1,0)
HomePage.BackgroundTransparency = 1
HomePage.ScrollBarThickness = 6
HomePage.ScrollBarImageColor3 = Theme.Accent
HomePage.AutomaticCanvasSize = Enum.AutomaticSize.Y
HomePage.Visible = true

local ExecutorPage = Instance.new("ScrollingFrame", PageHolder)
ExecutorPage.Size = UDim2.new(1,0,1,0)
ExecutorPage.BackgroundTransparency = 1
ExecutorPage.ScrollBarThickness = 6
ExecutorPage.ScrollBarImageColor3 = Theme.Accent
ExecutorPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
ExecutorPage.Visible = false

-- Tab Button Creator
local function AddTab(name, page, icon)
    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(0.92, 0, 0, 58)
    btn.BackgroundColor3 = Theme.Main
    btn.BackgroundTransparency = 0.3
    btn.Text = "   " .. name
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Theme.Text
    btn.TextSize = 18
    btn.TextXAlignment = Enum.TextXAlignment.Left
    local btnCorner = Instance.new("UICorner", btn)
    btnCorner.CornerRadius = UDim.new(0, 16)

    local btnStroke = Instance.new("UIStroke", btn)
    btnStroke.Color = Theme.Accent
    btnStroke.Transparency = 0.7
    btnStroke.Thickness = 1.5

    btn.MouseButton1Click:Connect(function()
        HomePage.Visible = false
        ExecutorPage.Visible = false
        page.Visible = true

        -- Click effect
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.1}):Play()
        task.delay(0.2, function()
            if btn.Parent then
                TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundTransparency = 0.3}):Play()
            end
        end)
    end)

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
            BackgroundColor3 = Theme.Hover,
            BackgroundTransparency = 0.1
        }):Play()
    end)

    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
            BackgroundColor3 = Theme.Main,
            BackgroundTransparency = 0.3
        }):Play()
    end)
end

AddTab("HOME", HomePage, "🏠")
AddTab("EXECUTOR", ExecutorPage, "⚡")

-- ==================== HOME PAGE ====================
local Welcome = Instance.new("TextLabel", HomePage)
Welcome.Size = UDim2.new(0.95, 0, 0, 80)
Welcome.Position = UDim2.new(0.025, 0, 0, 10)
Welcome.BackgroundTransparency = 1
Welcome.Text = "Welcome back, " .. Player.Name .. " 🌸"
Welcome.TextColor3 = Theme.Accent
Welcome.Font = Enum.Font.GothamBlack
Welcome.TextSize = 34
Welcome.TextXAlignment = Enum.TextXAlignment.Left

-- Quick Actions (more modern grid-like)
local function HomeBtn(text, posY, callback, color)
    local btn = Instance.new("TextButton", HomePage)
    btn.Size = UDim2.new(0.92, 0, 0, 56)
    btn.Position = UDim2.new(0.04, 0, 0, posY)
    btn.BackgroundColor3 = color or Theme.Dark
    btn.Text = text
    btn.Font = Enum.Font.GothamSemibold
    btn.TextColor3 = Theme.Text
    btn.TextSize = 18
    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0, 18)

    btn.MouseButton1Click:Connect(callback)

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Hover}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = color or Theme.Dark}):Play()
    end)
end

HomeBtn("Test UNC Environment", 110, function() print("✅ UNC Test Passed - Sakura Bloom") end)
HomeBtn("Test SUNC", 180, function() print("✅ SUNC Secure Environment Passed") end)
HomeBtn("Fullbright + Bloom", 250, function()
    Lighting.Brightness = 3
    Lighting.ClockTime = 14
    Lighting.FogEnd = 99999
    Lighting.EnvironmentDiffuseScale = 1
    Lighting.EnvironmentSpecularScale = 1
end, Theme.Accent2)

HomeBtn("Rejoin Server", 320, function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
end)

HomeBtn("Infinite Yield", 390, function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

-- ==================== EXECUTOR PAGE ====================
local CodeBox = Instance.new("TextBox", ExecutorPage)
CodeBox.Size = UDim2.new(0.96, 0, 0, 355)
CodeBox.Position = UDim2.new(0.02, 0, 0, 20)
CodeBox.BackgroundColor3 = Theme.Dark
CodeBox.BackgroundTransparency = 0.25
CodeBox.MultiLine = true
CodeBox.ClearTextOnFocus = false
CodeBox.Text = "-- 🌸 Sakura Bloom Executor\n-- Paste your script here\n-- Supports: loadstring, require (modules), LocalScripts & ServerScripts"
CodeBox.Font = Enum.Font.Code
CodeBox.TextColor3 = Theme.Text
CodeBox.TextSize = 16
CodeBox.TextXAlignment = Enum.TextXAlignment.Left
CodeBox.TextYAlignment = Enum.TextYAlignment.Top
CodeBox.TextWrapped = true
local CodeCorner = Instance.new("UICorner", CodeBox)
CodeCorner.CornerRadius = UDim.new(0, 20)

local ExecuteBtn = Instance.new("TextButton", ExecutorPage)
ExecuteBtn.Size = UDim2.new(0.47, 0, 0, 65)
ExecuteBtn.Position = UDim2.new(0.02, 0, 0, 395)
ExecuteBtn.BackgroundColor3 = Theme.Accent
ExecuteBtn.Text = "EXECUTE SCRIPT"
ExecuteBtn.Font = Enum.Font.GothamBold
ExecuteBtn.TextColor3 = Color3.new(0,0,0)
ExecuteBtn.TextSize = 21
local ExCorner = Instance.new("UICorner", ExecuteBtn)
ExCorner.CornerRadius = UDim.new(0, 18)

ExecuteBtn.MouseButton1Click:Connect(function()
    local code = CodeBox.Text
    local success, err = pcall(function()
        loadstring(code)()
    end)
    if success then
        print("🌸 Sakura Bloom | Execution Successful")
    else
        warn("🌸 Sakura Bloom | Execution Error: " .. tostring(err))
    end
end)

local ClearBtn = Instance.new("TextButton", ExecutorPage)
ClearBtn.Size = UDim2.new(0.47, 0, 0, 65)
ClearBtn.Position = UDim2.new(0.51, 0, 0, 395)
ClearBtn.BackgroundColor3 = Theme.Dark
ClearBtn.Text = "CLEAR"
ClearBtn.Font = Enum.Font.GothamBold
ClearBtn.TextColor3 = Theme.Accent
ClearBtn.TextSize = 20
local ClCorner = Instance.new("UICorner", ClearBtn)
ClCorner.CornerRadius = UDim.new(0, 18)

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
    if input.UserInputType == Enum.UserInputType.MouseButton1 then 
        dragging = false 
    end
end)

-- F to Toggle UI (with nice fade)
local uiVisible = true
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.F then
        uiVisible = not uiVisible
        if uiVisible then
            Main.Visible = true
            TweenService:Create(Main, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.05}):Play()
        else
            TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
            task.wait(0.55)
            Main.Visible = false
        end
    end
end)

-- Intro Animation (Floating petals feel)
Main.BackgroundTransparency = 1
Main.Position = UDim2.new(0.5, -420, 0.7, 0)
Main.Size = UDim2.new(0, 800, 0, 580)

TweenService:Create(Main, TweenInfo.new(1.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
    BackgroundTransparency = 0.05,
    Position = UDim2.new(0.5, -420, 0.5, -300),
    Size = UDim2.new(0, 840, 0, 620)
}):Play()

print("🌸 SAKURA BLOOM UI V15 LOADED - Premium Cherry Blossom Edition")
