local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local Player = Players.LocalPlayer

local AutoFarmON = false
local AntiAFKON = false
local Stats = { 
    Collected = 0,
    LastItem = "winery luv ❤️"
}

local countryFlags = {
    ["TR"] = "🇹🇷", ["US"] = "🇺🇸", ["GB"] = "🇬🇧", ["DE"] = "🇩🇪", ["FR"] = "🇫🇷",
    ["IT"] = "🇮🇹", ["ES"] = "🇪🇸", ["RU"] = "🇷🇺", ["BR"] = "🇧🇷", ["JP"] = "🇯🇵",
    ["CN"] = "🇨🇳", ["IN"] = "🇮🇳", ["CA"] = "🇨🇦", ["AU"] = "🇦🇺", ["MX"] = "🇲🇽",
    ["NL"] = "🇳🇱", ["SE"] = "🇸🇪", ["PL"] = "🇵🇱", ["AR"] = "🇦🇷", ["SA"] = "🇸🇦",
    ["AE"] = "🇦🇪", ["KR"] = "🇰🇷", ["ID"] = "🇮🇩", ["TH"] = "🇹🇭", ["VN"] = "🇻🇳",
    ["PH"] = "🇵🇭", ["MY"] = "🇲🇾", ["SG"] = "🇸🇬", ["ZA"] = "🇿🇦", ["EG"] = "🇪🇬"
}

local VirtualUser = game:GetService("VirtualUser")
local afkConnection
local function setupAntiAFK()
    if afkConnection then afkConnection:Disconnect() end
    if AntiAFKON then
        afkConnection = Player.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end
end
setupAntiAFK()

local function autoCollect()
    pcall(function()
        local char = Player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local oldPos = hrp.CFrame

        if workspace:FindFirstChild("Brainrots") then
            for _, v in pairs(workspace.Brainrots:GetChildren()) do
                if v:IsA("BasePart") and AutoFarmON then
                    hrp.CFrame = v.CFrame
                    task.wait(0.1)
                    firetouchinterest(hrp, v, 0)
                    firetouchinterest(hrp, v, 1)
                    Stats.Collected = Stats.Collected + 1
                    Stats.LastItem = v.Name
                    task.wait(0.05)
                end
            end
        end

        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name:lower():find("brainrot") and obj:IsA("BasePart") and AutoFarmON then
                if (oldPos.Position - obj.Position).Magnitude < 100 then
                    hrp.CFrame = obj.CFrame
                    task.wait(0.1)
                    firetouchinterest(hrp, obj, 0)
                    firetouchinterest(hrp, obj, 1)
                    Stats.Collected = Stats.Collected + 1
                    Stats.LastItem = obj.Name
                    task.wait(0.05)
                end
            end
        end
        hrp.CFrame = oldPos
    end)
end

task.spawn(function()
    while task.wait(0.2) do
        if AutoFarmON then autoCollect() end
    end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 360, 0, 500)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(100, 100, 140)
MainStroke.Thickness = 2
MainStroke.Transparency = 0.5
MainStroke.Parent = MainFrame

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 70)
Header.BackgroundColor3 = Color3.fromRGB(120, 60, 220)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 16)
HeaderCorner.Parent = Header

local HeaderGradient = Instance.new("UIGradient")
HeaderGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 80, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 40, 180))
}
HeaderGradient.Rotation = 90
HeaderGradient.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 0, 35)
Title.Position = UDim2.new(0, 10, 0, 8)
Title.BackgroundTransparency = 1
Title.Text = "⚡ BEST AUTOFARM"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 24
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, -20, 0, 22)
Subtitle.Position = UDim2.new(0, 10, 0, 43)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Find a Brainrot Farm v2.0"
Subtitle.TextColor3 = Color3.fromRGB(200, 200, 255)
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 14
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = Header

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -20, 1, -90)
Content.Position = UDim2.new(0, 10, 0, 80)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

local FarmBtn = Instance.new("TextButton")
FarmBtn.Size = UDim2.new(1, 0, 0, 75)
FarmBtn.Position = UDim2.new(0, 0, 0, 0)
FarmBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
FarmBtn.Text = ""
FarmBtn.Parent = Content

local FarmCorner = Instance.new("UICorner")
FarmCorner.CornerRadius = UDim.new(0, 12)
FarmCorner.Parent = FarmBtn

local FarmIcon = Instance.new("TextLabel")
FarmIcon.Size = UDim2.new(0, 55, 0, 55)
FarmIcon.Position = UDim2.new(0, 10, 0.5, -27.5)
FarmIcon.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
FarmIcon.Text = "🔴"
FarmIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmIcon.Font = Enum.Font.GothamBlack
FarmIcon.TextSize = 28
FarmIcon.Parent = FarmBtn

local FarmIconCorner = Instance.new("UICorner")
FarmIconCorner.CornerRadius = UDim.new(1, 0)
FarmIconCorner.Parent = FarmIcon

local FarmLabel = Instance.new("TextLabel")
FarmLabel.Size = UDim2.new(1, -80, 0, 30)
FarmLabel.Position = UDim2.new(0, 75, 0, 12)
FarmLabel.BackgroundTransparency = 1
FarmLabel.Text = "AutoFarm"
FarmLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
FarmLabel.Font = Enum.Font.Gotham
FarmLabel.TextSize = 14
FarmLabel.TextXAlignment = Enum.TextXAlignment.Left
FarmLabel.Parent = FarmBtn

local FarmStatus = Instance.new("TextLabel")
FarmStatus.Size = UDim2.new(1, -80, 0, 35)
FarmStatus.Position = UDim2.new(0, 75, 0, 35)
FarmStatus.BackgroundTransparency = 1
FarmStatus.Text = "OFFLINE"
FarmStatus.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmStatus.Font = Enum.Font.GothamBlack
FarmStatus.TextSize = 22
FarmStatus.TextXAlignment = Enum.TextXAlignment.Left
FarmStatus.Parent = FarmBtn

local AFKBtn = Instance.new("TextButton")
AFKBtn.Size = UDim2.new(1, 0, 0, 65)
AFKBtn.Position = UDim2.new(0, 0, 0, 85)
AFKBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
AFKBtn.Text = ""
AFKBtn.Parent = Content

local AFKCorner = Instance.new("UICorner")
AFKCorner.CornerRadius = UDim.new(0, 12)
AFKCorner.Parent = AFKBtn

local AFKIcon = Instance.new("TextLabel")
AFKIcon.Size = UDim2.new(0, 45, 0, 45)
AFKIcon.Position = UDim2.new(0, 10, 0.5, -22.5)
AFKIcon.BackgroundColor3 = Color3.fromRGB(60, 255, 100)
AFKIcon.Text = "⏰"
AFKIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
AFKIcon.Font = Enum.Font.GothamBlack
AFKIcon.TextSize = 24
AFKIcon.Parent = AFKBtn

local AFKIconCorner = Instance.new("UICorner")
AFKIconCorner.CornerRadius = UDim.new(1, 0)
AFKIconCorner.Parent = AFKIcon

local AFKLabel = Instance.new("TextLabel")
AFKLabel.Size = UDim2.new(1, -70, 1, 0)
AFKLabel.Position = UDim2.new(0, 65, 0, 0)
AFKLabel.BackgroundTransparency = 1
AFKLabel.Text = "Anti AFK: ON"
AFKLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
AFKLabel.Font = Enum.Font.GothamBold
AFKLabel.TextSize = 18
AFKLabel.TextXAlignment = Enum.TextXAlignment.Left
AFKLabel.Parent = AFKBtn

local StatsFrame = Instance.new("Frame")
StatsFrame.Size = UDim2.new(1, 0, 0, 150)
StatsFrame.Position = UDim2.new(0, 0, 0, 160)
StatsFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
StatsFrame.BorderSizePixel = 0
StatsFrame.Parent = Content

local StatsCorner = Instance.new("UICorner")
StatsCorner.CornerRadius = UDim.new(0, 12)
StatsCorner.Parent = StatsFrame

local StatsTitle = Instance.new("TextLabel")
StatsTitle.Size = UDim2.new(1, -20, 0, 25)
StatsTitle.Position = UDim2.new(0, 10, 0, 8)
StatsTitle.BackgroundTransparency = 1
StatsTitle.Text = "📊 Statistics"
StatsTitle.TextColor3 = Color3.fromRGB(150, 150, 180)
StatsTitle.Font = Enum.Font.GothamBold
StatsTitle.TextSize = 16
StatsTitle.TextXAlignment = Enum.TextXAlignment.Left
StatsTitle.Parent = StatsFrame

local CollectedLabel = Instance.new("TextLabel")
CollectedLabel.Size = UDim2.new(1, -20, 0, 22)
CollectedLabel.Position = UDim2.new(0, 10, 0, 38)
CollectedLabel.BackgroundTransparency = 1
CollectedLabel.Text = "Total Collected:"
CollectedLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
CollectedLabel.Font = Enum.Font.Gotham
CollectedLabel.TextSize = 14
CollectedLabel.TextXAlignment = Enum.TextXAlignment.Left
CollectedLabel.Parent = StatsFrame

local CollectedValue = Instance.new("TextLabel")
CollectedValue.Size = UDim2.new(1, -20, 0, 40)
CollectedValue.Position = UDim2.new(0, 10, 0, 58)
CollectedValue.BackgroundTransparency = 1
CollectedValue.Text = "0"
CollectedValue.TextColor3 = Color3.fromRGB(100, 255, 150)
CollectedValue.Font = Enum.Font.GothamBlack
CollectedValue.TextSize = 36
CollectedValue.TextXAlignment = Enum.TextXAlignment.Left
CollectedValue.Parent = StatsFrame

local LastItemLabel = Instance.new("TextLabel")
LastItemLabel.Size = UDim2.new(1, -20, 0, 25)
LastItemLabel.Position = UDim2.new(0, 10, 0, 95)
LastItemLabel.BackgroundTransparency = 1
LastItemLabel.Text = "Last Item:"
LastItemLabel.TextColor3 = Color3.fromRGB(150, 150, 180)
LastItemLabel.Font = Enum.Font.Gotham
LastItemLabel.TextSize = 13
LastItemLabel.TextXAlignment = Enum.TextXAlignment.Left
LastItemLabel.Parent = StatsFrame

local LastItemValue = Instance.new("TextLabel")
LastItemValue.Size = UDim2.new(1, -20, 0, 25)
LastItemValue.Position = UDim2.new(0, 10, 0, 118)
LastItemValue.BackgroundTransparency = 1
LastItemValue.Text = "None"
LastItemValue.TextColor3 = Color3.fromRGB(255, 255, 255)
LastItemValue.Font = Enum.Font.GothamBold
LastItemValue.TextSize = 16
LastItemValue.TextXAlignment = Enum.TextXAlignment.Left
LastItemValue.Parent = StatsFrame

local CreditsFrame = Instance.new("Frame")
CreditsFrame.Size = UDim2.new(1, 0, 0, 80)
CreditsFrame.Position = UDim2.new(0, 0, 0, 320)
CreditsFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
CreditsFrame.BorderSizePixel = 0
CreditsFrame.Parent = Content

local CreditsCorner = Instance.new("UICorner")
CreditsCorner.CornerRadius = UDim.new(0, 12)
CreditsCorner.Parent = CreditsFrame

local CreditsTitle = Instance.new("TextLabel")
CreditsTitle.Size = UDim2.new(1, -20, 0, 25)
CreditsTitle.Position = UDim2.new(0, 10, 0, 8)
CreditsTitle.BackgroundTransparency = 1
CreditsTitle.Text = "by wineryy "
CreditsTitle.TextColor3 = Color3.fromRGB(200, 200, 220)
CreditsTitle.Font = Enum.Font.GothamBold
CreditsTitle.TextSize = 18
CreditsTitle.TextXAlignment = Enum.TextXAlignment.Left
CreditsTitle.Parent = CreditsFrame

local DiscordBtn = Instance.new("TextButton")
DiscordBtn.Size = UDim2.new(1, -20, 0, 38)
DiscordBtn.Position = UDim2.new(0, 10, 0, 35)
DiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
DiscordBtn.Text = "📋 Copy Discord: .gg/QQUJMdv6pm"
DiscordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordBtn.Font = Enum.Font.GothamBold
DiscordBtn.TextSize = 14
DiscordBtn.Parent = CreditsFrame

local DiscordCorner = Instance.new("UICorner")
DiscordCorner.CornerRadius = UDim.new(0, 10)
DiscordCorner.Parent = DiscordBtn

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 70, 0, 70)
ToggleBtn.Position = UDim2.new(0, 20, 0, 20)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(140, 80, 255)
ToggleBtn.Text = ""
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 18)
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(180, 120, 255)
ToggleStroke.Thickness = 3
ToggleStroke.Parent = ToggleBtn

local ToggleIcon = Instance.new("TextLabel")
ToggleIcon.Size = UDim2.new(1, 0, 1, 0)
ToggleIcon.BackgroundTransparency = 1
ToggleIcon.Text = "⚡"
ToggleIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleIcon.Font = Enum.Font.GothamBlack
ToggleIcon.TextSize = 38
ToggleIcon.Parent = ToggleBtn

local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then update(input) end
end)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

FarmBtn.MouseButton1Click:Connect(function()
    AutoFarmON = not AutoFarmON
    if AutoFarmON then
        FarmStatus.Text = "ONLINE"
        FarmIcon.BackgroundColor3 = Color3.fromRGB(60, 255, 100)
        FarmIcon.Text = "🟢"
    else
        FarmStatus.Text = "OFFLINE"
        FarmIcon.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        FarmIcon.Text = "🔴"
    end
end)

AFKBtn.MouseButton1Click:Connect(function()
    AntiAFKON = not AntiAFKON
    setupAntiAFK()
    if AntiAFKON then
        AFKLabel.Text = "Anti AFK: ON"
        AFKIcon.BackgroundColor3 = Color3.fromRGB(60, 255, 100)
    else
        AFKLabel.Text = "Anti AFK: OFF"
        AFKIcon.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    end
end)

DiscordBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/QQUJMdv6pm")
    DiscordBtn.Text = "✅ Copied!"
    task.wait(2)
    DiscordBtn.Text = "Copy Discord: .gg/QQUJMdv6pm"
end)

task.spawn(function()
    while task.wait(0.3) do
        CollectedValue.Text = tostring(Stats.Collected)
        LastItemValue.Text = Stats.LastItem
    end
end)

game.StarterGui:SetCore("SendNotification", {
    Title = "Best AutoFarm";
    Text = "Find a Brainrot Farm v2.0 | Loading..";
    Duration = 5;
})
