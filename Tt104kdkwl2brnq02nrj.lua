local Lnr = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local TextButton = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")

Lnr.Name = "Lnr"
Lnr.Parent = game.CoreGui
Lnr.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = Lnr
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.5, -75, 0.5, -25)
Frame.Size = UDim2.new(0, 150, 0, 50)
Frame.Active = true
Frame.Draggable = true

local function TopContainer()
    Frame.Position = UDim2.new(0.5, -Frame.AbsoluteSize.X / 2, 0.5, -Frame.AbsoluteSize.Y / 2)
end

TopContainer()
Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(TopContainer)

UICorner.Parent = Frame

TextButton.Parent = Frame
TextButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton.BorderSizePixel = 0
TextButton.Position = UDim2.new(0.1, 0, 0.2, 0)
TextButton.Size = UDim2.new(0.8, 0, 0.6, 0)
TextButton.Font = Enum.Font.GothamSemibold
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextSize = 14
TextButton.Text = "LunarAnti {off}"

UICorner_2.Parent = TextButton

local function Notify(message)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.5, 0, 0.1, 0)
    frame.Position = UDim2.new(0.5, 0, -0.1, 0)
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.BorderSizePixel = 0 
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
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

local lunarAntiState = false
local heartbeatConnection

TextButton.MouseButton1Click:Connect(function()
    lunarAntiState = not lunarAntiState
    if lunarAntiState then
        TextButton.Text = "LunarAnti {on}"
        Notify("LunarAnti on")
        getgenv().LunarIC = true
        
        heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if getgenv().LunarIC then
                local vel = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
                game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(getgenv().AntiStrength, 0, 0)
                game:GetService("RunService").RenderStepped:Wait()
                game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = vel
            end
        end)
    else
        TextButton.Text = "LunarAnti {off}"
        Notify("LunarAnti off")
        getgenv().LunarIC = false
        
        if heartbeatConnection then
            heartbeatConnection:Disconnect()
            heartbeatConnection = nil
        end
    end
end)

getgenv().LunarIC = false
getgenv().AntiStrength = 1000
