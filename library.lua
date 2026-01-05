local Library = {windowCount = 0}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer

local function MakeDraggable(frame, handle)
    local dragging, dragStart, startPos
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = frame.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FROST"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui
ScreenGui.Enabled = false

function Library:Init(config)
    local KeyGui = Instance.new("ScreenGui", CoreGui)
    KeyGui.Name = "FROST_KEY"

    if isfile and isfile(config.SaveFile) and readfile(config.SaveFile) == config.Key then
        KeyGui:Destroy(); ScreenGui.Enabled = true; return
    end

    local KeyFrame = Instance.new("Frame", KeyGui)
    KeyFrame.Size = UDim2.new(0, 220, 0, 190)
    KeyFrame.Position = UDim2.new(0.5, -110, 0.5, -95)
    KeyFrame.BackgroundColor3 = Color3.fromRGB(12, 20, 30)
    KeyFrame.BorderSizePixel = 0
    Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 12)
    local KS = Instance.new("UIStroke", KeyFrame)
    KS.Color = Color3.fromRGB(80, 180, 255)

    local KeyHeader = Instance.new("TextLabel", KeyFrame)
    KeyHeader.Size = UDim2.new(1, 0, 0, 35)
    KeyHeader.Text = "🔑 KEY SYSTEM"
    KeyHeader.TextColor3 = Color3.new(1, 1, 1)
    KeyHeader.Font = Enum.Font.GothamBlack
    KeyHeader.TextSize = 14
    KeyHeader.BackgroundColor3 = Color3.fromRGB(20, 35, 50)
    Instance.new("UICorner", KeyHeader)
    MakeDraggable(KeyFrame, KeyHeader)

    local KeyInput = Instance.new("TextBox", KeyFrame)
    KeyInput.Size = UDim2.new(0, 180, 0, 35)
    KeyInput.Position = UDim2.new(0.5, -90, 0, 50)
    KeyInput.PlaceholderText = "Enter Key..."
    KeyInput.BackgroundColor3 = Color3.fromRGB(25, 40, 55)
    KeyInput.TextColor3 = Color3.new(1, 1, 1)
    KeyInput.Font = Enum.Font.GothamBlack
    KeyInput.TextSize = 16
    Instance.new("UICorner", KeyInput)

    local VerifyBtn = Instance.new("TextButton", KeyFrame)
    VerifyBtn.Size = UDim2.new(0, 180, 0, 35)
    VerifyBtn.Position = UDim2.new(0.5, -90, 0, 95)
    VerifyBtn.Text = "VERIFY"
    VerifyBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
    VerifyBtn.TextColor3 = Color3.new(1, 1, 1)
    VerifyBtn.Font = Enum.Font.GothamBlack
    Instance.new("UICorner", VerifyBtn)

    VerifyBtn.MouseButton1Click:Connect(function()
        if KeyInput.Text == config.Key then
            if writefile then writefile(config.SaveFile, config.Key) end
            KeyGui:Destroy(); ScreenGui.Enabled = true
        else
            KeyInput.Text = ""; KeyInput.PlaceholderText = "WRONG KEY"
        end
    end)
end

function Library:Window(titleText)
    Library.windowCount = Library.windowCount + 1
    
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 220, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -110, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(12, 20, 30)
    MainFrame.BorderSizePixel = 0
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Color = Color3.fromRGB(80, 180, 255)
    MainStroke.Thickness = 2

    local Header = Instance.new("Frame", MainFrame)
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.BackgroundColor3 = Color3.fromRGB(20, 35, 50)
    Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 12)
    MakeDraggable(MainFrame, Header)

    local Title = Instance.new("TextLabel", Header)
    Title.Size = UDim2.new(1, -70, 1, 0)
    Title.Position = UDim2.new(0, 12, 0, 0)
    Title.Text = titleText
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.Font = Enum.Font.GothamBlack
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1

    local MinBtn = Instance.new("TextButton", Header)
    MinBtn.Size = UDim2.new(0, 28, 0, 28)
    MinBtn.Position = UDim2.new(1, -34, 0, 6)
    MinBtn.Text = "-"
    MinBtn.BackgroundColor3 = Color3.fromRGB(60, 80, 110)
    MinBtn.TextColor3 = Color3.new(1, 1, 1)
    MinBtn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)

    local Body = Instance.new("ScrollingFrame", MainFrame)
    Body.Size = UDim2.new(1, 0, 1, -45)
    Body.Position = UDim2.new(0, 0, 0, 45)
    Body.BackgroundTransparency = 1
    Body.ScrollBarThickness = 0
    Body.AutomaticCanvasSize = Enum.AutomaticSize.Y

    local Layout = Instance.new("UIListLayout", Body)
    Layout.Padding = UDim.new(0, 8)
    Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    Layout.SortOrder = Enum.SortOrder.LayoutOrder

    MinBtn.MouseButton1Click:Connect(function()
        local isMinned = (Body.Visible == true)
        Body.Visible = not isMinned
        MainFrame.Size = isMinned and UDim2.new(0, 220, 0, 40) or UDim2.new(0, 220, 0, 300)
        MinBtn.Text = isMinned and "+" or "-"
    end)

    local Actions = {}

    function Actions:Button(text, order, callback)
        local btn = Instance.new("TextButton", Body)
        btn.Size = UDim2.new(0, 200, 0, 38)
        btn.BackgroundColor3 = Color3.fromRGB(30, 45, 65)
        btn.Text = text
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.GothamBlack
        btn.TextSize = 15
        btn.LayoutOrder = order
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
        btn.MouseButton1Click:Connect(callback)
        return btn
    end

    function Actions:Toggle(text, order, callback)
        local btn = Instance.new("TextButton", Body)
        btn.Size = UDim2.new(0, 200, 0, 38)
        btn.BackgroundColor3 = Color3.fromRGB(30, 45, 65)
        btn.Text = "    " .. text
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.GothamBlack
        btn.TextSize = 15
        btn.LayoutOrder = order
        btn.TextXAlignment = Enum.TextXAlignment.Left
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

        local status = Instance.new("Frame", btn)
        status.Size = UDim2.new(0, 14, 0, 14)
        status.Position = UDim2.new(1, -25, 0.5, -7)
        status.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        Instance.new("UICorner", status).CornerRadius = UDim.new(1, 0)
        local ts = Instance.new("UIStroke", status)
        ts.Color = Color3.new(1, 1, 1)
        ts.Thickness = 1.5
        
        local enabled = false
        btn.MouseButton1Click:Connect(function()
            enabled = not enabled
            status.BackgroundColor3 = enabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 60, 60)
            callback(enabled)
        end)
    end

    function Actions:Slider(text, min, max, default, order, callback)
        local SpeedInfo = Instance.new("TextLabel", Body)
        SpeedInfo.Size = UDim2.new(0, 200, 0, 20)
        SpeedInfo.Text = text .. ": " .. default
        SpeedInfo.TextColor3 = Color3.new(1, 1, 1)
        SpeedInfo.BackgroundTransparency = 1
        SpeedInfo.Font = Enum.Font.GothamBlack
        SpeedInfo.TextSize = 16
        SpeedInfo.LayoutOrder = order

        local SliderBg = Instance.new("Frame", Body)
        SliderBg.Size = UDim2.new(0, 180, 0, 14)
        SliderBg.BackgroundColor3 = Color3.fromRGB(20, 30, 40)
        SliderBg.LayoutOrder = order + 1
        Instance.new("UICorner", SliderBg).CornerRadius = UDim.new(1, 0)

        local SliderFill = Instance.new("Frame", SliderBg)
        SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
        SliderFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
        Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(1, 0)

        local function Update(input)
            local inputPos = input.Position.X
            local bgPos = SliderBg.AbsolutePosition.X
            local bgSize = SliderBg.AbsoluteSize.X
            local percent = math.clamp((inputPos - bgPos) / bgSize, 0, 1)
            
            SliderFill.Size = UDim2.new(percent, 0, 1, 0)
            local val = math.floor(min + (percent * (max - min)))
            SpeedInfo.Text = text .. ": " .. val
            callback(val)
        end

        SliderBg.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
                Update(input)
                local moveCon = UIS.InputChanged:Connect(function(move)
                    if move.UserInputType == Enum.UserInputType.Touch or move.UserInputType == Enum.UserInputType.MouseMovement then
                        Update(move)
                    end
                end)
                UIS.InputEnded:Connect(function(ended)
                    if ended.UserInputType == Enum.UserInputType.Touch or ended.UserInputType == Enum.UserInputType.MouseButton1 then
                        moveCon:Disconnect()
                    end
                end)
            end
        end)
    end

    return Actions
end

return Library
