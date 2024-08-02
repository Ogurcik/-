-- Initialize UI elements
-- Initialize UI elements
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local ApplyButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")

-- Configure ScreenGui
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Configure Frame
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.Position = UDim2.new(0.5, -150, 0.5, -200)
Frame.Size = UDim2.new(0, 300, 0, 400)
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

-- Configure ScrollingFrame
ScrollingFrame.Parent = Frame
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ScrollingFrame.Position = UDim2.new(0, 0, 0.125, 0)
ScrollingFrame.Size = UDim2.new(1, 0, 0.75, 0)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
ScrollingFrame.ScrollBarThickness = 10

-- Configure UIListLayout
UIListLayout.Parent = ScrollingFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Configure ApplyButton
ApplyButton.Parent = Frame
ApplyButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
ApplyButton.Position = UDim2.new(0.1, 0, 0.875, 0)
ApplyButton.Size = UDim2.new(0.8, 0, 0.1, 0)
ApplyButton.Font = Enum.Font.SourceSans
ApplyButton.Text = "Apply Optimization"
ApplyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ApplyButton.TextSize = 18

-- Configure CloseButton
CloseButton.Parent = Frame
CloseButton.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
CloseButton.Position = UDim2.new(0.85, 0, 0, 0)
CloseButton.Size = UDim2.new(0.15, 0, 0, 50)
CloseButton.Font = Enum.Font.SourceSans
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 24

-- Function to create a checkbox
local function createCheckbox(text)
    local Checkbox = Instance.new("TextButton")
    Checkbox.Parent = ScrollingFrame
    Checkbox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    Checkbox.Size = UDim2.new(0.9, 0, 0, 30)
    Checkbox.Font = Enum.Font.SourceSans
    Checkbox.Text = text
    Checkbox.TextColor3 = Color3.fromRGB(255, 255, 255)
    Checkbox.TextSize = 18
    Checkbox.TextWrapped = true

    local isChecked = false
    Checkbox.MouseButton1Click:Connect(function()
        isChecked = not isChecked
        if isChecked then
            Checkbox.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        else
            Checkbox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        end
    end)
    return {button = Checkbox, isChecked = function() return isChecked end}
end

local checkboxes = {}
table.insert(checkboxes, createCheckbox("Disable Particles"))
table.insert(checkboxes, createCheckbox("Disable Lights"))
table.insert(checkboxes, createCheckbox("Disable Shadows"))
table.insert(checkboxes, createCheckbox("Reduce Textures"))
table.insert(checkboxes, createCheckbox("Disable Physics"))
table.insert(checkboxes, createCheckbox("Disable Sounds"))
table.insert(checkboxes, createCheckbox("Disable Post Processing"))
table.insert(checkboxes, createCheckbox("Optimize Scripts"))

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
    saveOriginalSettings()
    for _, obj in pairs(workspace:GetDescendants()) do
        if checkboxes[1].isChecked() and (obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire")) then
            obj.Enabled = false
        elseif checkboxes[2].isChecked() and obj:IsA("Light") then
            obj.Enabled = false
        elseif checkboxes[3].isChecked() and obj:IsA("BasePart") then
            obj.CastShadow = false
        elseif checkboxes[4].isChecked() and (obj:IsA("MeshPart") or obj:IsA("UnionOperation")) then
            obj.Material = Enum.Material.SmoothPlastic
        elseif checkboxes[5].isChecked() and obj:IsA("BasePart") then
            obj.Anchored = true
        elseif checkboxes[6].isChecked() and obj:IsA("Sound") then
            obj.Playing = false
        elseif checkboxes[7].isChecked() and obj:IsA("PostEffect") then
            obj.Enabled = false
        end
    end
    game.Lighting.GlobalShadows = not checkboxes[3].isChecked()
    game.Lighting.FogEnd = 100000 -- Убираем синий эффект
    game:GetService("RunService"):Set3dRenderingEnabled(false)

    -- Optimize scripts
    if checkboxes[8].isChecked() then
        for _, script in pairs(game:GetDescendants()) do
            if script:IsA("LocalScript") or script:IsA("ModuleScript") or script:IsA("Script") then
                -- Пример оптимизации: удаление пустых строк и комментариев
                local source = script.Source
                source = source:gsub("%-%-.*", "")  -- Удаляем комментарии
                source = source:gsub("^%s*", "")    -- Удаляем начальные пробелы
                script.Source = source
            end
        end
    end
end

-- Connect buttons to functions
ApplyButton.MouseButton1Click:Connect(applySettings)
CloseButton.MouseButton1Click:Connect(function()
    restoreOriginalSettings()
    ScreenGui:Destroy()
end)    end
end
ApplyButton.MouseButton1Click:Connect(applySettings)
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
