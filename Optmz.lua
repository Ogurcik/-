local function disableUnusedScripts()
    for _, script in pairs(game:GetDescendants()) do
        if (script:IsA("Script") or script:IsA("LocalScript")) and script ~= script.Parent then
            script.Disabled = true
        end
    end
end

local function optimizeGame()
    local settings = settings()
    local lighting = game:GetService("Lighting")
    local workspace = game:GetService("Workspace")
    local camera = workspace.CurrentCamera
    
    -- Установим настройки качества на минимум
    settings.Rendering.QualityLevel = Enum.QualityLevel.Level01
    settings.Rendering.MeshLOD = Enum.MeshLOD.Level01
    settings.Rendering.TextureLOD = Enum.TextureLOD.Low
    
    -- Отключим глобальные тени и изменим технологию освещения
    lighting.GlobalShadows = false
    lighting.Technology = Enum.Technology.Compatibility
    
    -- Уменьшим поле зрения камеры
    camera.FieldOfView = 70
    
    -- Отключим пост-эффекты
    for _, effect in pairs(lighting:GetChildren()) do
        if effect:IsA("PostEffect") then
            effect.Enabled = false
        end
    end
    
    -- Отключим эмиттеры частиц, следы и взрывы
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Explosion") then
            obj.Enabled = false
        elseif obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
            obj.Enabled = false
        end
    end
    
    -- Уменьшение дальности прорисовки объектов
    workspace.StreamingEnabled = true
    workspace.StreamingMinRadius = 16
    workspace.StreamingTargetRadius = 32
    
    -- Отключение физических симуляций
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.CanCollide = false
            obj.Anchored = true
            obj.CastShadow = false
        elseif obj:IsA("Constraint") then
            obj.Enabled = false
        end
    end
    
    -- Отключим звук в игре
    for _, sound in pairs(workspace:GetDescendants()) do
        if sound:IsA("Sound") then
            sound.Volume = 0
        end
    end
    
    -- Отключение анимаций
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("AnimationController") or obj:IsA("Animator") then
            obj:Stop()
        end
    end
    
    -- Отключение несущественных GUI элементов
    for _, gui in pairs(game:GetService("StarterGui"):GetChildren()) do
        if gui:IsA("ScreenGui") or gui:IsA("BillboardGui") then
            gui.Enabled = false
        end
    end
    
    -- Отключение дополнительных эффектов в Lighting
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
    
    -- Отключение ненужных объектов (например, декоративных деталей)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("ParticleEmitter") or obj:IsA("SurfaceAppearance") then
            obj:Destroy()
        end
    end
    
    -- Дополнительная оптимизация скриптов
    disableUnusedScripts()
end

-- Запустим функцию оптимизации при запуске скрипта
optimizeGame()

-- Выведем сообщение об успешной оптимизации
print("Optimization applied successfully!")
