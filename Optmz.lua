-- Initialize UI elements
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local HighButton = Instance.new("TextButton")
local MediumButton = Instance.new("TextButton")
local LowButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local DisableButton = Instance.new("TextButton")

-- Configure ScreenGui
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Configure Frame
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Active = true
Frame.Draggable = true

-- Configure Title
Title.Parent = Frame
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Font = Enum.Font.SourceSans
Title.Text = "Optimization"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24
-- Configure HighButton
HighButton.Parent = Frame
HighButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
HighButton.Position = UDim2.new(0.1, 0, 0.3, 0)
HighButton.Size = UDim2.new(0.8, 0, 0, 30)
HighButton.Font = Enum.Font.SourceSans
HighButton.Text = "High"
HighButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HighButton.TextSize = 18

-- Configure MediumButton
MediumButton.Parent = Frame
MediumButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
MediumButton.Position = UDim2.new(0.1, 0, 0.5, 0)
MediumButton.Size = UDim2.new(0.8, 0, 0, 30)
MediumButton.Font = Enum.Font.SourceSans
MediumButton.Text = "Medium"
MediumButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MediumButton.TextSize = 18

-- Configure LowButton
LowButton.Parent = Frame
LowButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
LowButton.Position = UDim2.new(0.1, 0, 0.7, 0)
LowButton.Size = UDim2.new(0.8, 0, 0, 30)
LowButton.Font = Enum.Font.SourceSans
LowButton.Text = "Low"
LowButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LowButton.TextSize = 18

-- Configure CloseButton
CloseButton.Parent = Frame
CloseButton.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
CloseButton.Position = UDim2.new(0.85, 0, 0, 0)
CloseButton.Size = UDim2.new(0.15, 0, 0, 50)
CloseButton.Font = Enum.Font.SourceSans
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 24

-- Configure DisableButton
DisableButton.Parent = Frame
DisableButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
DisableButton.Position = UDim2.new(0.1, 0, 0.9, 0)
DisableButton.Size = UDim2.new(0.8, 0, 0, 30)
DisableButton.Font = Enum.Font.SourceSans
DisableButton.Text = "Disable Optimization"
DisableButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DisableButton.TextSize = 18
-- Save original settings
local originalSettings = {}

local function saveOriginalSettings()
    originalSettings["FogEnd"] = game.Lighting.FogEnd
    originalSettings["GlobalShadows"] = game.Lighting.GlobalShadows
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("Light") or obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") then
            originalSettings[obj] = obj:Clone()
        end
    end
end

-- Restore original settings
local function restoreOriginalSettings()
    for obj, original in pairs(originalSettings) do
        if typeof(obj) == "Instance" and obj:IsDescendantOf(workspace) then
            local parent = obj.Parent
            obj:Destroy()
            original.Parent = parent
        end
    end
    game.Lighting.FogEnd = originalSettings["FogEnd"]
    game.Lighting.GlobalShadows = originalSettings["GlobalShadows"]
    game:GetService("RunService"):Set3dRenderingEnabled(true)
end

-- Apply settings based on checkboxes
local function applySettings()
    for _, obj in pairs(workspace:GetDescendants()) do
        if disableParticles and (obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire")) then
            obj.Enabled = false
        elseif disableLights and obj:IsA("Light") then
            obj.Enabled = false
        elseif disableShadows and obj:IsA("BasePart") then
            obj.CastShadow = false
        elseif reduceTextures and (obj:IsA("MeshPart") or obj:IsA("UnionOperation")) then
            obj.Material = Enum.Material.SmoothPlastic
        elseif disablePhysics and obj:IsA("BasePart") then
            obj.Anchored = true
        elseif disableSounds and obj:IsA("Sound") then
            obj.Playing = false
        elseif disablePostProcessing and obj:IsA("PostEffect") then
            obj.Enabled = false
        end
    end
    game.Lighting.GlobalShadows = not disableShadows
    game.Lighting.FogEnd = 100000 -- Убираем синий эффект
    game:GetService("RunService"):Set3dRenderingEnabled(false)
end

-- High optimization
local function highOptimization()
    saveOriginalSettings()
    disableParticles = true
    disableLights = true
    disableShadows = true
    reduceTextures = true
    disablePhysics = true
    disableSounds = true
    disablePostProcessing = true
    applySettings()
end

-- Medium optimization
local function mediumOptimization()
    saveOriginalSettings()
    disableParticles = true
    disableLights = true
    disableShadows = false
    reduceTextures = true
    disablePhysics = false
    disableSounds = true
    disablePostProcessing = true
    applySettings()
end

-- Low optimization
local function lowOptimization()
    saveOriginalSettings()
    disableParticles = true
    disableLights = false
    disableShadows = false
    reduceTextures = false
    disablePhysics = false
    disableSounds = true
    disablePostProcessing = true
    applySettings()
end

-- Disable optimization
local function disableOptimization()
    restoreOriginalSettings()
end
HighButton.MouseButton1Click:Connect(highOptimization)
MediumButton.MouseButton1Click:Connect(mediumOptimization)
LowButton.MouseButton1Click:Connect(lowOptimization)
DisableButton.MouseButton1Click:Connect(disableOptimization)
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
