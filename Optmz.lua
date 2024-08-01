local originalSettings = {
    lighting = {
        GlobalShadows = game:GetService("Lighting").GlobalShadows,
        Brightness = game:GetService("Lighting").Brightness,
        Ambient = game:GetService("Lighting").Ambient,
        OutdoorAmbient = game:GetService("Lighting").OutdoorAmbient,
        EnvironmentDiffuseScale = game:GetService("Lighting").EnvironmentDiffuseScale,
        EnvironmentSpecularScale = game:GetService("Lighting").EnvironmentSpecularScale,
        FogEnd = game:GetService("Lighting").FogEnd,
        FogStart = game:GetService("Lighting").FogStart,
    },
    workspace = {
        StreamingEnabled = game:GetService("Workspace").StreamingEnabled,
        StreamingMinRadius = game:GetService("Workspace").StreamingMinRadius,
        StreamingTargetRadius = game:GetService("Workspace").StreamingTargetRadius,
    },
    camera = {
        FieldOfView = game:GetService("Workspace").CurrentCamera.FieldOfView,
    },
    effects = {},
    particles = {},
    sounds = {},
    guis = {},
}

local lighting = game:GetService("Lighting")
local workspace = game:GetService("Workspace")

for _, effect in pairs(lighting:GetChildren()) do
    if effect:IsA("PostEffect") then
        table.insert(originalSettings.effects, {effect = effect, enabled = effect.Enabled})
    end
end

for _, obj in pairs(workspace:GetDescendants()) do
    if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Explosion") then
        table.insert(originalSettings.particles, {obj = obj, enabled = obj.Enabled})
    elseif obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
        table.insert(originalSettings.particles, {obj = obj, enabled = obj.Enabled})
    elseif obj:IsA("Sound") then
        table.insert(originalSettings.sounds, {sound = obj, volume = obj.Volume})
    elseif obj:IsA("ScreenGui") or obj:IsA("BillboardGui") then
        table.insert(originalSettings.guis, {gui = obj, enabled = obj.Enabled})
    end
end
local function applyHighOptimization()
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
        elseif obj:IsA("BasePart") then
            obj.CanCollide = false
            obj.Anchored = true
            obj.CastShadow = false
        elseif obj:IsA("Constraint") then
            obj.Enabled = false
        elseif obj:IsA("AnimationController") or obj:IsA("Animator") then
            obj:Stop()
        end
    end

    workspace.StreamingEnabled = true
    workspace.StreamingMinRadius = 32
    workspace.StreamingTargetRadius = 64

    for _, sound in pairs(workspace:GetDescendants()) do
        if sound:IsA("Sound") then
            sound.Volume = 0
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
    local camera = workspace.CurrentCamera

    -- Применение настроек
    camera.FieldOfView = 70
    lighting.GlobalShadows = true

    print("Low optimization applied successfully!")
end
local function disableOptimization()
    local lighting = game:GetService("Lighting")
    local workspace = game:GetService("Workspace")

    -- Восстановление настроек освещения
    lighting.GlobalShadows = originalSettings.lighting.GlobalShadows
    lighting.Brightness = originalSettings.lighting.Brightness
    lighting.Ambient = originalSettings.lighting.Ambient
    lighting.OutdoorAmbient = originalSettings.lighting.OutdoorAmbient
    lighting.EnvironmentDiffuseScale = originalSettings.lighting.EnvironmentDiffuseScale
    lighting.EnvironmentSpecularScale = originalSettings.lighting.EnvironmentSpecularScale
    lighting.FogEnd = originalSettings.lighting.FogEnd
    lighting.FogStart = originalSettings.lighting.FogStart

    -- Восстановление настроек рабочей области
    workspace.StreamingEnabled = originalSettings.workspace.StreamingEnabled
    workspace.StreamingMinRadius = originalSettings.workspace.StreamingMinRadius
    workspace.StreamingTargetRadius = originalSettings.workspace.StreamingTargetRadius

    -- Восстановление настроек камеры
    workspace.CurrentCamera.FieldOfView = originalSettings.camera.FieldOfView

    -- Восстановление всех эффектов
    for _, setting in pairs(originalSettings.effects) do
        setting.effect.Enabled = setting.enabled
    end

    -- Восстановление всех эмиттеров частиц, следов и взрывов
    for _, setting in pairs(originalSettings.particles) do
        setting.obj.Enabled = setting.enabled
    end

    -- Восстановление всех звуков
    for _, setting in pairs(originalSettings.sounds) do
        setting.sound.Volume = setting.volume
    end

    -- Восстановление всех GUI
    for _, setting in pairs(originalSettings.guis) do
        setting.gui.Enabled = setting.enabled
    end

    print("Optimization disabled successfully!")
end
