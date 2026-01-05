local Library = {windowCount = 0}
local b = setmetatable({}, {__index = function(self, k) return game:GetService(k) end})
local player = b.Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RELMZEY_TITAN"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = b.RunService:IsStudio() and player:WaitForChild("PlayerGui") or b.CoreGui
ScreenGui.Enabled = false

function Library:Init(config)
    local KeyGui = Instance.new("ScreenGui", b.CoreGui)
    KeyGui.Name = "RELMZEY_KEY"

    if isfile and isfile(config.SaveFile) and readfile(config.SaveFile) == config.Key then
        KeyGui:Destroy()
        ScreenGui.Enabled = true
        return
    end

    local KeyFrame = Instance.new("Frame", KeyGui)
    KeyFrame.Size = UDim2.new(0, 220, 0, 190)
    KeyFrame.Position = UDim2.new(0.5, -110, 0.5, -95)
    KeyFrame.BackgroundColor3 = Color3.fromRGB(12, 20, 30)
    KeyFrame.Active = true
    KeyFrame.Draggable = true 
    Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 12)
    local stroke = Instance.new("UIStroke", KeyFrame)
    stroke.Color = Color3.fromRGB(80, 180, 255)

    local KeyHeader = Instance.new("TextLabel", KeyFrame)
    KeyHeader.Size = UDim2.new(1, 0, 0, 35)
    KeyHeader.Text = "🔑 KEY SYSTEM"
    KeyHeader.TextColor3 = Color3.new(1, 1, 1)
    KeyHeader.Font = Enum.Font.GothamBlack
    KeyHeader.TextSize = 14
    KeyHeader.BackgroundColor3 = Color3.fromRGB(20, 35, 50)
    Instance.new("UICorner", KeyHeader)

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

    local GetKeyBtn = Instance.new("TextButton", KeyFrame)
    GetKeyBtn.Size = UDim2.new(0, 180, 0, 35)
    GetKeyBtn.Position = UDim2.new(0.5, -90, 0, 140)
    GetKeyBtn.Text = "GET KEY"
    GetKeyBtn.BackgroundColor3 = Color3.fromRGB(80, 120, 200)
    GetKeyBtn.TextColor3 = Color3.new(1, 1, 1)
    GetKeyBtn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", GetKeyBtn)

    VerifyBtn.MouseButton1Click:Connect(function()
        if KeyInput.Text == config.Key then
            if writefile then writefile(config.SaveFile, config.Key) end
            KeyGui:Destroy()
            ScreenGui.Enabled = true
        else
            KeyInput.Text = ""
            KeyInput.PlaceholderText = "WRONG KEY"
        end
    end)

    GetKeyBtn.MouseButton1Click:Connect(function()
        if setclipboard then setclipboard(config.Discord) end
        GetKeyBtn.Text = "COPIED!"
        task.wait(1)
        GetKeyBtn.Text = "GET KEY"
    end)
end

function Library:Window(titleText)
    Library.windowCount = Library.windowCount + 1
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 220, 0, 300)
    MainFrame.Position = UDim2.new(0, 25 + (230 * (Library.windowCount - 1)), 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(12, 20, 30)
    MainFrame.Active = true
    MainFrame.Draggable = true 
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
    local stroke = Instance.new("UIStroke", MainFrame)
    stroke.Color = Color3.fromRGB(80, 180, 255)
    stroke.Thickness = 2

    local Header = Instance.new("Frame", MainFrame)
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.BackgroundColor3 = Color3.fromRGB(20, 35, 50)
    Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 12)

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

    local minned = false
    MinBtn.MouseButton1Click:Connect(function()
        minned = not minned
        Body.Visible = not minned
        MainFrame.Size = minned and UDim2.new(0, 220, 0, 40) or UDim2.new(0, 220, 0, 300)
        MinBtn.Text = minned and "+" or "-"
    end)

    local Actions = {}

    function Actions:Button(text, callback)
        local btn = Instance.new("TextButton", Body)
        btn.Size = UDim2.new(0, 200, 0, 38)
        btn.BackgroundColor3 = Color3.fromRGB(30, 45, 65)
        btn.Text = text
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.GothamBlack
        btn.TextSize = 15
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
        btn.MouseButton1Click:Connect(callback)
    end

    function Actions:Toggle(text, callback)
        local btn = Instance.new("TextButton", Body)
        btn.Size = UDim2.new(0, 200, 0, 38)
        btn.BackgroundColor3 = Color3.fromRGB(30, 45, 65)
        btn.Text = "    " .. text
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.GothamBlack
        btn.TextSize = 15
        btn.TextXAlignment = Enum.TextXAlignment.Left
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

        local status = Instance.new("Frame", btn)
        status.Size = UDim2.new(0, 14, 0, 14)
        status.Position = UDim2.new(1, -25, 0.5, -7)
        status.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        Instance.new("UICorner", status).CornerRadius = UDim.new(1, 0)
        Instance.new("UIStroke", status).Color = Color3.new(1, 1, 1)

        local enabled = false
        btn.MouseButton1Click:Connect(function()
            enabled = not enabled
            status.BackgroundColor3 = enabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 60, 60)
            callback(enabled)
        end)
    end

    function Actions:Slider(text, min, max, default, callback)
        local SpeedInfo = Instance.new("TextLabel", Body)
        SpeedInfo.Size = UDim2.new(0, 200, 0, 20)
        SpeedInfo.Text = text .. ": " .. default
        SpeedInfo.TextColor3 = Color3.new(1, 1, 1)
        SpeedInfo.BackgroundTransparency = 1
        SpeedInfo.Font = Enum.Font.GothamBlack
        SpeedInfo.TextSize = 16

        local SliderBg = Instance.new("Frame", Body)
        SliderBg.Size = UDim2.new(0, 180, 0, 14)
        SliderBg.BackgroundColor3 = Color3.fromRGB(20, 30, 40)
        Instance.new("UICorner", SliderBg).CornerRadius = UDim.new(1, 0)

        local SliderFill = Instance.new("Frame", SliderBg)
        SliderFill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
        SliderFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
        Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(1, 0)

        local function Update(input)
            local x = math.clamp((input.Position.X - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X, 0, 1)
            SliderFill.Size = UDim2.new(x, 0, 1, 0)
            local val = math.floor(min + (x * (max - min)))
            SpeedInfo.Text = text .. ": " .. val
            callback(val)
        end

        SliderBg.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                local con = b.RunService.RenderStepped:Connect(function() Update(b.UserInputService:GetMouseLocation()) end)
                b.UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then con:Disconnect() end end)
            end
        end)
    end

    return Actions
end

return Library
