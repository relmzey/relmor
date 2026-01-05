local Library = {windowCount = 0, flags = {}}
local b = {}
setmetatable(b, {
    __index = function(c, d) return game:GetService(d) end, 
    __newindex = function(e, f) e[f] = nil return end
})

local player = b.Players.LocalPlayer

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

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = b.HttpService:GenerateGUID()
ScreenGui.Parent = b.RunService:IsStudio() and player:WaitForChild("PlayerGui") or b.CoreGui
ScreenGui.Enabled = false

function Library:Init(config)
    config = config or {KeySystem = false}
    local function Unlock()
        if ScreenGui:FindFirstChild("KeyFrame") then ScreenGui.KeyFrame:Destroy() end
        ScreenGui.Enabled = true
    end
    if not config.KeySystem then Unlock(); return end
    if isfile and config.SaveFile and isfile(config.SaveFile) then
        if readfile(config.SaveFile) == config.Key then Unlock(); return end
    end
    local KeyFrame = Instance.new("Frame", ScreenGui)
    KeyFrame.Size = UDim2.new(0, 220, 0, 190); KeyFrame.Position = UDim2.new(0.5, -110, 0.5, -95)
    KeyFrame.BackgroundColor3 = Color3.fromRGB(12, 20, 30); Drag(KeyFrame)
    Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 12)
    local s = Instance.new("UIStroke", KeyFrame); s.Color = Color3.fromRGB(80, 180, 255)
    
    local H = Instance.new("TextLabel", KeyFrame)
    H.Size = UDim2.new(1, 0, 0, 35); H.BackgroundColor3 = Color3.fromRGB(20, 35, 50); H.Text = "🔑 KEY SYSTEM"
    H.TextColor3 = Color3.new(1,1,1); H.Font = Enum.Font.GothamBlack; Instance.new("UICorner", H)

    local I = Instance.new("TextBox", KeyFrame)
    I.Size = UDim2.new(0, 180, 0, 35); I.Position = UDim2.new(0.5, -90, 0, 50); I.BackgroundColor3 = Color3.fromRGB(25, 40, 55)
    I.TextColor3 = Color3.new(1,1,1); I.PlaceholderText = "Enter Key..."; I.Font = Enum.Font.GothamBlack; Instance.new("UICorner", I)

    local V = Instance.new("TextButton", KeyFrame)
    V.Size = UDim2.new(0, 180, 0, 35); V.Position = UDim2.new(0.5, -90, 0, 95); V.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
    V.Text = "VERIFY"; V.TextColor3 = Color3.new(1,1,1); V.Font = Enum.Font.GothamBlack; Instance.new("UICorner", V)

    local G = Instance.new("TextButton", KeyFrame)
    G.Size = UDim2.new(0, 180, 0, 35); G.Position = UDim2.new(0.5, -90, 0, 140); G.BackgroundColor3 = Color3.fromRGB(80, 120, 200)
    G.Text = "GET KEY"; G.TextColor3 = Color3.new(1,1,1); G.Font = Enum.Font.GothamBold; Instance.new("UICorner", G)

    V.MouseButton1Click:Connect(function()
        if I.Text == config.Key then if writefile then writefile(config.SaveFile, config.Key) end Unlock() else I.Text = ""; I.PlaceholderText = "WRONG" end
    end)
    G.MouseButton1Click:Connect(function() if setclipboard then setclipboard(config.Discord) end end)
end

function Library:Window(text)
    Library.windowCount = Library.windowCount + 1
    local open = true
    local M = Instance.new("Frame", ScreenGui)
    M.BackgroundColor3 = Color3.fromRGB(12, 20, 30); M.Size = UDim2.new(0, 220, 0, 300)
    M.Position = UDim2.new(0, 25 + (230 * (Library.windowCount - 1)), 0, 50); Drag(M)
    Instance.new("UICorner", M).CornerRadius = UDim.new(0, 12)
    local s = Instance.new("UIStroke", M); s.Color = Color3.fromRGB(80, 180, 255); s.Thickness = 2

    local H = Instance.new("Frame", M); H.Size = UDim2.new(1, 0, 0, 40); H.BackgroundColor3 = Color3.fromRGB(20, 35, 50)
    Instance.new("UICorner", H).CornerRadius = UDim.new(0, 12)

    local T = Instance.new("TextLabel", H); T.Size = UDim2.new(1, -70, 1, 0); T.Position = UDim2.new(0, 12, 0, 0)
    T.BackgroundTransparency = 1; T.Text = text; T.TextColor3 = Color3.new(1,1,1); T.Font = Enum.Font.GothamBlack; T.TextSize = 15; T.TextXAlignment = 0

    local btn = Instance.new("TextButton", H); btn.Size = UDim2.new(0, 28, 0, 28); btn.Position = UDim2.new(1, -34, 0, 6)
    btn.Text = "-"; btn.BackgroundColor3 = Color3.fromRGB(60, 80, 110); btn.TextColor3 = Color3.new(1,1,1); btn.Font = 0; Instance.new("UICorner", btn)

    local B = Instance.new("ScrollingFrame", M); B.Size = UDim2.new(1, 0, 1, -45); B.Position = UDim2.new(0, 0, 0, 45)
    B.BackgroundTransparency = 1; B.ScrollBarThickness = 0; B.AutomaticCanvasSize = 2
    local L = Instance.new("UIListLayout", B); L.Padding = UDim.new(0, 8); L.HorizontalAlignment = 1

    btn.MouseButton1Click:Connect(function()
        open = not open; B.Visible = open; M.Size = open and UDim2.new(0, 220, 0, 300) or UDim2.new(0, 220, 0, 40); btn.Text = open and "-" or "+"
    end)

    local E = {}
    function E:Button(n, c)
        local b = Instance.new("TextButton", B); b.Size = UDim2.new(0, 200, 0, 38); b.BackgroundColor3 = Color3.fromRGB(30, 45, 65)
        b.Text = n; b.TextColor3 = Color3.new(1,1,1); b.Font = Enum.Font.GothamBlack; b.TextSize = 14; Instance.new("UICorner", b)
        b.MouseButton1Click:Connect(c)
    end

    function E:Toggle(n, f, d, c)
        Library.flags[f] = d; local t = Instance.new("TextButton", B); t.Size = UDim2.new(0, 200, 0, 38)
        t.BackgroundColor3 = Color3.fromRGB(30, 45, 65); t.Text = "    "..n; t.TextColor3 = Color3.new(1,1,1); t.Font = Enum.Font.GothamBlack
        t.TextXAlignment = 0; Instance.new("UICorner", t)
        local s = Instance.new("Frame", t); s.Size = UDim2.new(0, 14, 0, 14); s.Position = UDim2.new(1, -25, 0.5, -7)
        s.BackgroundColor3 = d and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 60, 60); Instance.new("UICorner", s).CornerRadius = UDim.new(1,0)
        t.MouseButton1Click:Connect(function()
            Library.flags[f] = not Library.flags[f]; s.BackgroundColor3 = Library.flags[f] and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 60, 60)
            c(Library.flags[f])
        end)
    end

    function E:Slider(n, min, max, d, c)
        local st = Instance.new("TextLabel", B); st.Size = UDim2.new(0, 200, 0, 20); st.BackgroundTransparency = 1
        st.Text = n..": "..d; st.TextColor3 = Color3.new(1,1,1); st.Font = Enum.Font.GothamBlack; st.TextSize = 14
        local bg = Instance.new("Frame", B); bg.Size = UDim2.new(0, 180, 0, 14); bg.BackgroundColor3 = Color3.fromRGB(20, 30, 40)
        Instance.new("UICorner", bg).CornerRadius = UDim.new(1,0); local fill = Instance.new("Frame", bg)
        fill.Size = UDim2.new((d-min)/(max-min), 0, 1, 0); fill.BackgroundColor3 = Color3.fromRGB(0, 200, 255); Instance.new("UICorner", fill).CornerRadius = UDim.new(1,0)
        local function update(input)
            local x = math.clamp((input.Position.X - bg.AbsolutePosition.X) / bg.AbsoluteSize.X, 0, 1)
            fill.Size = UDim2.new(x, 0, 1, 0); local val = math.floor(min + (x * (max - min))); st.Text = n..": "..val; c(val)
        end
        bg.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 then
                local con = b.RunService.RenderStepped:Connect(function() update(b.UserInputService:GetMouseLocation()) end)
                b.UserInputService.InputEnded:Connect(function(i2) if i2.UserInputType == Enum.UserInputType.MouseButton1 then con:Disconnect() end end)
            end
        end)
    end
    return E
end
return Library
