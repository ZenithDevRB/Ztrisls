-- ZENITH HUB (Universal Executor Compatibility)
-- Developed by Ocy and Zenith Team

wait(0.5)

-- Copy Discord Link to Clipboard (Universal Compatible)
pcall(function()
    local discordLink = "https://discord.gg/TC9ZqRDBU"
    if setclipboard then
        setclipboard(discordLink)
        print("Enlace copiado al portapapeles.")
    else
        warn("setclipboard no está disponible en este executor.")
    end
end)

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- LocalPlayer Variables
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid", 10)
local RootPart = Character:WaitForChild("HumanoidRootPart", 10)
if not Humanoid or not RootPart then
    warn("Failed to load character components")
    return
end

-- Universal ScreenGui Creation
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ZenithHubV2"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function()
    if gethui then
        ScreenGui.Parent = gethui()
    elseif syn and syn.protect_gui then
        syn.protect_gui(ScreenGui)
        ScreenGui.Parent = game.CoreGui
    else
        ScreenGui.Parent = Player:WaitForChild("PlayerGui")
    end
end)

if not ScreenGui.Parent then
    ScreenGui.Parent = Player:WaitForChild("PlayerGui")
end

-- Modern Loading Screen
local LoadScreen = Instance.new("Frame")
LoadScreen.Size = UDim2.new(1, 0, 1, 0)
LoadScreen.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
LoadScreen.BorderSizePixel = 0
LoadScreen.ZIndex = 100
LoadScreen.Parent = ScreenGui

local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 25)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 15, 35))
}
Gradient.Rotation = 45
Gradient.Parent = LoadScreen

local LogoContainer = Instance.new("Frame")
LogoContainer.Size = UDim2.new(0, 120, 0, 120)
LogoContainer.Position = UDim2.new(0.5, -60, 0.35, -60)
LogoContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
LogoContainer.BorderSizePixel = 0
LogoContainer.ZIndex = 101
LogoContainer.Parent = LoadScreen

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 20)
LogoCorner.Parent = LogoContainer

local LogoStroke = Instance.new("UIStroke")
LogoStroke.Color = Color3.fromRGB(100, 50, 200)
LogoStroke.Thickness = 3
LogoStroke.Parent = LogoContainer

local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.new(1, 0, 1, 0)
LogoText.BackgroundTransparency = 1
LogoText.Text = "Z"
LogoText.TextColor3 = Color3.fromRGB(150, 100, 255)
LogoText.Font = Enum.Font.GothamBold
LogoText.TextSize = 72
LogoText.TextTransparency = 1
LogoText.ZIndex = 102
LogoText.Parent = LogoContainer

local LoadTitle = Instance.new("TextLabel")
LoadTitle.Size = UDim2.new(0, 400, 0, 50)
LoadTitle.Position = UDim2.new(0.5, -200, 0.5, 20)
LoadTitle.BackgroundTransparency = 1
LoadTitle.Text = "ZENITH HUB V2"
LoadTitle.TextColor3 = Color3.fromRGB(200, 150, 255)
LoadTitle.Font = Enum.Font.GothamBold
LoadTitle.TextSize = 36
LoadTitle.TextTransparency = 1
LoadTitle.ZIndex = 101
LoadTitle.Parent = LoadScreen

local LoadSubtitle = Instance.new("TextLabel")
LoadSubtitle.Size = UDim2.new(0, 400, 0, 30)
LoadSubtitle.Position = UDim2.new(0.5, -200, 0.5, 65)
LoadSubtitle.BackgroundTransparency = 1
LoadSubtitle.Text = "Discord link copied to clipboard!"
LoadSubtitle.TextColor3 = Color3.fromRGB(100, 200, 100)
LoadSubtitle.Font = Enum.Font.Gotham
LoadSubtitle.TextSize = 14
LoadSubtitle.TextTransparency = 1
LoadSubtitle.ZIndex = 101
LoadSubtitle.Parent = LoadScreen

local ProgressBG = Instance.new("Frame")
ProgressBG.Size = UDim2.new(0, 300, 0, 6)
ProgressBG.Position = UDim2.new(0.5, -150, 0.65, 0)
ProgressBG.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
ProgressBG.BorderSizePixel = 0
ProgressBG.ZIndex = 101
ProgressBG.Parent = LoadScreen

local ProgressCorner = Instance.new("UICorner")
ProgressCorner.CornerRadius = UDim.new(0, 3)
ProgressCorner.Parent = ProgressBG

local ProgressBar = Instance.new("Frame")
ProgressBar.Size = UDim2.new(0, 0, 1, 0)
ProgressBar.BackgroundColor3 = Color3.fromRGB(150, 100, 255)
ProgressBar.BorderSizePixel = 0
ProgressBar.ZIndex = 102
ProgressBar.Parent = ProgressBG

local ProgressBarCorner = Instance.new("UICorner")
ProgressBarCorner.CornerRadius = UDim.new(0, 3)
ProgressBarCorner.Parent = ProgressBar

-- Animate Loading
pcall(function()
    TweenService:Create(LogoText, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
    TweenService:Create(LoadTitle, TweenInfo.new(0.5, Enum.EasingStyle.Back), {TextTransparency = 0}):Play()
    task.wait(0.3)
    TweenService:Create(LoadSubtitle, TweenInfo.new(0.5), {TextTransparency = 0}):Play()

    task.wait(0.5)
    local progressTween = TweenService:Create(ProgressBar, TweenInfo.new(1.5, Enum.EasingStyle.Quad), {Size = UDim2.new(1, 0, 1, 0)})
    progressTween:Play()
    progressTween.Completed:Wait()
    task.wait(0.5)

    TweenService:Create(LoadScreen, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    task.wait(0.5)
    LoadScreen:Destroy()
end)

-- Sistema de Notificaciones Universal
local function ShowNotification(text, color)
    local Notif = Instance.new("Frame")
    Notif.Size = UDim2.new(0, 300, 0, 50)
    Notif.Position = UDim2.new(1, -320, 1, -70)
    Notif.BackgroundColor3 = Color3.fromRGB(25, 22, 35)
    Notif.BorderSizePixel = 0
    Notif.ZIndex = 200
    Notif.Parent = ScreenGui

    local NotifCorner = Instance.new("UICorner")
    NotifCorner.CornerRadius = UDim.new(0, 10)
    NotifCorner.Parent = Notif

    local NotifText = Instance.new("TextLabel")
    NotifText.Size = UDim2.new(1, -20, 1, 0)
    NotifText.Position = UDim2.new(0, 10, 0, 0)
    NotifText.BackgroundTransparency = 1
    NotifText.Text = text
    NotifText.TextColor3 = Color3.fromRGB(255, 255, 255)
    NotifText.Font = Enum.Font.GothamBold
    NotifText.TextSize = 14
    NotifText.TextXAlignment = Enum.TextXAlignment.Left
    NotifText.ZIndex = 201
    NotifText.Parent = Notif

    TweenService:Create(Notif, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
        Position = UDim2.new(1, -320, 1, -70)
    }):Play()

    task.spawn(function()
        task.wait(3)
        TweenService:Create(Notif, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
            Position = UDim2.new(1, 0, 1, -70)
        }):Play()
        task.wait(0.4)
        Notif:Destroy()
    end)
end

ShowNotification("Zenith Hub cargado exitosamente", Color3.fromRGB(100, 200, 100))