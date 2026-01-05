local Library = {windowCount = 0, flags = {}}
local b = {}
setmetatable(b, {
    __index = function(c, d) return game:GetService(d) end, 
    __newindex = function(e, f) e[f] = nil return end
})

local player = b.Players.LocalPlayer
local mouse = player:GetMouse()

-- [[ INTERNAL UTILITIES ]] --
local function Drag(i, j)
    local k, l, m, n
    local function o(p)
        local q = p.Position - m
        i.Position = UDim2.new(n.X.Scale, n.X.Offset + q.X, n.Y.Scale, n.Y.Offset + q.Y)
    end
    (j or i).InputBegan:Connect(function(p)
        if p.UserInputType == Enum.UserInputType.MouseButton1 then
            k = true; m = p.Position; n = i.Position
            p.Changed:Connect(function() if p.UserInputState == Enum.UserInputState.End then k = false end end)
        end
    end)
    i.InputChanged:Connect(function(p) if p.UserInputType == Enum.UserInputType.MouseMovement then l = p end end)
    b.UserInputService.InputChanged:Connect(function(p) if p == l and k then o(p) end end)
end

local function ClickEffect(r)
    spawn(function()
        r.ClipsDescendants = true
        local s = Instance.new("ImageLabel", r)
        s.BackgroundTransparency = 1; s.Image = "rbxassetid://2708891598"
        s.ImageColor3 = Color3.fromRGB(131, 132, 255); s.ImageTransparency = 0.8
        s.Position = UDim2.new((mouse.X - s.AbsolutePosition.X) / r.AbsoluteSize.X, 0, (mouse.Y - s.AbsolutePosition.Y) / r.AbsoluteSize.Y, 0)
        b.TweenService:Create(s, TweenInfo.new(0.8), {Position = UDim2.new(-5, 0, -5, 0), Size = UDim2.new(11, 0, 11, 0)}):Play()
        wait(0.3); b.TweenService:Create(s, TweenInfo.new(0.3), {ImageTransparency = 1}):Play()
        repeat wait() until s.ImageTransparency == 1; s:Destroy()
    end)
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = b.HttpService:GenerateGUID()
ScreenGui.Parent = b.RunService:IsStudio() and player:WaitForChild("PlayerGui") or b.CoreGui
ScreenGui.Enabled = false

-- [[ PUBLIC METHODS ]] --

function Library:Init(config)
    -- config: {KeySystem = bool, Key = string, SaveFile = string, Discord = string}
    config = config or {KeySystem = false}
    
    local function Unlock()
        if ScreenGui:FindFirstChild("KeyFrame") then ScreenGui.KeyFrame:Destroy() end
        ScreenGui.Enabled = true
    end

    if not config.KeySystem then Unlock(); return end

    -- Save Key Feature
    if isfile and config.SaveFile and isfile(config.SaveFile) then
        if readfile(config.SaveFile) == config.Key then Unlock(); return end
    end

    local KeyFrame = Instance.new("Frame", ScreenGui)
    KeyFrame.Name = "KeyFrame"
    KeyFrame.Size = UDim2.new(0, 220, 0, 160)
    KeyFrame.Position = UDim2.new(0.5, -110, 0.5, -80)
    KeyFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Drag(KeyFrame)
    Instance.new("UICorner", KeyFrame)
    ScreenGui.Enabled = true

    local Title = Instance.new("TextLabel", KeyFrame)
    Title.Size = UDim2.new(1, 0, 0, 35); Title.Text = "KEY SYSTEM"; Title.TextColor3 = Color3.new(1,1,1)
    Title.Font = Enum.Font.GothamBold; Title.BackgroundTransparency = 1

    local Input = Instance.new("TextBox", KeyFrame)
    Input.Size = UDim2.new(0, 180, 0, 35); Input.Position = UDim2.new(0.1, 0, 0.3, 0)
    Input.PlaceholderText = "Enter Key..."; Input.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Input.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", Input)

    local Verify = Instance.new("TextButton", KeyFrame)
    Verify.Size = UDim2.new(0, 180, 0, 35); Verify.Position = UDim2.new(0.1, 0, 0.6, 0)
    Verify.BackgroundColor3 = Color3.fromRGB(131, 132, 255); Verify.Text = "VERIFY"
    Verify.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", Verify)

    local GetKey = Instance.new("TextButton", KeyFrame)
    GetKey.Size = UDim2.new(0, 180, 0, 20); GetKey.Position = UDim2.new(0.1, 0, 0.85, 0)
    GetKey.BackgroundTransparency = 1; GetKey.Text = "Get Key (Clipboard)"; GetKey.TextColor3 = Color3.fromRGB(131, 132, 255); GetKey.TextSize = 12

    Verify.MouseButton1Click:Connect(function()
        if Input.Text == config.Key then
            if writefile and config.SaveFile then writefile(config.SaveFile, config.Key) end
            Unlock()
        else
            Input.Text = ""; Input.PlaceholderText = "INVALID KEY"
        end
    end)

    GetKey.MouseButton1Click:Connect(function()
        if setclipboard then setclipboard(config.Discord or "") end
        GetKey.Text = "Copied Link!"
        wait(2)
        GetKey.Text = "Get Key (Clipboard)"
    end)
end

function Library:Window(text)
    Library.windowCount = Library.windowCount + 1
    local isOpened = false
    
    local Top = Instance.new("Frame", ScreenGui)
    Top.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
    Top.Size = UDim2.new(0, 212, 0, 36)
    Top.Position = UDim2.new(0, 25 + (220 * (Library.windowCount - 1)), 0, 50)
    Drag(Top)

    local Header = Instance.new("TextLabel", Top)
    Header.Size = UDim2.new(1, -40, 1, 0); Header.Position = UDim2.new(0, 12, 0, 0)
    Header.BackgroundTransparency = 1; Header.Text = text; Header.TextColor3 = Color3.new(1, 1, 1)
    Header.Font = Enum.Font.GothamSemibold; Header.TextXAlignment = Enum.TextXAlignment.Left

    local Container = Instance.new("Frame", Top)
    Container.Position = UDim2.new(0, 0, 1, 0); Container.Size = UDim2.new(1, 0, 0, 0)
    Container.BackgroundColor3 = Color3.fromRGB(38, 38, 38); Container.ClipsDescendants = true
    
    local Layout = Instance.new("UIListLayout", Container)
    Layout.Padding = UDim.new(0, 4); Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local Toggle = Instance.new("TextButton", Top)
    Toggle.Size = UDim2.new(0, 34, 0, 34); Toggle.Position = UDim2.new(1, -34, 0, 0)
    Toggle.Text = "+"; Toggle.TextColor3 = Color3.new(1, 1, 1); Toggle.BackgroundTransparency = 1

    Toggle.MouseButton1Click:Connect(function()
        isOpened = not isOpened
        b.TweenService:Create(Container, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 0, isOpened and Layout.AbsoluteContentSize.Y + 6 or 0)}):Play()
        Toggle.Text = isOpened and "-" or "+"
    end)

    local Elements = {}

    function Elements:Button(name, callback)
        local btn = Instance.new("TextButton", Container)
        btn.Size = UDim2.new(0, 203, 0, 30); btn.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
        btn.Text = "  " .. name; btn.TextColor3 = Color3.new(1,1,1); btn.Font = Enum.Font.Gotham
        btn.TextXAlignment = Enum.TextXAlignment.Left; Instance.new("UICorner", btn)
        btn.MouseButton1Click:Connect(function() ClickEffect(btn); callback() end)
    end

    function Elements:Toggle(name, flag, default, callback)
        Library.flags[flag] = default or false
        local tgl = Instance.new("TextButton", Container)
        tgl.Size = UDim2.new(0, 203, 0, 30); tgl.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
        tgl.Text = "  " .. name; tgl.TextColor3 = Color3.new(1,1,1); tgl.Font = Enum.Font.Gotham
        tgl.TextXAlignment = Enum.TextXAlignment.Left; Instance.new("UICorner", tgl)
        
        local Indicator = Instance.new("Frame", tgl)
        Indicator.Size = UDim2.new(0, 18, 0, 18); Indicator.Position = UDim2.new(1, -25, 0.5, -9)
        Indicator.BackgroundColor3 = Library.flags[flag] and Color3.fromRGB(131, 132, 255) or Color3.fromRGB(60, 60, 60)
        Instance.new("UICorner", Indicator)

        tgl.MouseButton1Click:Connect(function()
            Library.flags[flag] = not Library.flags[flag]
            Indicator.BackgroundColor3 = Library.flags[flag] and Color3.fromRGB(131, 132, 255) or Color3.fromRGB(60, 60, 60)
            callback(Library.flags[flag])
        end)
    end

    return Elements
end

return Library
