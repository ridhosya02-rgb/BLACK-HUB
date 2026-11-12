
--================================
-- BLACK HUB | STEAL AN EGG
-- MOBILE GUI
--================================
local TweenService = game:GetService("TweenService")

-- Simpan ukuran dan posisi awal
local originalSize = main.Size
local originalPosition = main.Position

-- Efek awal
main.Size = UDim2.fromOffset(0, 0)
main.BackgroundTransparency = 1

title.TextTransparency = 1
content.Visible = false

-- Animasi zoom dan fade
local zoom = TweenService:Create(
    main,
    TweenInfo.new(
        0.65,
        Enum.EasingStyle.Back,
        Enum.EasingDirection.Out
    ),
    {
        Size = originalSize,
        BackgroundTransparency = 0
    }
)

zoom:Play()
zoom.Completed:Wait()

-- Animasi judul
local titleTween = TweenService:Create(
    title,
    TweenInfo.new(0.5),
    {
        TextTransparency = 0
    }
)

titleTween:Play()
titleTween.Completed:Wait()

-- Tampilkan menu
content.Visible = true

-- Efek minimize
local function smoothMinimize()
    local tween = TweenService:Create(
        main,
        TweenInfo.new(
            0.35,
            Enum.EasingStyle.Quart,
            Enum.EasingDirection.Out
        ),
        {
            Size = UDim2.fromOffset(280, 50)
        }
    )
    tween:Play()
end

print("BLACK HUB ANIMATION LOADED!")

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "BLACK_HUB"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(280, 390)
main.Position = UDim2.new(0.5, -140, 0.5, -195)
main.BackgroundColor3 = Color3.fromRGB(12,12,12)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui

Instance.new("UICorner",main).CornerRadius =
    UDim.new(0,12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-80,0,50)
title.Position = UDim2.fromOffset(10,0)
title.BackgroundTransparency = 1
title.Text = "BLACK HUB"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 23
title.Parent = main

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(35,35)
close.Position = UDim2.new(1,-42,0,7)
close.BackgroundColor3 = Color3.fromRGB(90,25,25)
close.Text = "X"
close.TextColor3 = Color3.new(1,1,1)
close.Font = Enum.Font.GothamBold
close.Parent = main

local minimize = Instance.new("TextButton")
minimize.Size = UDim2.fromOffset(35,35)
minimize.Position = UDim2.new(1,-82,0,7)
minimize.BackgroundColor3 = Color3.fromRGB(40,40,40)
minimize.Text = "-"
minimize.TextColor3 = Color3.new(1,1,1)
minimize.Font = Enum.Font.GothamBold
minimize.Parent = main

local content = Instance.new("Frame")
content.Size = UDim2.new(1,0,1,-55)
content.Position = UDim2.fromOffset(0,55)
content.BackgroundTransparency = 1
content.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0,8)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.Parent = content

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0,5)
padding.Parent = content

local states = {}

local function makeButton(name, height)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1,-24,0,height or 40)
    button.BackgroundColor3 = Color3.fromRGB(35,35,35)
    button.TextColor3 = Color3.new(1,1,1)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 14
    button.Text = name .. " : OFF"
    button.Parent = content

    Instance.new("UICorner",button).CornerRadius =
        UDim.new(0,8)

    states[name] = false

    button.MouseButton1Click:Connect(function()
        states[name] = not states[name]

        button.Text = name ..
            (states[name] and " : ON" or " : OFF")

        button.BackgroundColor3 = states[name]
            and Color3.fromRGB(75,75,75)
            or Color3.fromRGB(35,35,35)
    end)

    return button
end

-- AUTO STEAL MENU
local label = Instance.new("TextLabel")
label.Size = UDim2.new(1,-24,0,28)
label.BackgroundTransparency = 1
label.Text = "AUTO STEAL - RARITY FILTER"
label.TextColor3 = Color3.fromRGB(220,220,220)
label.Font = Enum.Font.GothamBold
label.TextSize = 13
label.Parent = content

makeButton("AUTO STEAL",40)
makeButton("DIVINE",35)
makeButton("ETERNAL",35)

-- OTHER FEATURES
makeButton("ESP EGG",40)
makeButton("EGG DETECTOR",40)
makeButton("AUTO COLLECT",40)
makeButton("AUTO HATCH",40)

-- MINIMIZE
local minimized = false

minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    content.Visible = not minimized
    main.Size = minimized
        and UDim2.fromOffset(280,50)
        or UDim2.fromOffset(280,390)
end)

-- CLOSE
close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

print("BLACK HUB LOADED!")

