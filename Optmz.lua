-- Функции оптимизации для различных уровней качества
local function applyHighOptimization()
    local lighting = game:GetService("Lighting")
    local workspace = game:GetService("Workspace")
    local camera = workspace.CurrentCamera

    -- Применение настроек
    camera.FieldOfView = 70
    lighting.GlobalShadows = false

    for _, effect in pairs(lighting:GetChildren()) do
        if effect:IsA("PostEffect") then
            effect.Enabled = false
        end
    end

    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Explosion") then
            obj.Enabled = false
        elseif obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
            obj.Enabled = false
        end
    end

    workspace.StreamingEnabled = true
    workspace.StreamingMinRadius = 32
    workspace.StreamingTargetRadius = 64

    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.CanCollide = false
            obj.Anchored = true
            obj.CastShadow = false
        elseif obj:IsA("Constraint") then
            obj.Enabled = false
        end
    end

    for _, sound in pairs(workspace:GetDescendants()) do
        if sound:IsA("Sound") then
            sound.Volume = 0
        end
    end

    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("AnimationController") or obj:IsA("Animator") then
            obj:Stop()
        end
    end

    for _, gui in pairs(game:GetService("StarterGui"):GetChildren()) do
        if gui:IsA("ScreenGui") or gui:IsA("BillboardGui") then
            gui.Enabled = false
        end
    end

    lighting.Brightness = 1
    lighting.Ambient = Color3.fromRGB(128, 128, 128)
    lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    lighting.EnvironmentDiffuseScale = 0
    lighting.EnvironmentSpecularScale = 0
    lighting.FogEnd = 1000000
    lighting.FogStart = 1000000
    lighting.Bloom.Enabled = false
    lighting.Blur.Enabled = false
    lighting.ColorCorrection.Enabled = false
    lighting.SunRays.Enabled = false

    print("High optimization applied successfully!")
end

local function applyMediumOptimization()
    local lighting = game:GetService("Lighting")
    local workspace = game:GetService("Workspace")
    local camera = workspace.CurrentCamera

    -- Применение настроек
    camera.FieldOfView = 70
    lighting.GlobalShadows = false

    for _, effect in pairs(lighting:GetChildren()) do
        if effect:IsA("PostEffect") then
            effect.Enabled = false
        end
    end

    workspace.StreamingEnabled = true
    workspace.StreamingMinRadius = 64
    workspace.StreamingTargetRadius = 128

    print("Medium optimization applied successfully!")
end

local function applyLowOptimization()
    local lighting = game:GetService("Lighting")
    local workspace = game:GetService("Workspace")
    local camera = workspace.CurrentCamera

    -- Применение настроек
    camera.FieldOfView = 70
    lighting.GlobalShadows = true

    print("Low optimization applied successfully!")
end

-- Восстановление стандартных настроек
local function disableOptimization()
    local lighting = game:GetService("Lighting")
    local workspace = game:GetService("Workspace")

    -- Восстановление настроек
    lighting.GlobalShadows = true

    for _, effect in pairs(lighting:GetChildren()) do
        if effect:IsA("PostEffect") then
            effect.Enabled = true
        end
    end

    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Explosion") then
            obj.Enabled = true
        elseif obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
            obj.Enabled = true
        end
    end

    workspace.StreamingEnabled = false

    for _, sound in pairs(workspace:GetDescendants()) do
        if sound:IsA("Sound") then
            sound.Volume = 1
        end
    end

    print("Optimization disabled successfully!")
end
-- Создание GUI интерфейса
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local HighButton = Instance.new("TextButton")
local MediumButton = Instance.new("TextButton")
local LowButton = Instance.new("TextButton")
local DisableButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")

ScreenGui.Name = "OptimizationGui"
ScreenGui.Parent = game.CoreGui

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Position = UDim2.new(0.5, -100, 0.5, -75)
Frame.Size = UDim2.new(0, 200, 0, 220)
Frame.BackgroundTransparency = 0.5
Frame.BorderSizePixel = 0
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.Active = true
Frame.Draggable = true

Title.Name = "Title"
Title.Parent = Frame
Title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0.2, 0)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Select Optimization Level"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.TextWrapped = true

HighButton.Name = "HighButton"
HighButton.Parent = Frame
HighButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
HighButton.Position = UDim2.new(0.1, 0, 0.3, 0)
HighButton.Size = UDim2.new(0.8, 0, 0.15, 0)
HighButton.Font = Enum.Font.SourceSansBold
HighButton.Text = "High"
HighButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HighButton.TextScaled = true
HighButton.TextWrapped = true

MediumButton.Name = "MediumButton"
MediumButton.Parent = Frame
MediumButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
MediumButton.Position = UDim2.new(0.1, 0, 0.5, 0)
MediumButton.Size = UDim2.new(0.8, 0, 0.15, 0)
MediumButton.Font = Enum.Font.SourceSansBold
MediumButton.Text = "Medium"
MediumButton.TextColor3 = Color3.fromRGB(0, 0, 0)
MediumButton.TextScaled = true
MediumButton.TextWrapped = true

LowButton.Name = "LowButton"
LowButton.Parent = Frame
LowButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
LowButton.Position = UDim2.new(0.1, 0, 0.7, 0)
LowButton.Size = UDim2.new(0.8, 0, 0.15, 0)
LowButton.Font = Enum.Font.SourceSansBold
LowButton.Text = "Low"
LowButton.TextColor3 = Color3.fromRGB(0, 0, 0)
LowButton.TextScaled = true
LowButton.TextWrapped = true

DisableButton.Name = "DisableButton"
DisableButton.Parent = Frame
DisableButton.BackgroundColor3 = Color3.fromRGB(128, 128, 128)
DisableButton.Position = UDim2.new(0.1, 0, 0.9, 0)
DisableButton.Size = UDim2.new(0.8, 0, 0.15, 0)
DisableButton.Font = Enum.Font.SourceSansBold
DisableButton.Text = "Disable"
DisableButton.TextColor3 = Color3.fromRGB(0, 0, 0)
DisableButton.TextScaled = true
DisableButton.TextWrapped = true

CloseButton.Name = "CloseButton"
CloseButton.Parent = Frame
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Position = UDim2.new(1, -20, 0, 0)
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextScaled = true
CloseButton.TextWrapped = true
-- Функции для кнопок
HighButton.MouseButton1Click:Connect(function()
    applyHighOptimization()
end)

MediumButton.MouseButton1Click:Connect(function()
    applyMediumOptimization()
end)

LowButton.MouseButton1Click:Connect(function()
    applyLowOptimization()
end)

DisableButton.MouseButton1Click:Connect(function()
    disableOptimization()
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Перемещение интерфейса
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Включение интерфейса при запуске
ScreenGui.Enabled = true

-- Скрипт завершён
print("Optimization GUI initialized successfully!")
