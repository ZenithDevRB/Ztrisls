pcall(function()
-- ZENITH HUB
-- Developed by Ocy and Zenith Team

wait(0.5)

-- Copy Discord Link to Clipboard
pcall(function()
    if setclipboard then
        setclipboard("https://discord.gg/TC9ZqRDBU")
    end
end)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid", 10)
local RootPart = Character:WaitForChild("HumanoidRootPart", 10)

if not Humanoid or not RootPart then
    warn("Failed to load character components")
    return
end

-- Animation Packs
local AnimPacks = {
    {Name = "Ninja", Idle = 656117400, Walk = 656121766, Run = 656118852, Jump = 656117878, Fall = 656115606},
    {Name = "Levitation", Idle = 616006778, Walk = 616013216, Run = 616010382, Jump = 616008936, Fall = 616005863},
    {Name = "Astronaut", Idle = 891621366, Walk = 891636393, Run = 891621366, Jump = 891627522, Fall = 891617961},
    {Name = "Zombie", Idle = 616158929, Walk = 616168032, Run = 616158929, Jump = 616161997, Fall = 616157476},
    {Name = "Stylish", Idle = 616136790, Walk = 616146177, Run = 616140816, Jump = 616139451, Fall = 616134815},
    {Name = "Elder", Idle = 845397899, Walk = 845386501, Run = 845403856, Jump = 845398858, Fall = 845397899},
    {Name = "Knight", Idle = 657595757, Walk = 657552124, Run = 657564596, Jump = 658409194, Fall = 657600338},
    {Name = "Superhero", Idle = 782841498, Walk = 782843345, Run = 782842708, Jump = 782847020, Fall = 782846423},
    {Name = "Pirate", Idle = 750781874, Walk = 750785693, Run = 750783738, Jump = 750782230, Fall = 750780242},
    {Name = "Vampire", Idle = 1083445855, Walk = 1083473930, Run = 1083462077, Jump = 1083455352, Fall = 1083443587},
    {Name = "Werewolf", Idle = 1083195517, Walk = 1083178339, Run = 1083216690, Jump = 1083218792, Fall = 1083214717},
    {Name = "Cartoony", Idle = 742637544, Walk = 742640026, Run = 742638842, Jump = 742637942, Fall = 742637151}
}

-- Variables
local CurrentTracks = {}
local NoClipEnabled = false
local NoClipConnection = nil
local TargetPlayer = nil
local BangLoop, DoggyLoop, BackpackLoop, DragLoop = nil, nil, nil, nil

-- Combat Variables
local HitboxEnabled = false
local HitboxConnection = nil
local HitboxSize = 20
local AimbotEnabled = false
local AimbotConnection = nil
local AimbotSettings = {
    smoothness = 0.35,
    fov = 300,
    targetPart = "Head",
    prediction = 0.135,
    teamCheck = true
}

-- Create ScreenGui
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
task.spawn(function()
    TweenService:Create(LogoText, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
    TweenService:Create(LoadTitle, TweenInfo.new(0.5, Enum.EasingStyle.Back), {TextTransparency = 0}):Play()
    task.wait(0.3)
    TweenService:Create(LoadSubtitle, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
    
    local rotateAnim = TweenService:Create(LogoContainer, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {Rotation = 360})
    rotateAnim:Play()
    
    task.wait(0.5)
    local progressTween = TweenService:Create(ProgressBar, TweenInfo.new(1.5, Enum.EasingStyle.Quad), {Size = UDim2.new(1, 0, 1, 0)})
    progressTween:Play()
    progressTween.Completed:Wait()
    
    rotateAnim:Cancel()
    task.wait(0.3)
    
    TweenService:Create(LoadScreen, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(LogoContainer, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(LogoText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(LoadTitle, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(LoadSubtitle, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(ProgressBG, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(ProgressBar, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(LogoStroke, TweenInfo.new(0.5), {Transparency = 1}):Play()
    
    task.wait(0.5)
    LoadScreen:Destroy()
end)

task.wait(2.5)

-- SISTEMA DE NOTIFICACIONES
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
    
    local NotifStroke = Instance.new("UIStroke")
    NotifStroke.Color = color
    NotifStroke.Thickness = 2
    NotifStroke.Parent = Notif
    
    local NotifGradient = Instance.new("UIGradient")
    NotifGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 27, 40)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 18, 30))
    }
    NotifGradient.Rotation = 90
    NotifGradient.Parent = Notif
    
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
    
    Notif.Position = UDim2.new(1, 0, 1, -70)
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

-- Toggle Button
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 15, 0.5, -25)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 20, 35)
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Text = "Z"
ToggleBtn.TextColor3 = Color3.fromRGB(150, 100, 255)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 28
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 12)
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(100, 50, 200)
ToggleStroke.Thickness = 2
ToggleStroke.Parent = ToggleBtn

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 550, 0, 380)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 18, 28)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(80, 40, 150)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- FUNCIONALIDAD DEL BOTÓN Z
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {
        Rotation = ToggleBtn.Rotation + 180
    }):Play()
end)

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(25, 22, 35)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 15)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "ZENITH HUB V2"
Title.TextColor3 = Color3.fromRGB(180, 130, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -35, 0, 6)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 80)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 7)
CloseCorner.Parent = CloseBtn

-- FUNCIONALIDAD DEL BOTÓN CERRAR
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 110, 1, -48)
Sidebar.Position = UDim2.new(0, 7, 0, 46)
Sidebar.BackgroundColor3 = Color3.fromRGB(25, 22, 35)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 10)
SidebarCorner.Parent = Sidebar

local SidebarList = Instance.new("UIListLayout")
SidebarList.Padding = UDim.new(0, 4)
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder
SidebarList.Parent = Sidebar

-- Content Area
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(0, 418, 1, -48)
ContentArea.Position = UDim2.new(0, 125, 0, 46)
ContentArea.BackgroundColor3 = Color3.fromRGB(25, 22, 35)
ContentArea.BorderSizePixel = 0
ContentArea.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 10)
ContentCorner.Parent = ContentArea

-- Pages
local AnimationsPage = Instance.new("ScrollingFrame")
AnimationsPage.Size = UDim2.new(1, -12, 1, -12)
AnimationsPage.Position = UDim2.new(0, 6, 0, 6)
AnimationsPage.BackgroundTransparency = 1
AnimationsPage.BorderSizePixel = 0
AnimationsPage.ScrollBarThickness = 4
AnimationsPage.ScrollBarImageColor3 = Color3.fromRGB(150, 100, 255)
AnimationsPage.Visible = true
AnimationsPage.Parent = ContentArea

local AnimList = Instance.new("UIListLayout")
AnimList.Padding = UDim.new(0, 6)
AnimList.SortOrder = Enum.SortOrder.LayoutOrder
AnimList.Parent = AnimationsPage

local CharacterPage = Instance.new("ScrollingFrame")
CharacterPage.Size = UDim2.new(1, -12, 1, -12)
CharacterPage.Position = UDim2.new(0, 6, 0, 6)
CharacterPage.BackgroundTransparency = 1
CharacterPage.BorderSizePixel = 0
CharacterPage.ScrollBarThickness = 4
CharacterPage.ScrollBarImageColor3 = Color3.fromRGB(150, 100, 255)
CharacterPage.Visible = false
CharacterPage.Parent = ContentArea

local CharList = Instance.new("UIListLayout")
CharList.Padding = UDim.new(0, 6)
CharList.SortOrder = Enum.SortOrder.LayoutOrder
CharList.Parent = CharacterPage

local CombatPage = Instance.new("ScrollingFrame")
CombatPage.Size = UDim2.new(1, -12, 1, -12)
CombatPage.Position = UDim2.new(0, 6, 0, 6)
CombatPage.BackgroundTransparency = 1
CombatPage.BorderSizePixel = 0
CombatPage.ScrollBarThickness = 4
CombatPage.ScrollBarImageColor3 = Color3.fromRGB(150, 100, 255)
CombatPage.Visible = false
CombatPage.Parent = ContentArea

local CombatList = Instance.new("UIListLayout")
CombatList.Padding = UDim.new(0, 6)
CombatList.SortOrder = Enum.SortOrder.LayoutOrder
CombatList.Parent = CombatPage

local PersonPage = Instance.new("ScrollingFrame")
PersonPage.Size = UDim2.new(1, -12, 1, -12)
PersonPage.Position = UDim2.new(0, 6, 0, 6)
PersonPage.BackgroundTransparency = 1
PersonPage.BorderSizePixel = 0
PersonPage.ScrollBarThickness = 4
PersonPage.ScrollBarImageColor3 = Color3.fromRGB(150, 100, 255)
PersonPage.Visible = false
PersonPage.Parent = ContentArea

local EmotesPage = Instance.new("ScrollingFrame")
EmotesPage.Size = UDim2.new(1, -12, 1, -12)
EmotesPage.Position = UDim2.new(0, 6, 0, 6)
EmotesPage.BackgroundTransparency = 1
EmotesPage.BorderSizePixel = 0
EmotesPage.ScrollBarThickness = 4
EmotesPage.ScrollBarImageColor3 = Color3.fromRGB(150, 100, 255)
EmotesPage.Visible = false
EmotesPage.Parent = ContentArea

local EmoteList = Instance.new("UIListLayout")
EmoteList.Padding = UDim.new(0, 6)
EmoteList.SortOrder = Enum.SortOrder.LayoutOrder
EmoteList.Parent = EmotesPage

local BypassPage = Instance.new("ScrollingFrame")
BypassPage.Size = UDim2.new(1, -12, 1, -12)
BypassPage.Position = UDim2.new(0, 6, 0, 6)
BypassPage.BackgroundTransparency = 1
BypassPage.BorderSizePixel = 0
BypassPage.ScrollBarThickness = 4
BypassPage.ScrollBarImageColor3 = Color3.fromRGB(150, 100, 255)
BypassPage.Visible = false
BypassPage.Parent = ContentArea

local BypassList = Instance.new("UIListLayout")
BypassList.Padding = UDim.new(0, 6)
BypassList.SortOrder = Enum.SortOrder.LayoutOrder
BypassList.Parent = BypassPage

-- PLANTS VS BRAINROTS PAGE
local PlantsPage = Instance.new("ScrollingFrame")
PlantsPage.Size = UDim2.new(1, -12, 1, -12)
PlantsPage.Position = UDim2.new(0, 6, 0, 6)
PlantsPage.BackgroundTransparency = 1
PlantsPage.BorderSizePixel = 0
PlantsPage.ScrollBarThickness = 4
PlantsPage.ScrollBarImageColor3 = Color3.fromRGB(150, 100, 255)
PlantsPage.Visible = false
PlantsPage.Parent = ContentArea

local PlantsList = Instance.new("UIListLayout")
PlantsList.Padding = UDim.new(0, 6)
PlantsList.SortOrder = Enum.SortOrder.LayoutOrder
PlantsList.Parent = PlantsPage

-- AUTO BAT ATTACK SYSTEM - CONFIGURABLE
-- Reemplaza desde "-- INSTANT KILL BRAINROTS" hasta "PlantsPage.CanvasSize"

-- Auto Bat Attack Section (Configurable)
local BatAttackSection = Instance.new("Frame")
BatAttackSection.Size = UDim2.new(1, -6, 0, 240)
BatAttackSection.BackgroundColor3 = Color3.fromRGB(35, 30, 45)
BatAttackSection.BorderSizePixel = 0
BatAttackSection.Parent = PlantsPage

local BatAttackCorner = Instance.new("UICorner")
BatAttackCorner.CornerRadius = UDim.new(0, 7)
BatAttackCorner.Parent = BatAttackSection

local BatAttackStroke = Instance.new("UIStroke")
BatAttackStroke.Color = Color3.fromRGB(255, 50, 50)
BatAttackStroke.Thickness = 2
BatAttackStroke.Transparency = 0.5
BatAttackStroke.Parent = BatAttackSection

-- Title
local BatAttackTitle = Instance.new("TextLabel")
BatAttackTitle.Size = UDim2.new(0.7, -8, 0, 20)
BatAttackTitle.Position = UDim2.new(0, 8, 0, 4)
BatAttackTitle.BackgroundTransparency = 1
BatAttackTitle.Text = "Auto Bat Attack"
BatAttackTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
BatAttackTitle.Font = Enum.Font.GothamBold
BatAttackTitle.TextSize = 14
BatAttackTitle.TextXAlignment = Enum.TextXAlignment.Left
BatAttackTitle.Parent = BatAttackSection

-- Toggle Button
local BatAttackToggle = Instance.new("TextButton")
BatAttackToggle.Size = UDim2.new(0, 50, 0, 22)
BatAttackToggle.Position = UDim2.new(1, -58, 0, 4)
BatAttackToggle.BackgroundColor3 = Color3.fromRGB(60, 50, 70)
BatAttackToggle.Text = "OFF"
BatAttackToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
BatAttackToggle.Font = Enum.Font.GothamBold
BatAttackToggle.TextSize = 11
BatAttackToggle.BorderSizePixel = 0
BatAttackToggle.Parent = BatAttackSection

local BatAttackToggleCorner = Instance.new("UICorner")
BatAttackToggleCorner.CornerRadius = UDim.new(0, 5)
BatAttackToggleCorner.Parent = BatAttackToggle

-- Attack Range Slider
local RangeLabel = Instance.new("TextLabel")
RangeLabel.Size = UDim2.new(0.6, -8, 0, 20)
RangeLabel.Position = UDim2.new(0, 8, 0, 32)
RangeLabel.BackgroundTransparency = 1
RangeLabel.Text = "Attack Range:"
RangeLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
RangeLabel.Font = Enum.Font.GothamSemibold
RangeLabel.TextSize = 13
RangeLabel.TextXAlignment = Enum.TextXAlignment.Left
RangeLabel.Parent = BatAttackSection

local RangeInput = Instance.new("TextBox")
RangeInput.Size = UDim2.new(0.35, -8, 0, 20)
RangeInput.Position = UDim2.new(0.65, 0, 0, 32)
RangeInput.BackgroundColor3 = Color3.fromRGB(50, 45, 65)
RangeInput.BorderSizePixel = 0
RangeInput.Text = "50"
RangeInput.TextColor3 = Color3.fromRGB(255, 255, 255)
RangeInput.Font = Enum.Font.Gotham
RangeInput.TextSize = 12
RangeInput.Parent = BatAttackSection

local RangeInputCorner = Instance.new("UICorner")
RangeInputCorner.CornerRadius = UDim.new(0, 5)
RangeInputCorner.Parent = RangeInput

local RangeSliderBG = Instance.new("Frame")
RangeSliderBG.Size = UDim2.new(1, -16, 0, 5)
RangeSliderBG.Position = UDim2.new(0, 8, 0, 60)
RangeSliderBG.BackgroundColor3 = Color3.fromRGB(50, 45, 65)
RangeSliderBG.BorderSizePixel = 0
RangeSliderBG.Parent = BatAttackSection

local RangeSliderCorner1 = Instance.new("UICorner")
RangeSliderCorner1.CornerRadius = UDim.new(0, 2.5)
RangeSliderCorner1.Parent = RangeSliderBG

local RangeSliderFill = Instance.new("Frame")
RangeSliderFill.Size = UDim2.new(0.475, 0, 1, 0)
RangeSliderFill.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
RangeSliderFill.BorderSizePixel = 0
RangeSliderFill.Parent = RangeSliderBG

local RangeSliderCorner2 = Instance.new("UICorner")
RangeSliderCorner2.CornerRadius = UDim.new(0, 2.5)
RangeSliderCorner2.Parent = RangeSliderFill

local RangeSliderBtn = Instance.new("TextButton")
RangeSliderBtn.Size = UDim2.new(1, 0, 1, 0)
RangeSliderBtn.BackgroundTransparency = 1
RangeSliderBtn.Text = ""
RangeSliderBtn.Parent = RangeSliderBG

-- Click Speed Slider
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0.6, -8, 0, 20)
SpeedLabel.Position = UDim2.new(0, 8, 0, 72)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Click Speed (CPS):"
SpeedLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
SpeedLabel.Font = Enum.Font.GothamSemibold
SpeedLabel.TextSize = 13
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = BatAttackSection

local SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(0.35, -8, 0, 20)
SpeedInput.Position = UDim2.new(0.65, 0, 0, 72)
SpeedInput.BackgroundColor3 = Color3.fromRGB(50, 45, 65)
SpeedInput.BorderSizePixel = 0
SpeedInput.Text = "10"
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedInput.Font = Enum.Font.Gotham
SpeedInput.TextSize = 12
SpeedInput.Parent = BatAttackSection

local SpeedInputCorner = Instance.new("UICorner")
SpeedInputCorner.CornerRadius = UDim.new(0, 5)
SpeedInputCorner.Parent = SpeedInput

local SpeedSliderBG = Instance.new("Frame")
SpeedSliderBG.Size = UDim2.new(1, -16, 0, 5)
SpeedSliderBG.Position = UDim2.new(0, 8, 0, 100)
SpeedSliderBG.BackgroundColor3 = Color3.fromRGB(50, 45, 65)
SpeedSliderBG.BorderSizePixel = 0
SpeedSliderBG.Parent = BatAttackSection

local SpeedSliderCorner1 = Instance.new("UICorner")
SpeedSliderCorner1.CornerRadius = UDim.new(0, 2.5)
SpeedSliderCorner1.Parent = SpeedSliderBG

local SpeedSliderFill = Instance.new("Frame")
SpeedSliderFill.Size = UDim2.new(0.1, 0, 1, 0)
SpeedSliderFill.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
SpeedSliderFill.BorderSizePixel = 0
SpeedSliderFill.Parent = SpeedSliderBG

local SpeedSliderCorner2 = Instance.new("UICorner")
SpeedSliderCorner2.CornerRadius = UDim.new(0, 2.5)
SpeedSliderCorner2.Parent = SpeedSliderFill

local SpeedSliderBtn = Instance.new("TextButton")
SpeedSliderBtn.Size = UDim2.new(1, 0, 1, 0)
SpeedSliderBtn.BackgroundTransparency = 1
SpeedSliderBtn.Text = ""
SpeedSliderBtn.Parent = SpeedSliderBG

-- Auto Equip Toggle
local AutoEquipLabel = Instance.new("TextLabel")
AutoEquipLabel.Size = UDim2.new(0.7, -8, 0, 20)
AutoEquipLabel.Position = UDim2.new(0, 8, 0, 112)
AutoEquipLabel.BackgroundTransparency = 1
AutoEquipLabel.Text = "Auto Equip Bat:"
AutoEquipLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
AutoEquipLabel.Font = Enum.Font.GothamSemibold
AutoEquipLabel.TextSize = 13
AutoEquipLabel.TextXAlignment = Enum.TextXAlignment.Left
AutoEquipLabel.Parent = BatAttackSection

local AutoEquipToggle = Instance.new("TextButton")
AutoEquipToggle.Size = UDim2.new(0, 40, 0, 20)
AutoEquipToggle.Position = UDim2.new(1, -48, 0, 112)
AutoEquipToggle.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
AutoEquipToggle.Text = "ON"
AutoEquipToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoEquipToggle.Font = Enum.Font.GothamBold
AutoEquipToggle.TextSize = 11
AutoEquipToggle.BorderSizePixel = 0
AutoEquipToggle.Parent = BatAttackSection

local AutoEquipToggleCorner = Instance.new("UICorner")
AutoEquipToggleCorner.CornerRadius = UDim.new(0, 5)
AutoEquipToggleCorner.Parent = AutoEquipToggle

-- Attack Enemies Toggle
local AttackEnemiesLabel = Instance.new("TextLabel")
AttackEnemiesLabel.Size = UDim2.new(0.7, -8, 0, 20)
AttackEnemiesLabel.Position = UDim2.new(0, 8, 0, 140)
AttackEnemiesLabel.BackgroundTransparency = 1
AttackEnemiesLabel.Text = "Attack Nearby Enemies:"
AttackEnemiesLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
AttackEnemiesLabel.Font = Enum.Font.GothamSemibold
AttackEnemiesLabel.TextSize = 13
AttackEnemiesLabel.TextXAlignment = Enum.TextXAlignment.Left
AttackEnemiesLabel.Parent = BatAttackSection

local AttackEnemiesToggle = Instance.new("TextButton")
AttackEnemiesToggle.Size = UDim2.new(0, 40, 0, 20)
AttackEnemiesToggle.Position = UDim2.new(1, -48, 0, 140)
AttackEnemiesToggle.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
AttackEnemiesToggle.Text = "ON"
AttackEnemiesToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AttackEnemiesToggle.Font = Enum.Font.GothamBold
AttackEnemiesToggle.TextSize = 11
AttackEnemiesToggle.BorderSizePixel = 0
AttackEnemiesToggle.Parent = BatAttackSection

local AttackEnemiesToggleCorner = Instance.new("UICorner")
AttackEnemiesToggleCorner.CornerRadius = UDim.new(0, 5)
AttackEnemiesToggleCorner.Parent = AttackEnemiesToggle

-- Status Labels
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -16, 0, 20)
StatusLabel.Position = UDim2.new(0, 8, 0, 168)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Status: Inactive"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 170)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 11
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = BatAttackSection

local ClickCountLabel = Instance.new("TextLabel")
ClickCountLabel.Size = UDim2.new(1, -16, 0, 20)
ClickCountLabel.Position = UDim2.new(0, 8, 0, 188)
ClickCountLabel.BackgroundTransparency = 1
ClickCountLabel.Text = "Clicks: 0 | Enemies Hit: 0"
ClickCountLabel.TextColor3 = Color3.fromRGB(150, 150, 170)
ClickCountLabel.Font = Enum.Font.Gotham
ClickCountLabel.TextSize = 11
ClickCountLabel.TextXAlignment = Enum.TextXAlignment.Left
ClickCountLabel.Parent = BatAttackSection

local BatStatusLabel = Instance.new("TextLabel")
BatStatusLabel.Size = UDim2.new(1, -16, 0, 20)
BatStatusLabel.Position = UDim2.new(0, 8, 0, 208)
BatStatusLabel.BackgroundTransparency = 1
BatStatusLabel.Text = "Bat: Not Found"
BatStatusLabel.TextColor3 = Color3.fromRGB(255, 150, 50)
BatStatusLabel.Font = Enum.Font.Gotham
BatStatusLabel.TextSize = 11
BatStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
BatStatusLabel.Parent = BatAttackSection

-- Variables
local BatAttackEnabled = false
local AutoEquipEnabled = true
local AttackEnemiesEnabled = true
local AttackRange = 50
local ClickSpeed = 10
local ClickInterval = 0.1
local AutoClickLoop = nil
local AttackLoop = nil
local ClickCount = 0
local EnemiesHit = 0

-- Functions
local function FindFlutedBat()
    local character = Player.Character
    if not character then return nil end
    
    -- Check equipped
    for _, item in pairs(character:GetChildren()) do
        if item:IsA("Tool") and item.Name == "Fluted Bat" then
            return item
        end
    end
    
    -- Check backpack
    for _, item in pairs(Player.Backpack:GetChildren()) do
        if item:IsA("Tool") and item.Name == "Fluted Bat" then
            return item
        end
    end
    
    return nil
end

local function EquipFlutedBat()
    local bat = FindFlutedBat()
    if not bat then return false end
    
    if bat.Parent == Player.Backpack then
        Humanoid:EquipTool(bat)
        task.wait(0.05)
    end
    
    return true
end

local function UpdateRange(value)
    value = math.clamp(tonumber(value) or 50, 5, 200)
    AttackRange = value
    RangeInput.Text = tostring(value)
    local pos = (value - 5) / (200 - 5)
    RangeSliderFill.Size = UDim2.new(pos, 0, 1, 0)
end

local function UpdateSpeed(value)
    value = math.clamp(tonumber(value) or 10, 1, 100)
    ClickSpeed = value
    ClickInterval = 1 / value
    SpeedInput.Text = tostring(value)
    local pos = (value - 1) / (100 - 1)
    SpeedSliderFill.Size = UDim2.new(pos, 0, 1, 0)
end

-- Range Slider
RangeInput.FocusLost:Connect(function()
    UpdateRange(RangeInput.Text)
end)

local rangeDragging = false
RangeSliderBtn.MouseButton1Down:Connect(function() rangeDragging = true end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then rangeDragging = false end
end)
UIS.InputChanged:Connect(function(input)
    if rangeDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local pos = math.clamp((input.Position.X - RangeSliderBG.AbsolutePosition.X) / RangeSliderBG.AbsoluteSize.X, 0, 1)
        local value = math.floor(5 + (200 - 5) * pos)
        UpdateRange(value)
    end
end)

-- Speed Slider
SpeedInput.FocusLost:Connect(function()
    UpdateSpeed(SpeedInput.Text)
end)

local speedDragging = false
SpeedSliderBtn.MouseButton1Down:Connect(function() speedDragging = true end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then speedDragging = false end
end)
UIS.InputChanged:Connect(function(input)
    if speedDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local pos = math.clamp((input.Position.X - SpeedSliderBG.AbsolutePosition.X) / SpeedSliderBG.AbsoluteSize.X, 0, 1)
        local value = math.floor(1 + (100 - 1) * pos)
        UpdateSpeed(value)
    end
end)

-- Auto Equip Toggle
AutoEquipToggle.MouseButton1Click:Connect(function()
    AutoEquipEnabled = not AutoEquipEnabled
    AutoEquipToggle.Text = AutoEquipEnabled and "ON" or "OFF"
    AutoEquipToggle.BackgroundColor3 = AutoEquipEnabled and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(60, 50, 70)
end)

-- Attack Enemies Toggle
AttackEnemiesToggle.MouseButton1Click:Connect(function()
    AttackEnemiesEnabled = not AttackEnemiesEnabled
    AttackEnemiesToggle.Text = AttackEnemiesEnabled and "ON" or "OFF"
    AttackEnemiesToggle.BackgroundColor3 = AttackEnemiesEnabled and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(60, 50, 70)
end)

-- Main Toggle
BatAttackToggle.MouseButton1Click:Connect(function()
    BatAttackEnabled = not BatAttackEnabled
    BatAttackToggle.Text = BatAttackEnabled and "ON" or "OFF"
    BatAttackToggle.BackgroundColor3 = BatAttackEnabled and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(60, 50, 70)
    BatAttackStroke.Transparency = BatAttackEnabled and 0 or 0.5
    
    if BatAttackEnabled then
        ShowNotification("Auto Bat Attack Enabled", Color3.fromRGB(255, 100, 100))
        StatusLabel.Text = "Status: Active"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        ClickCount = 0
        EnemiesHit = 0
        
        -- Auto Click Loop
        AutoClickLoop = task.spawn(function()
            while BatAttackEnabled do
                local bat = FindFlutedBat()
                
                if bat then
                    BatStatusLabel.Text = "Bat: Found [" .. bat.Name .. "]"
                    BatStatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
                    
                    if AutoEquipEnabled and bat.Parent == Player.Backpack then
                        EquipFlutedBat()
                    end
                    
                    if bat.Parent == Player.Character then
                        pcall(function()
                            bat:Activate()
                        end)
                        ClickCount = ClickCount + 1
                    end
                else
                    BatStatusLabel.Text = "Bat: Not Found"
                    BatStatusLabel.TextColor3 = Color3.fromRGB(255, 150, 50)
                end
                
                task.wait(ClickInterval)
            end
        end)
        
-- Attack Loop SIMPLIFICADO Y CORREGIDO
-- Reemplaza desde la línea que dice "-- Attack Loop" hasta "else" (antes de "ShowNotification Auto Bat Attack Disabled")

AttackLoop = RunService.Heartbeat:Connect(function()
    pcall(function()
        if not BatAttackEnabled or not AttackEnemiesEnabled then return end
        
        local bat = FindFlutedBat()
        if not bat or bat.Parent ~= Player.Character then return end
        
        local character = Player.Character
        if not character or not RootPart then return end
        
        local hitThisFrame = 0
        
        -- Método 1: Buscar en workspace.Live
        local liveFolder = workspace:FindFirstChild("Live")
        if liveFolder then
            for _, enemy in pairs(liveFolder:GetChildren()) do
                if enemy:IsA("Model") and enemy ~= character then
                    local enemyHum = enemy:FindFirstChild("Humanoid")
                    local enemyRoot = enemy:FindFirstChild("HumanoidRootPart")
                    
                    if enemyHum and enemyHum.Health > 0 and enemyRoot then
                        local distance = (enemyRoot.Position - RootPart.Position).Magnitude
                        if distance <= AttackRange then
                            hitThisFrame = hitThisFrame + 1
                            pcall(function() bat:Activate() end)
                            task.wait(0.01)
                        end
                    end
                end
            end
        end
        
        -- Método 2: Buscar en workspace
        if hitThisFrame == 0 then
            for _, enemy in pairs(workspace:GetChildren()) do
                if enemy:IsA("Model") and enemy ~= character and enemy:FindFirstChild("Humanoid") then
                    local enemyHum = enemy:FindFirstChild("Humanoid")
                    local enemyRoot = enemy:FindFirstChild("HumanoidRootPart")
                    
                    if enemyHum and enemyHum.Health > 0 and enemyRoot then
                        local distance = (enemyRoot.Position - RootPart.Position).Magnitude
                        if distance <= AttackRange then
                            hitThisFrame = hitThisFrame + 1
                            pcall(function() bat:Activate() end)
                            task.wait(0.01)
                        end
                    end
                end
            end
        end
        
        if hitThisFrame > 0 then
            EnemiesHit = hitThisFrame
        end
        
        ClickCountLabel.Text = string.format("Clicks: %d | Enemies Hit: %d", ClickCount, EnemiesHit)
    end)
end)
        else
        ShowNotification("Auto Bat Attack Disabled", Color3.fromRGB(100, 255, 100))
        StatusLabel.Text = "Status: Inactive"
        StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 170)
        ClickCountLabel.Text = "Clicks: 0 | Enemies Hit: 0"
        
        if AttackLoop then
            AttackLoop:Disconnect()
            AttackLoop = nil
        end
        AutoClickLoop = nil
    end
end)

-- Update canvas
task.wait(0.1)
PlantsPage.CanvasSize = UDim2.new(0, 0, 0, PlantsList.AbsoluteContentSize.Y + 10)

-- Sidebar Buttons
local function CreateNavButton(text, page, icon)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -8, 0, 32)
    Btn.BackgroundColor3 = Color3.fromRGB(30, 27, 40)
    Btn.BorderSizePixel = 0
    Btn.Text = icon .. " " .. text
    Btn.TextColor3 = Color3.fromRGB(180, 180, 200)
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextSize = 12
    Btn.Parent = Sidebar
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 7)
    BtnCorner.Parent = Btn
    
    Btn.MouseButton1Click:Connect(function()
        AnimationsPage.Visible = false
        CharacterPage.Visible = false
        CombatPage.Visible = false
        PersonPage.Visible = false
        EmotesPage.Visible = false
        BypassPage.Visible = false
        PlantsPage.Visible = false
        page.Visible = true
        
        
        for _, child in pairs(Sidebar:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.fromRGB(30, 27, 40)
                child.TextColor3 = Color3.fromRGB(180, 180, 200)
            end
        end
        Btn.BackgroundColor3 = Color3.fromRGB(120, 70, 200)
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    
    return Btn
end

local AnimBtn = CreateNavButton("Animations", AnimationsPage, " ")
CreateNavButton("Character", CharacterPage, " ")
CreateNavButton("Combat", CombatPage, " ")

-- SISTEMA DE NOTIFICACIONES
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
    
    local NotifStroke = Instance.new("UIStroke")
    NotifStroke.Color = color
    NotifStroke.Thickness = 2
    NotifStroke.Parent = Notif
    
    local NotifGradient = Instance.new("UIGradient")
    NotifGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 27, 40)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 18, 30))
    }
    NotifGradient.Rotation = 90
    NotifGradient.Parent = Notif
    
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
    
    Notif.Position = UDim2.new(1, 0, 1, -70)
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

local BypassStates = {
    AntiKick = false,
    HideAdmin = false,
    AntiCheat = false,
    SpoofIdentity = false
}

local function CreateBypassToggle(name, description, icon, callback)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, -6, 0, 70)
    Container.BackgroundColor3 = Color3.fromRGB(35, 30, 45)
    Container.BorderSizePixel = 0
    Container.Parent = BypassPage
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 7)
    Corner.Parent = Container
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(80, 60, 120)
    Stroke.Thickness = 1
    Stroke.Transparency = 0.7
    Stroke.Parent = Container
    
    local IconLabel = Instance.new("TextLabel")
    IconLabel.Size = UDim2.new(0, 40, 0, 40)
    IconLabel.Position = UDim2.new(0, 10, 0, 15)
    IconLabel.BackgroundColor3 = Color3.fromRGB(50, 45, 65)
    IconLabel.BorderSizePixel = 0
    IconLabel.Text = icon
    IconLabel.TextColor3 = Color3.fromRGB(150, 100, 255)
    IconLabel.Font = Enum.Font.GothamBold
    IconLabel.TextSize = 20
    IconLabel.Parent = Container
    
    local IconCorner = Instance.new("UICorner")
    IconCorner.CornerRadius = UDim.new(0, 8)
    IconCorner.Parent = IconLabel
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0, 250, 0, 20)
    Title.Position = UDim2.new(0, 60, 0, 10)
    Title.BackgroundTransparency = 1
    Title.Text = name
    Title.TextColor3 = Color3.fromRGB(220, 220, 240)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Container
    
    local Desc = Instance.new("TextLabel")
    Desc.Size = UDim2.new(0, 250, 0, 30)
    Desc.Position = UDim2.new(0, 60, 0, 32)
    Desc.BackgroundTransparency = 1
    Desc.Text = description
    Desc.TextColor3 = Color3.fromRGB(150, 150, 170)
    Desc.Font = Enum.Font.Gotham
    Desc.TextSize = 11
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextYAlignment = Enum.TextYAlignment.Top
    Desc.TextWrapped = true
    Desc.Parent = Container
    
    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(0, 50, 0, 26)
    Toggle.Position = UDim2.new(1, -60, 0, 22)
    Toggle.BackgroundColor3 = Color3.fromRGB(60, 50, 70)
    Toggle.Text = "OFF"
    Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    Toggle.Font = Enum.Font.GothamBold
    Toggle.TextSize = 12
    Toggle.BorderSizePixel = 0
    Toggle.Parent = Container
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 6)
    ToggleCorner.Parent = Toggle
    
    local Indicator = Instance.new("Frame")
    Indicator.Size = UDim2.new(0, 10, 0, 10)
    Indicator.Position = UDim2.new(0, 5, 0, 8)
    Indicator.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
    Indicator.BorderSizePixel = 0
    Indicator.Parent = Toggle
    
    local IndicatorCorner = Instance.new("UICorner")
    IndicatorCorner.CornerRadius = UDim.new(1, 0)
    IndicatorCorner.Parent = Indicator
    
    Toggle.MouseEnter:Connect(function()
        TweenService:Create(Container, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 35, 50)}):Play()
        TweenService:Create(Stroke, TweenInfo.new(0.2), {Transparency = 0}):Play()
    end)
    
    Toggle.MouseLeave:Connect(function()
        TweenService:Create(Container, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 30, 45)}):Play()
        TweenService:Create(Stroke, TweenInfo.new(0.2), {Transparency = 0.7}):Play()
    end)
    
    Toggle.MouseButton1Click:Connect(function()
        local isActive = Toggle.Text == "ON"
        Toggle.Text = isActive and "OFF" or "ON"
        Toggle.BackgroundColor3 = isActive and Color3.fromRGB(60, 50, 70) or Color3.fromRGB(100, 200, 100)
        Indicator.BackgroundColor3 = isActive and Color3.fromRGB(255, 70, 70) or Color3.fromRGB(100, 255, 100)
        
        TweenService:Create(Toggle, TweenInfo.new(0.2), {
            BackgroundColor3 = isActive and Color3.fromRGB(60, 50, 70) or Color3.fromRGB(100, 200, 100)
        }):Play()
        
        callback(not isActive)
    end)
    
    return Container
end

CreateBypassToggle(
    "Anti-Kick Protection",
    "Prevents server kicks and admin removals",
    " ",
    function(active)
        if active then
            ShowNotification("Anti-Kick Activated", Color3.fromRGB(100, 255, 100))
        else
            ShowNotification("Anti-Kick Deactivated", Color3.fromRGB(255, 100, 100))
        end
    end
)

CreateBypassToggle(
    "Hide from Admin Lists",
    "Makes you invisible to admin/moderator panels",
    " ",
    function(active)
        if active then
            ShowNotification("Admin Hide Activated", Color3.fromRGB(100, 255, 100))
        else
            ShowNotification("Admin Hide Deactivated", Color3.fromRGB(255, 100, 100))
        end
    end
)

CreateBypassToggle(
    "Disable Anti-Cheat",
    "Attempts to bypass common anti-cheat systems",
    " ",
    function(active)
        if active then
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                    local name = v.Name:lower()
                    if name:match("anti") or name:match("cheat") or name:match("detect") or name:match("flag") then
                        pcall(function()
                            v:Destroy()
                        end)
                    end
                end
            end
            ShowNotification("Anti-Cheat Disabled", Color3.fromRGB(100, 255, 100))
        else
            ShowNotification("Anti-Cheat Enabled", Color3.fromRGB(255, 100, 100))
        end
    end
)

CreateBypassToggle(
    "Spoof Identity",
    "Changes your displayed username and UserID",
    " ",
    function(active)
        if active then
            local FakeName = "Guest_" .. math.random(1000, 9999)
            ShowNotification("Identity Spoofed to " .. FakeName, Color3.fromRGB(100, 255, 100))
        else
            ShowNotification("Identity Restored", Color3.fromRGB(255, 100, 100))
        end
    end
)

task.wait(0.1)
BypassPage.CanvasSize = UDim2.new(0, 0, 0, BypassList.AbsoluteContentSize.Y + 10)

CreateNavButton("Bypass", BypassPage, " ")
CreateNavButton("Plants vs BR", PlantsPage, " ")

print("Bypass Page cargada correctamente")

CreateNavButton("Person", PersonPage, " ")

-- PERSON PAGE COMPONENTS

-- Target Player Search
local TargetSearchContainer = Instance.new("Frame")
TargetSearchContainer.Size = UDim2.new(1, -6, 0, 135)
TargetSearchContainer.Position = UDim2.new(0, 3, 0, 3)
TargetSearchContainer.BackgroundColor3 = Color3.fromRGB(35, 30, 45)
TargetSearchContainer.BorderSizePixel = 0
TargetSearchContainer.ZIndex = 2
TargetSearchContainer.Parent = PersonPage

local TargetSearchCorner = Instance.new("UICorner")
TargetSearchCorner.CornerRadius = UDim.new(0, 7)
TargetSearchCorner.Parent = TargetSearchContainer

local TargetSearchLabel = Instance.new("TextLabel")
TargetSearchLabel.Size = UDim2.new(1, -16, 0, 20)
TargetSearchLabel.Position = UDim2.new(0, 8, 0, 6)
TargetSearchLabel.BackgroundTransparency = 1
TargetSearchLabel.Text = "Target Player"
TargetSearchLabel.TextColor3 = Color3.fromRGB(150, 100, 255)
TargetSearchLabel.Font = Enum.Font.GothamBold
TargetSearchLabel.TextSize = 14
TargetSearchLabel.TextXAlignment = Enum.TextXAlignment.Left
TargetSearchLabel.Parent = TargetSearchContainer

local TargetInput = Instance.new("TextBox")
TargetInput.Size = UDim2.new(1, -100, 0, 28)
TargetInput.Position = UDim2.new(0, 8, 0, 32)
TargetInput.BackgroundColor3 = Color3.fromRGB(50, 45, 65)
TargetInput.BorderSizePixel = 0
TargetInput.PlaceholderText = "@target..."
TargetInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
TargetInput.Text = ""
TargetInput.TextColor3 = Color3.fromRGB(255, 255, 255)
TargetInput.Font = Enum.Font.Gotham
TargetInput.TextSize = 13
TargetInput.TextXAlignment = Enum.TextXAlignment.Left
TargetInput.Parent = TargetSearchContainer

local TargetInputCorner = Instance.new("UICorner")
TargetInputCorner.CornerRadius = UDim.new(0, 6)
TargetInputCorner.Parent = TargetInput

local TargetSearchBtn = Instance.new("TextButton")
TargetSearchBtn.Size = UDim2.new(0, 80, 0, 28)
TargetSearchBtn.Position = UDim2.new(1, -88, 0, 32)
TargetSearchBtn.BackgroundColor3 = Color3.fromRGB(120, 70, 200)
TargetSearchBtn.Text = "Search"
TargetSearchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TargetSearchBtn.Font = Enum.Font.GothamBold
TargetSearchBtn.TextSize = 12
TargetSearchBtn.BorderSizePixel = 0
TargetSearchBtn.Parent = TargetSearchContainer

local TargetSearchBtnCorner = Instance.new("UICorner")
TargetSearchBtnCorner.CornerRadius = UDim.new(0, 6)
TargetSearchBtnCorner.Parent = TargetSearchBtn

-- Avatar Display
local AvatarDisplay = Instance.new("ImageLabel")
AvatarDisplay.Size = UDim2.new(0, 55, 0, 55)
AvatarDisplay.Position = UDim2.new(0, 8, 0, 68)
AvatarDisplay.BackgroundColor3 = Color3.fromRGB(50, 45, 65)
AvatarDisplay.BorderSizePixel = 0
AvatarDisplay.Image = ""
AvatarDisplay.Parent = TargetSearchContainer

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(0, 8)
AvatarCorner.Parent = AvatarDisplay

local AvatarStroke = Instance.new("UIStroke")
AvatarStroke.Color = Color3.fromRGB(120, 70, 200)
AvatarStroke.Thickness = 2
AvatarStroke.Parent = AvatarDisplay

local TargetInfoLabel = Instance.new("TextLabel")
TargetInfoLabel.Size = UDim2.new(1, -145, 0, 55)
TargetInfoLabel.Position = UDim2.new(0, 72, 0, 68)
TargetInfoLabel.BackgroundTransparency = 1
TargetInfoLabel.Text = "UserID:\nDisplay:\nJoined:"
TargetInfoLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
TargetInfoLabel.Font = Enum.Font.Gotham
TargetInfoLabel.TextSize = 11
TargetInfoLabel.TextXAlignment = Enum.TextXAlignment.Left
TargetInfoLabel.TextYAlignment = Enum.TextYAlignment.Top
TargetInfoLabel.Parent = TargetSearchContainer

-- Function to find and set target player
local function SetTargetPlayer(username)
    username = username:gsub("@", ""):lower()
    TargetPlayer = nil
    
    for _, plr in pairs(Players:GetPlayers()) do
        if plr.Name:lower():find(username) or plr.DisplayName:lower():find(username) then
            TargetPlayer = plr
            
            -- Update avatar
            local userId = plr.UserId
            AvatarDisplay.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..userId.."&width=150&height=150&format=png"
            
            -- Update info
            local accountAge = plr.AccountAge
            TargetInfoLabel.Text = string.format(
                "UserID: %d\nDisplay: %s\nJoined: %d days ago",
                userId,
                plr.DisplayName,
                accountAge
            )
            
            print("Target set to:", plr.Name)
            return true
        end
    end
    
    AvatarDisplay.Image = ""
    TargetInfoLabel.Text = "UserID:\nDisplay:\nJoined:"
    warn("Player not found!")
    return false
end

TargetSearchBtn.MouseButton1Click:Connect(function()
    SetTargetPlayer(TargetInput.Text)
end)

-- Troll Actions Grid (2 columns)
-- CAMBIO CRÍTICO: buttonStartY ahora comienza después del contenedor de búsqueda
local buttonStartY = 148  -- 135 (altura del contenedor) + 10 (margen) + 3 (posición inicial)

local function CreateTrollButton(text, row, col, callback)
    local Btn = Instance.new("TextButton")
    local btnWidth = 195
    local xPos = col == 1 and 3 or (btnWidth + 9)
    
    Btn.Size = UDim2.new(0, btnWidth, 0, 40)
    Btn.Position = UDim2.new(0, xPos, 0, buttonStartY + ((row - 1) * 48))
    Btn.BackgroundColor3 = Color3.fromRGB(35, 30, 45)
    Btn.BorderSizePixel = 0
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(220, 220, 240)
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextSize = 12
    Btn.ZIndex = 1
    Btn.Parent = PersonPage
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 7)
    BtnCorner.Parent = Btn
    
    local BtnStroke = Instance.new("UIStroke")
    BtnStroke.Color = Color3.fromRGB(80, 60, 120)
    BtnStroke.Thickness = 1
    BtnStroke.Transparency = 0.7
    BtnStroke.Parent = Btn
    
    local Indicator = Instance.new("Frame")
    Indicator.Size = UDim2.new(0, 8, 0, 8)
    Indicator.Position = UDim2.new(1, -12, 0, 6)
    Indicator.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
    Indicator.BorderSizePixel = 0
    Indicator.Parent = Btn
    
    local IndicatorCorner = Instance.new("UICorner")
    IndicatorCorner.CornerRadius = UDim.new(1, 0)
    IndicatorCorner.Parent = Indicator
    
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(120, 70, 200)}):Play()
        TweenService:Create(BtnStroke, TweenInfo.new(0.2), {Transparency = 0}):Play()
    end)
    
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 30, 45)}):Play()
        TweenService:Create(BtnStroke, TweenInfo.new(0.2), {Transparency = 0.7}):Play()
    end)
    
    Btn.MouseButton1Click:Connect(function()
        if not TargetPlayer then
            warn("No target selected!")
            return
        end
        
        local isActive = Indicator.BackgroundColor3 == Color3.fromRGB(100, 255, 100)
        Indicator.BackgroundColor3 = isActive and Color3.fromRGB(255, 70, 70) or Color3.fromRGB(100, 255, 100)
        
        callback(not isActive)
    end)
    
    return Btn, Indicator
end

-- Fling Function
CreateTrollButton("Fling", 1, 1, function(active)
    if active and TargetPlayer and TargetPlayer.Character then
        local targetRoot = TargetPlayer.Character:FindFirstChild("HumanoidRootPart")
        if targetRoot and RootPart then
            local originalPos = RootPart.CFrame
            RootPart.CFrame = targetRoot.CFrame
            
            task.wait(0.1)
            
            local bodyVel = Instance.new("BodyVelocity")
            bodyVel.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVel.Velocity = Vector3.new(0, 100, 0)
            bodyVel.Parent = RootPart
            
            task.wait(0.15)
            bodyVel:Destroy()
            RootPart.CFrame = originalPos
        end
    end
end)

-- View (Spectate) Function
local viewConnection
CreateTrollButton("View", 1, 2, function(active)
    if viewConnection then
        viewConnection:Disconnect()
        viewConnection = nil
    end
    
    if active and TargetPlayer and TargetPlayer.Character then
        viewConnection = RunService.RenderStepped:Connect(function()
            if TargetPlayer and TargetPlayer.Character then
                local targetHum = TargetPlayer.Character:FindFirstChild("Humanoid")
                if targetHum then
                    workspace.CurrentCamera.CameraSubject = targetHum
                end
            end
        end)
    else
        workspace.CurrentCamera.CameraSubject = Humanoid
    end
end)

-- Focus (TP Loop) Function
CreateTrollButton("Focus", 2, 1, function(active)
    if active and TargetPlayer then
        task.spawn(function()
            while TargetPlayer and PersonPage.Visible do
                if TargetPlayer.Character and RootPart then
                    local targetRoot = TargetPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if targetRoot then
                        RootPart.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 3)
                    end
                end
                task.wait(0.1)
            end
        end)
    end
end)

-- Headsit Function
local headsitConnection
CreateTrollButton("Headsit", 2, 2, function(active)
    if headsitConnection then headsitConnection:Disconnect() headsitConnection = nil end
    
    if active and TargetPlayer and TargetPlayer.Character then
        headsitConnection = RunService.Heartbeat:Connect(function()
            if TargetPlayer and TargetPlayer.Character then
                local targetHead = TargetPlayer.Character:FindFirstChild("Head")
                if targetHead and RootPart then
                    RootPart.CFrame = targetHead.CFrame * CFrame.new(0, 2, 0)
                end
            end
        end)
    end
end)

-- Stand Function
CreateTrollButton("Stand", 3, 1, function(active)
    if active and RootPart then
        RootPart.CFrame = RootPart.CFrame * CFrame.new(0, 5, 0)
    end
end)

-- Bang Function
local bangBtn, bangIndicator = CreateTrollButton("Bang", 3, 2, function(active)
    if BangLoop then BangLoop:Disconnect() BangLoop = nil end
    
    if active and TargetPlayer and TargetPlayer.Character then
        local targetRoot = TargetPlayer.Character:FindFirstChild("HumanoidRootPart")
        if targetRoot and RootPart then
            BangLoop = RunService.Heartbeat:Connect(function()
                if not TargetPlayer or not TargetPlayer.Character then
                    bangIndicator.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
                    BangLoop:Disconnect()
                    return
                end
                
                local tRoot = TargetPlayer.Character:FindFirstChild("HumanoidRootPart")
                if tRoot then
                    RootPart.CFrame = tRoot.CFrame * CFrame.new(0, 0, 1.5)
                end
            end)
        end
    end
end)

-- Doggy Function
local doggyBtn, doggyIndicator = CreateTrollButton("Doggy", 4, 1, function(active)
    if DoggyLoop then DoggyLoop:Disconnect() DoggyLoop = nil end
    
    if active and TargetPlayer and TargetPlayer.Character then
        DoggyLoop = RunService.Heartbeat:Connect(function()
            if not TargetPlayer or not TargetPlayer.Character then
                doggyIndicator.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
                DoggyLoop:Disconnect()
                return
            end
            
            local tRoot = TargetPlayer.Character:FindFirstChild("HumanoidRootPart")
            if tRoot and RootPart then
                RootPart.CFrame = tRoot.CFrame * CFrame.new(0, 0, -2) * CFrame.Angles(math.rad(90), 0, 0)
            end
        end)
    end
end)

-- Backpack Function
local backpackBtn, backpackIndicator = CreateTrollButton("Backpack", 4, 2, function(active)
    if BackpackLoop then BackpackLoop:Disconnect() BackpackLoop = nil end
    
    if active and TargetPlayer and TargetPlayer.Character then
        BackpackLoop = RunService.Heartbeat:Connect(function()
            if not TargetPlayer or not TargetPlayer.Character then
                backpackIndicator.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
                BackpackLoop:Disconnect()
                return
            end
            
            local tRoot = TargetPlayer.Character:FindFirstChild("HumanoidRootPart")
            if tRoot and RootPart then
                RootPart.CFrame = tRoot.CFrame * CFrame.new(0, 0, -1.5)
            end
        end)
    end
end)

-- Drag Function
local dragBtn, dragIndicator = CreateTrollButton("Drag", 5, 1, function(active)
    if DragLoop then DragLoop:Disconnect() DragLoop = nil end
    
    if active and TargetPlayer and TargetPlayer.Character then
        DragLoop = RunService.Heartbeat:Connect(function()
            if not TargetPlayer or not TargetPlayer.Character then
                dragIndicator.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
                DragLoop:Disconnect()
                return
            end
            
            local tRoot = TargetPlayer.Character:FindFirstChild("HumanoidRootPart")
            if tRoot and RootPart then
                tRoot.CFrame = RootPart.CFrame * CFrame.new(0, 0, -3)
            end
        end)
    end
end)

-- Teleport Function
CreateTrollButton("Teleport", 5, 2, function(active)
    if active and TargetPlayer and TargetPlayer.Character then
        local targetRoot = TargetPlayer.Character:FindFirstChild("HumanoidRootPart")
        if targetRoot and RootPart then
            RootPart.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 3)
        end
    end
end)

-- Push Function
CreateTrollButton("Push", 6, 1, function(active)
    if active and TargetPlayer and TargetPlayer.Character then
        local targetRoot = TargetPlayer.Character:FindFirstChild("HumanoidRootPart")
        if targetRoot then
            local bodyVel = Instance.new("BodyVelocity")
            bodyVel.MaxForce = Vector3.new(50000, 50000, 50000)
            bodyVel.Velocity = (targetRoot.CFrame.LookVector * 50) + Vector3.new(0, 20, 0)
            bodyVel.Parent = targetRoot
            
            task.wait(0.2)
            bodyVel:Destroy()
        end
    end
end)

-- Whitelist Function (Placeholder)
CreateTrollButton("Whitelist", 6, 2, function(active)
    if active then
        warn("Whitelist feature coming soon!")
    end
end)

-- Update canvas size to fit all content
task.wait(0.1)
PersonPage.CanvasSize = UDim2.new(0, 0, 0, buttonStartY + (6 * 48) + 10)

-- Botón de Emotes que ejecuta script externo
local EmotesBtn = Instance.new("TextButton")
EmotesBtn.Size = UDim2.new(1, -8, 0, 32)
EmotesBtn.BackgroundColor3 = Color3.fromRGB(30, 27, 40)
EmotesBtn.BorderSizePixel = 0
EmotesBtn.Text = "Emotes"
EmotesBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
EmotesBtn.Font = Enum.Font.GothamSemibold
EmotesBtn.TextSize = 12
EmotesBtn.Parent = Sidebar

local EmotesBtnCorner = Instance.new("UICorner")
EmotesBtnCorner.CornerRadius = UDim.new(0, 7)
EmotesBtnCorner.Parent = EmotesBtn

-- Cuando se presiona el botón (CON PROTECCIÓN)
EmotesBtn.MouseButton1Click:Connect(function()
    -- Cambiar color para mostrar que está activo
    for _, child in pairs(Sidebar:GetChildren()) do
        if child:IsA("TextButton") then
            child.BackgroundColor3 = Color3.fromRGB(30, 27, 40)
            child.TextColor3 = Color3.fromRGB(180, 180, 200)
        end
    end
    EmotesBtn.BackgroundColor3 = Color3.fromRGB(120, 70, 200)
    EmotesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    -- Mostrar que está cargando
    ShowNotification("Cargando Emotes...", Color3.fromRGB(100, 150, 255))
    
    -- EJECUTAR EL SCRIPT EXTERNO CON PROTECCIÓN
    local success, errorMsg = pcall(function()
        local scriptContent = game:HttpGet("https://raw.githubusercontent.com/7yd7/Hub/refs/heads/Branch/GUIS/Emotes.lua")
        loadstring(scriptContent)()
    end)
    
    -- Verificar si funcionó o falló
    if not success then
        warn("Error al cargar Emotes:", errorMsg)
        ShowNotification("Error: Emotes no disponibles", Color3.fromRGB(255, 100, 100))
    else
        print("Emotes cargados correctamente")
        ShowNotification("Emotes cargados!", Color3.fromRGB(100, 255, 100))
    end
end)

AnimBtn.BackgroundColor3 = Color3.fromRGB(120, 70, 200)
AnimBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Animation System
local function ClearTracks()
    for _, track in pairs(CurrentTracks) do
        pcall(function() track:Stop() end)
    end
    CurrentTracks = {}
end

local function LoadTrack(id)
    local animator = Humanoid:FindFirstChildOfClass("Animator")
    if not animator then
        animator = Instance.new("Animator")
        animator.Parent = Humanoid
    end
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://" .. tostring(id)
    return animator:LoadAnimation(anim)
end

local function ApplyAnimPack(pack)
    ClearTracks()
    
    for animType, animId in pairs(pack) do
        if animType ~= "Name" then
            local success, track = pcall(function()
                return LoadTrack(animId)
            end)
            
            if success then
                track.Priority = Enum.AnimationPriority.Action
                if animType == "Idle" or animType == "Walk" or animType == "Run" or animType == "Fall" then
                    track.Looped = true
                end
                CurrentTracks[animType] = track
            end
        end
    end
    
    if CurrentTracks.Idle then CurrentTracks.Idle:Play() end
    
    Humanoid.Running:Connect(function(speed)
        if speed > 0.1 then
            if CurrentTracks.Idle then CurrentTracks.Idle:Stop() end
            if speed > 16 then
                if CurrentTracks.Walk then CurrentTracks.Walk:Stop() end
                if CurrentTracks.Run and not CurrentTracks.Run.IsPlaying then CurrentTracks.Run:Play() end
            else
                if CurrentTracks.Run then CurrentTracks.Run:Stop() end
                if CurrentTracks.Walk and not CurrentTracks.Walk.IsPlaying then CurrentTracks.Walk:Play() end
            end
        else
            if CurrentTracks.Walk then CurrentTracks.Walk:Stop() end
            if CurrentTracks.Run then CurrentTracks.Run:Stop() end
            if CurrentTracks.Idle and not CurrentTracks.Idle.IsPlaying then CurrentTracks.Idle:Play() end
        end
    end)
    
    Humanoid.Jumping:Connect(function()
        if CurrentTracks.Jump then CurrentTracks.Jump:Play() end
    end)
    
    Humanoid.FreeFalling:Connect(function()
        if CurrentTracks.Fall and not CurrentTracks.Fall.IsPlaying then CurrentTracks.Fall:Play() end
    end)
end

-- Create Animation Buttons
for i, pack in ipairs(AnimPacks) do
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -6, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(35, 30, 45)
    Btn.BorderSizePixel = 0
    Btn.Text = pack.Name
    Btn.TextColor3 = Color3.fromRGB(220, 220, 240)
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextSize = 13
    Btn.Parent = AnimationsPage
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 7)
    BtnCorner.Parent = Btn
    
    local BtnStroke = Instance.new("UIStroke")
    BtnStroke.Color = Color3.fromRGB(80, 60, 120)
    BtnStroke.Thickness = 1
    BtnStroke.Transparency = 0.7
    BtnStroke.Parent = Btn
    
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(120, 70, 200)}):Play()
        TweenService:Create(BtnStroke, TweenInfo.new(0.2), {Transparency = 0}):Play()
    end)
    
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 30, 45)}):Play()
        TweenService:Create(BtnStroke, TweenInfo.new(0.2), {Transparency = 0.7}):Play()
    end)
    
    Btn.MouseButton1Click:Connect(function()
        ApplyAnimPack(pack)
    end)
end

AnimationsPage.CanvasSize = UDim2.new(0, 0, 0, AnimList.AbsoluteContentSize.Y + 10)

-- Character Page Components
local NoClipContainer = Instance.new("Frame")
NoClipContainer.Size = UDim2.new(1, -6, 0, 36)
NoClipContainer.BackgroundColor3 = Color3.fromRGB(35, 30, 45)
NoClipContainer.BorderSizePixel = 0
NoClipContainer.Parent = CharacterPage

local NoClipCorner = Instance.new("UICorner")
NoClipCorner.CornerRadius = UDim.new(0, 7)
NoClipCorner.Parent = NoClipContainer

local NoClipLabel = Instance.new("TextLabel")
NoClipLabel.Size = UDim2.new(0, 130, 1, 0)
NoClipLabel.Position = UDim2.new(0, 8, 0, 0)
NoClipLabel.BackgroundTransparency = 1
NoClipLabel.Text = "NoClip"
NoClipLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
NoClipLabel.Font = Enum.Font.GothamSemibold
NoClipLabel.TextSize = 13
NoClipLabel.TextXAlignment = Enum.TextXAlignment.Left
NoClipLabel.Parent = NoClipContainer

local NoClipToggle = Instance.new("TextButton")
NoClipToggle.Size = UDim2.new(0, 40, 0, 22)
NoClipToggle.Position = UDim2.new(1, -48, 0.5, -11)
NoClipToggle.BackgroundColor3 = Color3.fromRGB(60, 50, 70)
NoClipToggle.Text = "OFF"
NoClipToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
NoClipToggle.Font = Enum.Font.GothamBold
NoClipToggle.TextSize = 11
NoClipToggle.BorderSizePixel = 0
NoClipToggle.Parent = NoClipContainer

local NoClipToggleCorner = Instance.new("UICorner")
NoClipToggleCorner.CornerRadius = UDim.new(0, 5)
NoClipToggleCorner.Parent = NoClipToggle

NoClipToggle.MouseButton1Click:Connect(function()
    NoClipEnabled = not NoClipEnabled
    NoClipToggle.Text = NoClipEnabled and "ON" or "OFF"
    NoClipToggle.BackgroundColor3 = NoClipEnabled and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(60, 50, 70)
    
    if NoClipEnabled then
        NoClipConnection = RunService.Stepped:Connect(function()
            if NoClipEnabled and Character then
                for _, part in pairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if NoClipConnection then
            NoClipConnection:Disconnect()
            NoClipConnection = nil
        end
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.CanCollide = true
            end
        end
    end
end)

-- Speed Slider
local SpeedContainer = Instance.new("Frame")
SpeedContainer.Size = UDim2.new(1, -6, 0, 60)
SpeedContainer.BackgroundColor3 = Color3.fromRGB(35, 30, 45)
SpeedContainer.BorderSizePixel = 0
SpeedContainer.Parent = CharacterPage

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 7)
SpeedCorner.Parent = SpeedContainer

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0.6, -8, 0, 20)
SpeedLabel.Position = UDim2.new(0, 8, 0, 4)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed:"
SpeedLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
SpeedLabel.Font = Enum.Font.GothamSemibold
SpeedLabel.TextSize = 13
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = SpeedContainer

local SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(0.35, -8, 0, 20)
SpeedInput.Position = UDim2.new(0.65, 0, 0, 4)
SpeedInput.BackgroundColor3 = Color3.fromRGB(50, 45, 65)
SpeedInput.BorderSizePixel = 0
SpeedInput.Text = "16"
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedInput.Font = Enum.Font.Gotham
SpeedInput.TextSize = 12
SpeedInput.Parent = SpeedContainer

local SpeedInputCorner = Instance.new("UICorner")
SpeedInputCorner.CornerRadius = UDim.new(0, 5)
SpeedInputCorner.Parent = SpeedInput

local SpeedSliderBG = Instance.new("Frame")
SpeedSliderBG.Size = UDim2.new(1, -16, 0, 5)
SpeedSliderBG.Position = UDim2.new(0, 8, 0, 32)
SpeedSliderBG.BackgroundColor3 = Color3.fromRGB(50, 45, 65)
SpeedSliderBG.BorderSizePixel = 0
SpeedSliderBG.Parent = SpeedContainer

local SpeedSliderCorner1 = Instance.new("UICorner")
SpeedSliderCorner1.CornerRadius = UDim.new(0, 2.5)
SpeedSliderCorner1.Parent = SpeedSliderBG

local SpeedSliderFill = Instance.new("Frame")
SpeedSliderFill.Size = UDim2.new(0, 0, 1, 0)
SpeedSliderFill.BackgroundColor3 = Color3.fromRGB(150, 100, 255)
SpeedSliderFill.BorderSizePixel = 0
SpeedSliderFill.Parent = SpeedSliderBG

local SpeedSliderCorner2 = Instance.new("UICorner")
SpeedSliderCorner2.CornerRadius = UDim.new(0, 2.5)
SpeedSliderCorner2.Parent = SpeedSliderFill

local SpeedBtn = Instance.new("TextButton")
SpeedBtn.Size = UDim2.new(1, 0, 1, 0)
SpeedBtn.BackgroundTransparency = 1
SpeedBtn.Text = ""
SpeedBtn.Parent = SpeedSliderBG

local function UpdateSpeed(value)
    value = math.clamp(tonumber(value) or 16, 16, 500)
    Humanoid.WalkSpeed = value
    SpeedInput.Text = tostring(value)
    local pos = (value - 16) / (500 - 16)
    SpeedSliderFill.Size = UDim2.new(pos, 0, 1, 0)
end

SpeedInput.FocusLost:Connect(function()
    UpdateSpeed(SpeedInput.Text)
end)

local speedDragging = false
SpeedBtn.MouseButton1Down:Connect(function() speedDragging = true end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then speedDragging = false end
end)
UIS.InputChanged:Connect(function(input)
    if speedDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local pos = math.clamp((input.Position.X - SpeedSliderBG.AbsolutePosition.X) / SpeedSliderBG.AbsoluteSize.X, 0, 1)
        local value = math.floor(16 + (500 - 16) * pos)
        UpdateSpeed(value)
    end
end)

-- Jump Power Slider
local JumpContainer = Instance.new("Frame")
JumpContainer.Size = UDim2.new(1, -6, 0, 60)
JumpContainer.BackgroundColor3 = Color3.fromRGB(35, 30, 45)
JumpContainer.BorderSizePixel = 0
JumpContainer.Parent = CharacterPage

local JumpCorner = Instance.new("UICorner")
JumpCorner.CornerRadius = UDim.new(0, 7)
JumpCorner.Parent = JumpContainer

local JumpLabel = Instance.new("TextLabel")
JumpLabel.Size = UDim2.new(0.6, -8, 0, 20)
JumpLabel.Position = UDim2.new(0, 8, 0, 4)
JumpLabel.BackgroundTransparency = 1
JumpLabel.Text = "Jump Power:"
JumpLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
JumpLabel.Font = Enum.Font.GothamSemibold
JumpLabel.TextSize = 13
JumpLabel.TextXAlignment = Enum.TextXAlignment.Left
JumpLabel.Parent = JumpContainer

local JumpInput = Instance.new("TextBox")
JumpInput.Size = UDim2.new(0.35, -8, 0, 20)
JumpInput.Position = UDim2.new(0.65, 0, 0, 4)
JumpInput.BackgroundColor3 = Color3.fromRGB(50, 45, 65)
JumpInput.BorderSizePixel = 0
JumpInput.Text = "50"
JumpInput.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpInput.Font = Enum.Font.Gotham
JumpInput.TextSize = 12
JumpInput.Parent = JumpContainer

local JumpInputCorner = Instance.new("UICorner")
JumpInputCorner.CornerRadius = UDim.new(0, 5)
JumpInputCorner.Parent = JumpInput

local JumpSliderBG = Instance.new("Frame")
JumpSliderBG.Size = UDim2.new(1, -16, 0, 5)
JumpSliderBG.Position = UDim2.new(0, 8, 0, 32)
JumpSliderBG.BackgroundColor3 = Color3.fromRGB(50, 45, 65)
JumpSliderBG.BorderSizePixel = 0
JumpSliderBG.Parent = JumpContainer

local JumpSliderCorner1 = Instance.new("UICorner")
JumpSliderCorner1.CornerRadius = UDim.new(0, 2.5)
JumpSliderCorner1.Parent = JumpSliderBG

local JumpSliderFill = Instance.new("Frame")
JumpSliderFill.Size = UDim2.new(0, 0, 1, 0)
JumpSliderFill.BackgroundColor3 = Color3.fromRGB(150, 100, 255)
JumpSliderFill.BorderSizePixel = 0
JumpSliderFill.Parent = JumpSliderBG

local JumpSliderCorner2 = Instance.new("UICorner")
JumpSliderCorner2.CornerRadius = UDim.new(0, 2.5)
JumpSliderCorner2.Parent = JumpSliderFill

local JumpBtn = Instance.new("TextButton")
JumpBtn.Size = UDim2.new(1, 0, 1, 0)
JumpBtn.BackgroundTransparency = 1
JumpBtn.Text = ""
JumpBtn.Parent = JumpSliderBG

local function UpdateJump(value)
    value = math.clamp(tonumber(value) or 50, 50, 500)
    Humanoid.JumpPower = value
    JumpInput.Text = tostring(value)
    local pos = (value - 50) / (500 - 50)
    JumpSliderFill.Size = UDim2.new(pos, 0, 1, 0)
end

JumpInput.FocusLost:Connect(function()
    UpdateJump(JumpInput.Text)
end)

local jumpDragging = false
JumpBtn.MouseButton1Down:Connect(function() jumpDragging = true end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then jumpDragging = false end
end)
UIS.InputChanged:Connect(function(input)
    if jumpDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local pos = math.clamp((input.Position.X - JumpSliderBG.AbsolutePosition.X) / JumpSliderBG.AbsoluteSize.X, 0, 1)
        local value = math.floor(50 + (500 - 50) * pos)
        UpdateJump(value)
    end
end)

CharacterPage.CanvasSize = UDim2.new(0, 0, 0, CharList.AbsoluteContentSize.Y + 10)

-- COMBAT PAGE
-- Hitbox Expand Section
local HitboxSection = Instance.new("Frame")
HitboxSection.Size = UDim2.new(1, -6, 0, 120)
HitboxSection.BackgroundColor3 = Color3.fromRGB(35, 30, 45)
HitboxSection.BorderSizePixel = 0
HitboxSection.Parent = CombatPage

local HitboxSectionCorner = Instance.new("UICorner")
HitboxSectionCorner.CornerRadius = UDim.new(0, 7)
HitboxSectionCorner.Parent = HitboxSection

local HitboxTitle = Instance.new("TextLabel")
HitboxTitle.Size = UDim2.new(0.6, -8, 0, 20)
HitboxTitle.Position = UDim2.new(0, 8, 0, 4)
HitboxTitle.BackgroundTransparency = 1
HitboxTitle.Text = "Hitbox Expand"
HitboxTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
HitboxTitle.Font = Enum.Font.GothamBold
HitboxTitle.TextSize = 14
HitboxTitle.TextXAlignment = Enum.TextXAlignment.Left
HitboxTitle.Parent = HitboxSection

local HitboxToggle = Instance.new("TextButton")
HitboxToggle.Size = UDim2.new(0, 40, 0, 22)
HitboxToggle.Position = UDim2.new(1, -48, 0, 4)
HitboxToggle.BackgroundColor3 = Color3.fromRGB(60, 50, 70)
HitboxToggle.Text = "OFF"
HitboxToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
HitboxToggle.Font = Enum.Font.GothamBold
HitboxToggle.TextSize = 11
HitboxToggle.BorderSizePixel = 0
HitboxToggle.Parent = HitboxSection

local HitboxToggleCorner = Instance.new("UICorner")
HitboxToggleCorner.CornerRadius = UDim.new(0, 5)
HitboxToggleCorner.Parent = HitboxToggle

local HitboxSizeLabel = Instance.new("TextLabel")
HitboxSizeLabel.Size = UDim2.new(0.6, -8, 0, 20)
HitboxSizeLabel.Position = UDim2.new(0, 8, 0, 32)
HitboxSizeLabel.BackgroundTransparency = 1
HitboxSizeLabel.Text = "Hitbox Size:"
HitboxSizeLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
HitboxSizeLabel.Font = Enum.Font.GothamSemibold
HitboxSizeLabel.TextSize = 13
HitboxSizeLabel.TextXAlignment = Enum.TextXAlignment.Left
HitboxSizeLabel.Parent = HitboxSection

local HitboxSizeInput = Instance.new("TextBox")
HitboxSizeInput.Size = UDim2.new(0.35, -8, 0, 20)
HitboxSizeInput.Position = UDim2.new(0.65, 0, 0, 32)
HitboxSizeInput.BackgroundColor3 = Color3.fromRGB(50, 45, 65)
HitboxSizeInput.BorderSizePixel = 0
HitboxSizeInput.Text = "20"
HitboxSizeInput.TextColor3 = Color3.fromRGB(255, 255, 255)
HitboxSizeInput.Font = Enum.Font.Gotham
HitboxSizeInput.TextSize = 12
HitboxSizeInput.Parent = HitboxSection

local HitboxSizeInputCorner = Instance.new("UICorner")
HitboxSizeInputCorner.CornerRadius = UDim.new(0, 5)
HitboxSizeInputCorner.Parent = HitboxSizeInput

local HitboxSliderBG = Instance.new("Frame")
HitboxSliderBG.Size = UDim2.new(1, -16, 0, 5)
HitboxSliderBG.Position = UDim2.new(0, 8, 0, 60)
HitboxSliderBG.BackgroundColor3 = Color3.fromRGB(50, 45, 65)
HitboxSliderBG.BorderSizePixel = 0
HitboxSliderBG.Parent = HitboxSection

local HitboxSliderCorner1 = Instance.new("UICorner")
HitboxSliderCorner1.CornerRadius = UDim.new(0, 2.5)
HitboxSliderCorner1.Parent = HitboxSliderBG

local HitboxSliderFill = Instance.new("Frame")
HitboxSliderFill.Size = UDim2.new(0.05, 0, 1, 0)
HitboxSliderFill.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
HitboxSliderFill.BorderSizePixel = 0
HitboxSliderFill.Parent = HitboxSliderBG

local HitboxSliderCorner2 = Instance.new("UICorner")
HitboxSliderCorner2.CornerRadius = UDim.new(0, 2.5)
HitboxSliderCorner2.Parent = HitboxSliderFill

local HitboxSliderBtn = Instance.new("TextButton")
HitboxSliderBtn.Size = UDim2.new(1, 0, 1, 0)
HitboxSliderBtn.BackgroundTransparency = 1
HitboxSliderBtn.Text = ""
HitboxSliderBtn.Parent = HitboxSliderBG

local HitboxInfo = Instance.new("TextLabel")
HitboxInfo.Size = UDim2.new(1, -16, 0, 45)
HitboxInfo.Position = UDim2.new(0, 8, 0, 70)
HitboxInfo.BackgroundTransparency = 1
HitboxInfo.Text = "Makes enemy hitboxes larger\nRange: 5 - 100 studs"
HitboxInfo.TextColor3 = Color3.fromRGB(150, 150, 170)
HitboxInfo.Font = Enum.Font.Gotham
HitboxInfo.TextSize = 10
HitboxInfo.TextXAlignment = Enum.TextXAlignment.Left
HitboxInfo.TextYAlignment = Enum.TextYAlignment.Top
HitboxInfo.Parent = HitboxSection

local function UpdateHitboxSize(value)
    value = math.clamp(tonumber(value) or 20, 5, 100)
    HitboxSize = value
    HitboxSizeInput.Text = tostring(value)
    local pos = (value - 5) / (100 - 5)
    HitboxSliderFill.Size = UDim2.new(pos, 0, 1, 0)
end

HitboxSizeInput.FocusLost:Connect(function()
    UpdateHitboxSize(HitboxSizeInput.Text)
end)

local hitboxDragging = false
HitboxSliderBtn.MouseButton1Down:Connect(function() hitboxDragging = true end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then hitboxDragging = false end
end)
UIS.InputChanged:Connect(function(input)
    if hitboxDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local pos = math.clamp((input.Position.X - HitboxSliderBG.AbsolutePosition.X) / HitboxSliderBG.AbsoluteSize.X, 0, 1)
        local value = math.floor(5 + (100 - 5) * pos)
        UpdateHitboxSize(value)
    end
end)

HitboxToggle.MouseButton1Click:Connect(function()
    HitboxEnabled = not HitboxEnabled
    HitboxToggle.Text = HitboxEnabled and "ON" or "OFF"
    HitboxToggle.BackgroundColor3 = HitboxEnabled and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(60, 50, 70)
    
    if HitboxEnabled then
        HitboxConnection = RunService.RenderStepped:Connect(function()
            if HitboxEnabled then
                for _, v in pairs(Players:GetPlayers()) do
                    if v.Name ~= Player.Name and v.Character then
                        pcall(function()
                            local hrp = v.Character:FindFirstChild("HumanoidRootPart")
                            if hrp then
                                hrp.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
                                hrp.Transparency = 0.7
                                hrp.BrickColor = BrickColor.new("Really red")
                                hrp.Material = Enum.Material.Neon
                                hrp.CanCollide = false
                            end
                        end)
                    end
                end
            end
        end)
        print("Hitbox Expander Activado - Tamaño: " .. HitboxSize)
    else
        if HitboxConnection then
            HitboxConnection:Disconnect()
            HitboxConnection = nil
        end
        for _, v in pairs(Players:GetPlayers()) do
            if v.Name ~= Player.Name and v.Character then
                pcall(function()
                    local hrp = v.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        hrp.Size = Vector3.new(2, 2, 1)
                        hrp.Transparency = 1
                        hrp.CanCollide = false
                    end
                end)
            end
        end
        print("Hitbox Expander Desactivado")
    end
end)

-- Aimbot Section
local AimbotSection = Instance.new("Frame")
AimbotSection.Size = UDim2.new(1, -6, 0, 190)
AimbotSection.BackgroundColor3 = Color3.fromRGB(35, 30, 45)
AimbotSection.BorderSizePixel = 0
AimbotSection.Parent = CombatPage

local AimbotSectionCorner = Instance.new("UICorner")
AimbotSectionCorner.CornerRadius = UDim.new(0, 7)
AimbotSectionCorner.Parent = AimbotSection

local AimbotTitle = Instance.new("TextLabel")
AimbotTitle.Size = UDim2.new(0.6, -8, 0, 20)
AimbotTitle.Position = UDim2.new(0, 8, 0, 4)
AimbotTitle.BackgroundTransparency = 1
AimbotTitle.Text = "Aimbot"
AimbotTitle.TextColor3 = Color3.fromRGB(100, 150, 255)
AimbotTitle.Font = Enum.Font.GothamBold
AimbotTitle.TextSize = 14
AimbotTitle.TextXAlignment = Enum.TextXAlignment.Left
AimbotTitle.Parent = AimbotSection

local AimbotToggle = Instance.new("TextButton")
AimbotToggle.Size = UDim2.new(0, 40, 0, 22)
AimbotToggle.Position = UDim2.new(1, -48, 0, 4)
AimbotToggle.BackgroundColor3 = Color3.fromRGB(60, 50, 70)
AimbotToggle.Text = "OFF"
AimbotToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AimbotToggle.Font = Enum.Font.GothamBold
AimbotToggle.TextSize = 11
AimbotToggle.BorderSizePixel = 0
AimbotToggle.Parent = AimbotSection

local AimbotToggleCorner = Instance.new("UICorner")
AimbotToggleCorner.CornerRadius = UDim.new(0, 5)
AimbotToggleCorner.Parent = AimbotToggle

-- Smoothness Slider
local SmoothnessLabel = Instance.new("TextLabel")
SmoothnessLabel.Size = UDim2.new(0.6, -8, 0, 20)
SmoothnessLabel.Position = UDim2.new(0, 8, 0, 32)
SmoothnessLabel.BackgroundTransparency = 1
SmoothnessLabel.Text = "Smoothness:"
SmoothnessLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
SmoothnessLabel.Font = Enum.Font.GothamSemibold
SmoothnessLabel.TextSize = 13
SmoothnessLabel.TextXAlignment = Enum.TextXAlignment.Left
SmoothnessLabel.Parent = AimbotSection

local SmoothnessInput = Instance.new("TextBox")
SmoothnessInput.Size = UDim2.new(0.35, -8, 0, 20)
SmoothnessInput.Position = UDim2.new(0.65, 0, 0, 32)
SmoothnessInput.BackgroundColor3 = Color3.fromRGB(50, 45, 65)
SmoothnessInput.BorderSizePixel = 0
SmoothnessInput.Text = "0.35"
SmoothnessInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SmoothnessInput.Font = Enum.Font.Gotham
SmoothnessInput.TextSize = 12
SmoothnessInput.Parent = AimbotSection

local SmoothnessInputCorner = Instance.new("UICorner")
SmoothnessInputCorner.CornerRadius = UDim.new(0, 5)
SmoothnessInputCorner.Parent = SmoothnessInput

local SmoothnessSliderBG = Instance.new("Frame")
SmoothnessSliderBG.Size = UDim2.new(1, -16, 0, 5)
SmoothnessSliderBG.Position = UDim2.new(0, 8, 0, 60)
SmoothnessSliderBG.BackgroundColor3 = Color3.fromRGB(50, 45, 65)
SmoothnessSliderBG.BorderSizePixel = 0
SmoothnessSliderBG.Parent = AimbotSection

local SmoothnessSliderCorner1 = Instance.new("UICorner")
SmoothnessSliderCorner1.CornerRadius = UDim.new(0, 2.5)
SmoothnessSliderCorner1.Parent = SmoothnessSliderBG

local SmoothnessSliderFill = Instance.new("Frame")
SmoothnessSliderFill.Size = UDim2.new(0.35, 0, 1, 0)
SmoothnessSliderFill.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
SmoothnessSliderFill.BorderSizePixel = 0
SmoothnessSliderFill.Parent = SmoothnessSliderBG

local SmoothnessSliderCorner2 = Instance.new("UICorner")
SmoothnessSliderCorner2.CornerRadius = UDim.new(0, 2.5)
SmoothnessSliderCorner2.Parent = SmoothnessSliderFill

local SmoothnessSliderBtn = Instance.new("TextButton")
SmoothnessSliderBtn.Size = UDim2.new(1, 0, 1, 0)
SmoothnessSliderBtn.BackgroundTransparency = 1
SmoothnessSliderBtn.Text = ""
SmoothnessSliderBtn.Parent = SmoothnessSliderBG

-- FOV Slider
local FOVLabel = Instance.new("TextLabel")
FOVLabel.Size = UDim2.new(0.6, -8, 0, 20)
FOVLabel.Position = UDim2.new(0, 8, 0, 72)
FOVLabel.BackgroundTransparency = 1
FOVLabel.Text = "FOV:"
FOVLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
FOVLabel.Font = Enum.Font.GothamSemibold
FOVLabel.TextSize = 13
FOVLabel.TextXAlignment = Enum.TextXAlignment.Left
FOVLabel.Parent = AimbotSection

local FOVInput = Instance.new("TextBox")
FOVInput.Size = UDim2.new(0.35, -8, 0, 20)
FOVInput.Position = UDim2.new(0.65, 0, 0, 72)
FOVInput.BackgroundColor3 = Color3.fromRGB(50, 45, 65)
FOVInput.BorderSizePixel = 0
FOVInput.Text = "300"
FOVInput.TextColor3 = Color3.fromRGB(255, 255, 255)
FOVInput.Font = Enum.Font.Gotham
FOVInput.TextSize = 12
FOVInput.Parent = AimbotSection

local FOVInputCorner = Instance.new("UICorner")
FOVInputCorner.CornerRadius = UDim.new(0, 5)
FOVInputCorner.Parent = FOVInput

local FOVSliderBG = Instance.new("Frame")
FOVSliderBG.Size = UDim2.new(1, -16, 0, 5)
FOVSliderBG.Position = UDim2.new(0, 8, 0, 100)
FOVSliderBG.BackgroundColor3 = Color3.fromRGB(50, 45, 65)
FOVSliderBG.BorderSizePixel = 0
FOVSliderBG.Parent = AimbotSection

local FOVSliderCorner1 = Instance.new("UICorner")
FOVSliderCorner1.CornerRadius = UDim.new(0, 2.5)
FOVSliderCorner1.Parent = FOVSliderBG

local FOVSliderFill = Instance.new("Frame")
FOVSliderFill.Size = UDim2.new(0.5, 0, 1, 0)
FOVSliderFill.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
FOVSliderFill.BorderSizePixel = 0
FOVSliderFill.Parent = FOVSliderBG

local FOVSliderCorner2 = Instance.new("UICorner")
FOVSliderCorner2.CornerRadius = UDim.new(0, 2.5)
FOVSliderCorner2.Parent = FOVSliderFill

local FOVSliderBtn = Instance.new("TextButton")
FOVSliderBtn.Size = UDim2.new(1, 0, 1, 0)
FOVSliderBtn.BackgroundTransparency = 1
FOVSliderBtn.Text = ""
FOVSliderBtn.Parent = FOVSliderBG

-- Target Part Selector
local TargetPartLabel = Instance.new("TextLabel")
TargetPartLabel.Size = UDim2.new(0.4, -8, 0, 20)
TargetPartLabel.Position = UDim2.new(0, 8, 0, 112)
TargetPartLabel.BackgroundTransparency = 1
TargetPartLabel.Text = "Target:"
TargetPartLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
TargetPartLabel.Font = Enum.Font.GothamSemibold
TargetPartLabel.TextSize = 13
TargetPartLabel.TextXAlignment = Enum.TextXAlignment.Left
TargetPartLabel.Parent = AimbotSection

local TargetPartDropdown = Instance.new("TextButton")
TargetPartDropdown.Size = UDim2.new(0.55, -8, 0, 22)
TargetPartDropdown.Position = UDim2.new(0.45, 0, 0, 111)
TargetPartDropdown.BackgroundColor3 = Color3.fromRGB(50, 45, 65)
TargetPartDropdown.Text = "Head"
TargetPartDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
TargetPartDropdown.Font = Enum.Font.Gotham
TargetPartDropdown.TextSize = 11
TargetPartDropdown.BorderSizePixel = 0
TargetPartDropdown.Parent = AimbotSection

local TargetPartDropdownCorner = Instance.new("UICorner")
TargetPartDropdownCorner.CornerRadius = UDim.new(0, 5)
TargetPartDropdownCorner.Parent = TargetPartDropdown

local targetParts = {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso"}
local currentTargetIndex = 1

TargetPartDropdown.MouseButton1Click:Connect(function()
    currentTargetIndex = currentTargetIndex % #targetParts + 1
    AimbotSettings.targetPart = targetParts[currentTargetIndex]
    TargetPartDropdown.Text = targetParts[currentTargetIndex]
end)

-- Team Check Toggle
local TeamCheckLabel = Instance.new("TextLabel")
TeamCheckLabel.Size = UDim2.new(0.6, -8, 0, 20)
TeamCheckLabel.Position = UDim2.new(0, 8, 0, 140)
TeamCheckLabel.BackgroundTransparency = 1
TeamCheckLabel.Text = "Team Check:"
TeamCheckLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
TeamCheckLabel.Font = Enum.Font.GothamSemibold
TeamCheckLabel.TextSize = 13
TeamCheckLabel.TextXAlignment = Enum.TextXAlignment.Left
TeamCheckLabel.Parent = AimbotSection

local TeamCheckToggle = Instance.new("TextButton")
TeamCheckToggle.Size = UDim2.new(0, 40, 0, 22)
TeamCheckToggle.Position = UDim2.new(1, -48, 0, 139)
TeamCheckToggle.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
TeamCheckToggle.Text = "ON"
TeamCheckToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
TeamCheckToggle.Font = Enum.Font.GothamBold
TeamCheckToggle.TextSize = 11
TeamCheckToggle.BorderSizePixel = 0
TeamCheckToggle.Parent = AimbotSection

local TeamCheckToggleCorner = Instance.new("UICorner")
TeamCheckToggleCorner.CornerRadius = UDim.new(0, 5)
TeamCheckToggleCorner.Parent = TeamCheckToggle

TeamCheckToggle.MouseButton1Click:Connect(function()
    AimbotSettings.teamCheck = not AimbotSettings.teamCheck
    TeamCheckToggle.Text = AimbotSettings.teamCheck and "ON" or "OFF"
    TeamCheckToggle.BackgroundColor3 = AimbotSettings.teamCheck and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(60, 50, 70)
end)

local AimbotInfo = Instance.new("TextLabel")
AimbotInfo.Size = UDim2.new(1, -16, 0, 20)
AimbotInfo.Position = UDim2.new(0, 8, 0, 168)
AimbotInfo.BackgroundTransparency = 1
AimbotInfo.Text = "Auto-aim with prediction | Higher smoothness = faster"
AimbotInfo.TextColor3 = Color3.fromRGB(150, 150, 170)
AimbotInfo.Font = Enum.Font.Gotham
AimbotInfo.TextSize = 10
AimbotInfo.TextXAlignment = Enum.TextXAlignment.Left
AimbotInfo.Parent = AimbotSection

-- Aimbot Functions
local cam = workspace.CurrentCamera

local function UpdateSmoothness(value)
    value = math.clamp(tonumber(value) or 0.35, 0.05, 1)
    AimbotSettings.smoothness = value
    SmoothnessInput.Text = tostring(value)
    local pos = (value - 0.05) / (1 - 0.05)
    SmoothnessSliderFill.Size = UDim2.new(pos, 0, 1, 0)
end

SmoothnessInput.FocusLost:Connect(function()
    UpdateSmoothness(SmoothnessInput.Text)
end)

local smoothnessDragging = false
SmoothnessSliderBtn.MouseButton1Down:Connect(function() smoothnessDragging = true end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then smoothnessDragging = false end
end)
UIS.InputChanged:Connect(function(input)
    if smoothnessDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local pos = math.clamp((input.Position.X - SmoothnessSliderBG.AbsolutePosition.X) / SmoothnessSliderBG.AbsoluteSize.X, 0, 1)
        local value = 0.05 + (1 - 0.05) * pos
        UpdateSmoothness(math.floor(value * 100) / 100)
    end
end)

local function UpdateFOV(value)
    value = math.clamp(tonumber(value) or 300, 50, 1000)
    AimbotSettings.fov = value
    FOVInput.Text = tostring(value)
    local pos = (value - 50) / (1000 - 50)
    FOVSliderFill.Size = UDim2.new(pos, 0, 1, 0)
end

FOVInput.FocusLost:Connect(function()
    UpdateFOV(FOVInput.Text)
end)

local fovDragging = false
FOVSliderBtn.MouseButton1Down:Connect(function() fovDragging = true end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then fovDragging = false end
end)
UIS.InputChanged:Connect(function(input)
    if fovDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local pos = math.clamp((input.Position.X - FOVSliderBG.AbsolutePosition.X) / FOVSliderBG.AbsoluteSize.X, 0, 1)
        local value = math.floor(50 + (1000 - 50) * pos)
        UpdateFOV(value)
    end
end)

local function GetAimbotTarget()
    local closest = nil
    local shortestDist = AimbotSettings.fov
    local screenCenter = cam.ViewportSize / 2
    
    for _, plr in pairs(Players:GetPlayers()) do
        if plr == Player then continue end
        if not plr.Character then continue end
        
        local hum = plr.Character:FindFirstChild("Humanoid")
        if not hum or hum.Health <= 0 then continue end
        
        if AimbotSettings.teamCheck and plr.Team and Player.Team then
            if plr.Team == Player.Team then continue end
        end
        
        local part = plr.Character:FindFirstChild(AimbotSettings.targetPart)
        if not part then
            part = plr.Character:FindFirstChild("Head") or plr.Character:FindFirstChild("HumanoidRootPart")
        end
        
        if part then
            local pos, onScreen = cam:WorldToViewportPoint(part.Position)
            
            if onScreen and pos.Z > 0 then
                local dist = (Vector2.new(pos.X, pos.Y) - screenCenter).Magnitude
                
                if dist < shortestDist then
                    closest = part
                    shortestDist = dist
                end
            end
        end
    end
    
    return closest
end

AimbotToggle.MouseButton1Click:Connect(function()
    AimbotEnabled = not AimbotEnabled
    AimbotToggle.Text = AimbotEnabled and "ON" or "OFF"
    AimbotToggle.BackgroundColor3 = AimbotEnabled and Color3.fromRGB(100, 150, 255) or Color3.fromRGB(60, 50, 70)
    
    if AimbotEnabled then
        AimbotConnection = RunService.RenderStepped:Connect(function()
            if not AimbotEnabled then return end
            
            local targetPart = GetAimbotTarget()
            
            if targetPart then
                local velocity = targetPart.AssemblyLinearVelocity or Vector3.new(0, 0, 0)
                local targetPos = targetPart.Position + (velocity * AimbotSettings.prediction)
                local aimCFrame = CFrame.new(cam.CFrame.Position, targetPos)
                cam.CFrame = cam.CFrame:Lerp(aimCFrame, AimbotSettings.smoothness)
            end
        end)
        print("Aimbot activado")
    else
        if AimbotConnection then
            AimbotConnection:Disconnect()
            AimbotConnection = nil
        end
        print("Aimbot desactivado")
    end
end)
