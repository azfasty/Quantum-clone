– Luxen Cloner Script
– Interface Liquid Glass moderne

local Players = game:GetService(“Players”)
local TweenService = game:GetService(“TweenService”)
local SoundService = game:GetService(“SoundService”)

local player = Players.LocalPlayer
local playerGui = player:WaitForChild(“PlayerGui”)

– Création du ScreenGui principal
local screenGui = Instance.new(“ScreenGui”)
screenGui.Name = “LuxenClonerUI”
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

– Frame principale avec effet Liquid Glass
local mainFrame = Instance.new(“Frame”)
mainFrame.Name = “MainFrame”
mainFrame.Size = UDim2.new(0, 450, 0, 280)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -140)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BackgroundTransparency = 0.3
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

– Corner arrondi pour la frame principale
local mainCorner = Instance.new(“UICorner”)
mainCorner.CornerRadius = UDim.new(0, 20)
mainCorner.Parent = mainFrame

– Effet de bordure Liquid Glass
local borderFrame = Instance.new(“Frame”)
borderFrame.Name = “BorderEffect”
borderFrame.Size = UDim2.new(1, 4, 1, 4)
borderFrame.Position = UDim2.new(0, -2, 0, -2)
borderFrame.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
borderFrame.BackgroundTransparency = 0.5
borderFrame.BorderSizePixel = 0
borderFrame.ZIndex = 0
borderFrame.Parent = mainFrame

local borderCorner = Instance.new(“UICorner”)
borderCorner.CornerRadius = UDim.new(0, 22)
borderCorner.Parent = borderFrame

– Gradient animé pour l’effet Liquid
local borderGradient = Instance.new(“UIGradient”)
borderGradient.Color = ColorSequence.new{
ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 150, 255)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 100, 255)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 200))
}
borderGradient.Rotation = 0
borderGradient.Parent = borderFrame

– Animation du gradient
local function animateBorder()
while borderFrame.Parent do
local tween = TweenService:Create(borderGradient, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {Rotation = 360})
tween:Play()
wait(3)
end
end
spawn(animateBorder)

– Titre
local titleLabel = Instance.new(“TextLabel”)
titleLabel.Name = “Title”
titleLabel.Size = UDim2.new(1, 0, 0, 60)
titleLabel.Position = UDim2.new(0, 0, 0, 20)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = “Luxen Cloner”
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 32
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Parent = mainFrame

– Label pour le champ de texte
local inputLabel = Instance.new(“TextLabel”)
inputLabel.Name = “InputLabel”
inputLabel.Size = UDim2.new(1, -40, 0, 25)
inputLabel.Position = UDim2.new(0, 20, 0, 90)
inputLabel.BackgroundTransparency = 1
inputLabel.Text = “Enter your server private link”
inputLabel.Font = Enum.Font.Gotham
inputLabel.TextSize = 14
inputLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
inputLabel.TextXAlignment = Enum.TextXAlignment.Left
inputLabel.Parent = mainFrame

– Champ de texte avec style moderne
local textBox = Instance.new(“TextBox”)
textBox.Name = “ServerLinkInput”
textBox.Size = UDim2.new(1, -40, 0, 45)
textBox.Position = UDim2.new(0, 20, 0, 120)
textBox.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
textBox.BackgroundTransparency = 0.4
textBox.BorderSizePixel = 0
textBox.PlaceholderText = “Paste link here…”
textBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 120)
textBox.Text = “”
textBox.Font = Enum.Font.Gotham
textBox.TextSize = 14
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.TextXAlignment = Enum.TextXAlignment.Left
textBox.ClearTextOnFocus = false
textBox.Parent = mainFrame

local textBoxCorner = Instance.new(“UICorner”)
textBoxCorner.CornerRadius = UDim.new(0, 15)
textBoxCorner.Parent = textBox

local textBoxPadding = Instance.new(“UIPadding”)
textBoxPadding.PaddingLeft = UDim.new(0, 15)
textBoxPadding.PaddingRight = UDim.new(0, 15)
textBoxPadding.Parent = textBox

– Bouton Start
local startButton = Instance.new(“TextButton”)
startButton.Name = “StartButton”
startButton.Size = UDim2.new(1, -40, 0, 50)
startButton.Position = UDim2.new(0, 20, 0, 190)
startButton.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
startButton.BackgroundTransparency = 0.2
startButton.BorderSizePixel = 0
startButton.Text = “Start”
startButton.Font = Enum.Font.GothamBold
startButton.TextSize = 18
startButton.TextColor3 = Color3.fromRGB(255, 255, 255)
startButton.AutoButtonColor = false
startButton.Parent = mainFrame

local buttonCorner = Instance.new(“UICorner”)
buttonCorner.CornerRadius = UDim.new(0, 15)
buttonCorner.Parent = startButton

– Effet hover sur le bouton
startButton.MouseEnter:Connect(function()
TweenService:Create(startButton, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
end)

startButton.MouseLeave:Connect(function()
TweenService:Create(startButton, TweenInfo.new(0.3), {BackgroundTransparency = 0.2}):Play()
end)

– Frame de chargement (cachée initialement)
local loadingFrame = Instance.new(“Frame”)
loadingFrame.Name = “LoadingFrame”
loadingFrame.Size = UDim2.new(1, 0, 1, 0)
loadingFrame.Position = UDim2.new(0, 0, 0, 0)
loadingFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
loadingFrame.BackgroundTransparency = 0
loadingFrame.BorderSizePixel = 0
loadingFrame.Visible = false
loadingFrame.ZIndex = 10
loadingFrame.Parent = screenGui

– Gradient pour le fond de chargement
local loadingGradient = Instance.new(“UIGradient”)
loadingGradient.Color = ColorSequence.new{
ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 10, 60)),  – Violet foncé
ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 20, 50))   – Bleu foncé
}
loadingGradient.Rotation = 45
loadingGradient.Parent = loadingFrame

– Container pour la barre de chargement
local loadingContainer = Instance.new(“Frame”)
loadingContainer.Name = “LoadingContainer”
loadingContainer.Size = UDim2.new(0, 400, 0, 80)
loadingContainer.Position = UDim2.new(0.5, -200, 0.5, -40)
loadingContainer.BackgroundTransparency = 1
loadingContainer.Parent = loadingFrame

– Texte de chargement
local loadingText = Instance.new(“TextLabel”)
loadingText.Size = UDim2.new(1, 0, 0, 30)
loadingText.Position = UDim2.new(0, 0, 0, 0)
loadingText.BackgroundTransparency = 1
loadingText.Text = “Loading…”
loadingText.Font = Enum.Font.GothamBold
loadingText.TextSize = 20
loadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingText.Parent = loadingContainer

– Barre de chargement background
local progressBarBg = Instance.new(“Frame”)
progressBarBg.Name = “ProgressBarBg”
progressBarBg.Size = UDim2.new(1, 0, 0, 12)
progressBarBg.Position = UDim2.new(0, 0, 0, 45)
progressBarBg.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
progressBarBg.BorderSizePixel = 0
progressBarBg.Parent = loadingContainer

local progressBarBgCorner = Instance.new(“UICorner”)
progressBarBgCorner.CornerRadius = UDim.new(0, 6)
progressBarBgCorner.Parent = progressBarBg

– Barre de chargement remplie
local progressBar = Instance.new(“Frame”)
progressBar.Name = “ProgressBar”
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
progressBar.BorderSizePixel = 0
progressBar.Parent = progressBarBg

local progressBarCorner = Instance.new(“UICorner”)
progressBarCorner.CornerRadius = UDim.new(0, 6)
progressBarCorner.Parent = progressBar

– Gradient pour la barre de progression
local progressGradient = Instance.new(“UIGradient”)
progressGradient.Color = ColorSequence.new{
ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 150, 255)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 100, 255))
}
progressGradient.Parent = progressBar

– Fonction pour couper le son
local function muteGame()
SoundService.VolumeModifier = 0
for _, sound in pairs(workspace:GetDescendants()) do
if sound:IsA(“Sound”) then
sound.Volume = 0
end
end
end

– Fonction de chargement
local function startLoading()
– Masquer le menu principal
mainFrame.Visible = false

```
-- Afficher l'écran de chargement
loadingFrame.Visible = true

-- Couper le son
muteGame()

-- Messages de chargement avec pourcentages et durées
local loadingStages = {
    {text = "Checking link...", progress = 15, duration = 12},
    {text = "Established secure connection", progress = 30, duration = 15},
    {text = "Please wait, it can be long", progress = 50, duration = 18, dots = true},
    {text = "Verifying server authenticity", progress = 60, duration = 10},
    {text = "Decrypting server data", progress = 72, duration = 12},
    {text = "Synchronizing with server", progress = 85, duration = 13},
    {text = "Finalizing connection", progress = 95, duration = 8},
    {text = "Almost done", progress = 100, duration = 2}
}

-- Animation des points pour certains messages
local dotsCoroutine

for _, stage in ipairs(loadingStages) do
    local targetProgress = stage.progress / 100
    local currentProgress = progressBar.Size.X.Scale
    local steps = 60 -- 60 étapes pour une animation fluide
    local stepDuration = stage.duration / steps
    local progressIncrement = (targetProgress - currentProgress) / steps
    
    -- Démarrer l'animation des points si nécessaire
    if stage.dots then
        dotsCoroutine = coroutine.create(function()
            local dotCount = 0
            while true do
                dotCount = (dotCount % 3) + 1
                local dots = string.rep(".", dotCount)
                loadingText.Text = stage.text .. dots .. " " .. math.floor(progressBar.Size.X.Scale * 100) .. "%"
                wait(0.5)
            end
        end)
    end
    
    -- Animation de la progression
    for i = 1, steps do
        currentProgress = currentProgress + progressIncrement
        progressBar.Size = UDim2.new(currentProgress, 0, 1, 0)
        
        if stage.dots and dotsCoroutine then
            coroutine.resume(dotsCoroutine)
        else
            loadingText.Text = stage.text .. " " .. math.floor(currentProgress * 100) .. "%"
        end
        
        wait(stepDuration)
    end
    
    -- Arrêter l'animation des points
    if dotsCoroutine then
        dotsCoroutine = nil
    end
    
    -- Assurer que la progression atteint exactement la valeur cible
    progressBar.Size = UDim2.new(targetProgress, 0, 1, 0)
    if not stage.dots then
        loadingText.Text = stage.text .. " " .. stage.progress .. "%"
    end
    
    wait(0.5)
end

-- À la fin du chargement
wait(0.5)
loadingText.Text = "Complete!"
wait(1)

-- Vous pouvez ajouter ici ce qui se passe après le chargement
-- Par exemple, afficher un autre menu ou exécuter du code
```

end

– Action du bouton Start
startButton.MouseButton1Click:Connect(function()
local link = textBox.Text
if link ~= “” then
startLoading()
else
– Animation d’erreur si le champ est vide
for i = 1, 3 do
textBox.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
wait(0.1)
textBox.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
wait(0.1)
end
end
end)

print(“Luxen Cloner UI chargé avec succès!”)
