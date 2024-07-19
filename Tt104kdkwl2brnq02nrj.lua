local function Notify(message)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.5, 0, 0.1, 0)
    frame.Position = UDim2.new(0.25, 0, -0.1, 0)
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.BorderSizePixel = 0 
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.new(0.5, 0, 0, 0)
    frame.Parent = screenGui
    
    local uicorner = Instance.new("UICorner")
    uicorner.CornerRadius = UDim.new(0.5, 0)
    uicorner.Parent = frame
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = message
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.SciFi
    textLabel.TextSize = 14
    textLabel.Parent = frame
    
    local textBlur = Instance.new("TextLabel")
    textBlur.Size = UDim2.new(1, 0, 1, 0)
    textBlur.Position = UDim2.new(0, 0, 0, 0)
    textBlur.BackgroundTransparency = 1
    textBlur.Text = message
    textBlur.TextColor3 = Color3.new(1, 1, 1)
    textBlur.TextScaled = true
    textBlur.Font = Enum.Font.SciFi
    textBlur.TextSize = 14
    textBlur.TextTransparency = 0.5
    textBlur.Parent = frame
    textBlur.ZIndex = textLabel.ZIndex - 1
    textBlur.TextStrokeTransparency = 0.75
    frame:TweenPosition(UDim2.new(0.5, 0, 0.1, 0), "Out", "Quad", 1, true)
    wait(5)
    
    for i = 0, 1, 0.1 do
        frame.BackgroundTransparency = i
        textLabel.TextTransparency = i
        textBlur.TextTransparency = 0.5 + i / 2
        wait(0.1)
    end
    
    screenGui:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local lunarButton = Instance.new("TextButton")
lunarButton.Size = UDim2.new(0, 200, 0, 50)
lunarButton.Position = UDim2.new(0.5, -100, 0.5, -25)
lunarButton.Text = "LunarAnti {off}"
lunarButton.Parent = screenGui

lunarButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
lunarButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
lunarButton.Font = Enum.Font.Arcade
lunarButton.TextColor3 = Color3.fromRGB(255, 255, 255)
lunarButton.TextSize = 24

lunarButton.Active = true
lunarButton.Draggable = true

local function toggleButton()
    if lunarButton.Text == "LunarAnti {off}" then
        lunarButton.Text = "LunarAnti {on}"
        getgenv().LunarIC = true
        Notify("AntiLock on")
    else
        lunarButton.Text = "LunarAnti {off}"
        getgenv().LunarIC = false
        Notify("AntiLock off")
    end
end

lunarButton.MouseButton1Click:Connect(toggleButton)

getgenv().LunarIC = false
getgenv().AntiStrength = 1000

game:GetService("RunService").heartbeat:Connect(function()
    if getgenv().XAnti ~= false then
        local vel = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
        game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(getgenv().AntiStrength, 0, 0)
        game:GetService("RunService").RenderStepped:Wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = vel
    end
end)
