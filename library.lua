local Library = {windowCount = 0}
local b = setmetatable({}, {__index = function(self, k) return game:GetService(k) end})
local player = b.Players.LocalPlayer
local UIS = b.UserInputService

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RELMZEY_MOBILE"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = b.CoreGui
ScreenGui.Enabled = false

-- Custom Mobile Dragging Function
local function MakeDraggable(frame, handle)
    local dragging, dragInput, dragStart, startPos
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

function Library:Init(config)
    local KeyGui = Instance.new("ScreenGui", b.CoreGui)
    if isfile and isfile(config.SaveFile) and readfile(config.SaveFile) == config.Key then
        KeyGui:Destroy(); ScreenGui.Enabled = true; return
    end

    local KeyFrame = Instance.new("Frame", KeyGui)
    KeyFrame.Size = UDim2.new(0, 220, 0, 190)
    KeyFrame.Position = UDim2.new(0.5, -110, 0.5, -95)
    KeyFrame.BackgroundColor3 = Color3.fromRGB(12, 20, 30)
    Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 12)
    Instance.new("UIStroke", KeyFrame).Color = Color3.fromRGB(80, 180, 255)

    local KeyHeader = Instance.new("TextLabel", KeyFrame)
    KeyHeader.Size = UDim2.new(1, 0, 0, 35); KeyHeader.Text = "🔑 KEY SYSTEM"
    KeyHeader.TextColor3 = Color3.new(1, 1, 1); KeyHeader.Font = Enum.Font.GothamBlack
    KeyHeader.BackgroundColor3 = Color3.fromRGB(20, 35, 50); Instance.new("UICorner", KeyHeader)
    MakeDraggable(KeyFrame, KeyHeader)

    local KeyInput = Instance.new("TextBox", KeyFrame)
    KeyInput.Size = UDim2.new(0, 180, 0, 35); KeyInput.Position = UDim2.new(0.5, -90, 0, 50)
    KeyInput.PlaceholderText = "Enter Key..."; KeyInput.BackgroundColor3 = Color3.fromRGB(25, 40, 55)
    KeyInput.TextColor3 = Color3.new(1, 1, 1); KeyInput.Font = Enum.Font.GothamBlack; Instance.new("UICorner", KeyInput)

    local VerifyBtn = Instance.new("TextButton", KeyFrame)
    VerifyBtn.Size = UDim2.new(0, 180, 0, 35); VerifyBtn.Position = UDim2.new(0.5, -90, 0, 95)
    VerifyBtn.Text = "VERIFY"; VerifyBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
    VerifyBtn.TextColor3 = Color3.new(1, 1, 1); VerifyBtn.Font = Enum.Font.GothamBlack; Instance.new("UICorner", VerifyBtn)

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
    MainFrame.Size = UDim2.new(0, 200, 0, 250) -- Slightly smaller for mobile screens
    MainFrame.Position = UDim2.new(0, 20 + (210 * (Library.windowCount - 1)), 0.2, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(12, 20, 30)
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
    local s = Instance.new("UIStroke", MainFrame); s.Color = Color3.fromRGB(80, 180, 255); s.Thickness = 2

    local Header = Instance.new("Frame", MainFrame)
    Header.Size = UDim2.new(1, 0, 0, 35); Header.BackgroundColor3 = Color3.fromRGB(20, 35, 50)
    Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 12)
    MakeDraggable(MainFrame, Header)

    local Title = Instance.new("TextLabel", Header)
    Title.Size = UDim2.new(1, -40, 1, 0); Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Text = titleText; Title.TextColor3 = Color3.new(1,1,1); Title.Font = Enum.Font.GothamBlack
    Title.BackgroundTransparency = 1; Title.TextSize = 14; Title.TextXAlignment = 0

    local Body = Instance.new("ScrollingFrame", MainFrame)
    Body.Size = UDim2.new(1, 0, 1, -40); Body.Position = UDim2.new(0, 0, 0, 40)
    Body.BackgroundTransparency = 1; Body.ScrollBarThickness = 0; Body.AutomaticCanvasSize = 2
    local L = Instance.new("UIListLayout", Body); L.Padding = UDim.new(0, 5); L.HorizontalAlignment = 1

    local Actions = {}
    function Actions:Button(text, callback)
        local btn = Instance.new("TextButton", Body)
        btn.Size = UDim2.new(0, 180, 0, 35); btn.BackgroundColor3 = Color3.fromRGB(30, 45, 65)
        btn.Text = text; btn.TextColor3 = Color3.new(1, 1, 1); btn.Font = Enum.Font.GothamBlack
        Instance.new("UICorner", btn)
        btn.MouseButton1Click:Connect(callback)
    end

    function Actions:Toggle(text, callback)
        local btn = Instance.new("TextButton", Body)
        btn.Size = UDim2.new(0, 180, 0, 35); btn.BackgroundColor3 = Color3.fromRGB(30, 45, 65)
        btn.Text = "  " .. text; btn.TextColor3 = Color3.new(1, 1, 1); btn.Font = Enum.Font.GothamBlack
        btn.TextXAlignment = 0; Instance.new("UICorner", btn)
        local status = Instance.new("Frame", btn)
        status.Size = UDim2.new(0, 12, 0, 12); status.Position = UDim2.new(1, -20, 0.5, -6)
        status.BackgroundColor3 = Color3.fromRGB(255, 60, 60); Instance.new("UICorner", status)
        local e = false
        btn.MouseButton1Click:Connect(function()
            e = not e; status.BackgroundColor3 = e and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 60, 60); callback(e)
        end)
    end

    function Actions:Slider(text, min, max, default, callback)
        local info = Instance.new("TextLabel", Body)
        info.Size = UDim2.new(0, 180, 0, 20); info.Text = text .. ": " .. default
        info.TextColor3 = Color3.new(1,1,1); info.Font = Enum.Font.GothamBlack; info.BackgroundTransparency = 1
        local bg = Instance.new("Frame", Body); bg.Size = UDim2.new(0, 170, 0, 10); bg.BackgroundColor3 = Color3.fromRGB(20, 30, 40)
        Instance.new("UICorner", bg); local fill = Instance.new("Frame", bg)
        fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0); fill.BackgroundColor3 = Color3.fromRGB(0, 200, 255); Instance.new("UICorner", fill)

        local function Update(input)
            local pos = input.Position.X - bg.AbsolutePosition.X
            local percent = math.clamp(pos / bg.AbsoluteSize.X, 0, 1)
            fill.Size = UDim2.new(percent, 0, 1, 0)
            local val = math.floor(min + (percent * (max - min)))
            info.Text = text .. ": " .. val; callback(val)
        end

        bg.InputBegan:Connect(function(input)
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
