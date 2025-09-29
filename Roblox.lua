local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local chestThread
local Lighting = game:GetService("Lighting")

-- Tạo BlurEffect nếu chưa có
local blur = Instance.new("BlurEffect")
blur.Size = 120  -- độ mờ (0 = không mờ, càng lớn càng mờ)
blur.Parent = Lighting

-- Nếu muốn tắt sau 3 giây:



-- Anti-Pedo list
local Pedo = {810637885,1635505118,772860717,605256495,684684692,835620275,857074792,4459421361,2013115337,684684692,451082957,571687119,4447020775,1137403348,8695097097}

-- Kick Pedo players
for _, p in pairs(Players:GetPlayers()) do
    if table.find(Pedo,p.UserId) then
        Player:Kick("Thoái khoải sever mau admin đang ở đây")
    end
end
Players.PlayerAdded:Connect(function(p)
    if table.find(Pedo,p.UserId) then
        Player:Kick("Thoái khoải sever mau admin đang ở đây")
    end
end)
-----------------------------------------------------------------
-- GUI
-- Tạo GUI nhỏ gọn chỉ hiển thị chữ

----------------------------------------------------------------------------------------

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

-- Tạo ScreenGui chính
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FullScreenChestGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

-- Tạo nền đen full màn hình
local Background = Instance.new("Frame")
Background.Size = UDim2.new(1,0,1,0)
Background.Position = UDim2.new(0,0,0,0)
Background.BackgroundColor3 = Color3.fromRGB(0,0,0)
Background.BackgroundTransparency = 1
Background.Parent = ScreenGui

-- Hàm tạo TextLabel nổi lên giữa màn hình
local function CreateCenteredLabel(text, yOffset, textSize, color)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.8,0,0, textSize+10)
    lbl.Position = UDim2.new(0.1, -lbl.Size.X.Offset/2, 0.8, yOffset)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = color
    lbl.TextStrokeColor3 = Color3.fromRGB(0,0,0)
    lbl.TextStrokeTransparency = 0
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = textSize
    lbl.TextScaled = false
    lbl.TextXAlignment = Enum.TextXAlignment.Center
    lbl.TextYAlignment = Enum.TextYAlignment.Center
    lbl.Parent = Background
    return lbl
end

-- Tạo 3 dòng chữ với emoji
local TitleLabel1 = CreateCenteredLabel("🎮 CHEST FARM HUB ", -90, 40, Color3.fromRGB(0,244,200))
local TitleLabel2 = CreateCenteredLabel("⚡ Admin Rabbit Hub Script ", -45, 40, Color3.fromRGB(200,20,1))
local BeriLabel = CreateCenteredLabel("💰 Beri: 0 ", 0, 55, Color3.fromRGB(0,255,0))
local ChestLabel = CreateCenteredLabel("🎁 Chest còn lại: 0 ", 55, 35, Color3.fromRGB(255,122,122))
local function HopServer()
    ChestLabel.Text = "🔄Hết chest🔄"
   loadstring(game:HttpGet("https://raw.githubusercontent.com/cthanh137/s-ss/refs/heads/main/Find%20Fruit"))()
end

-- AutoChest system
local function StartAutoChestSystem()
    if chestThread then return end

    chestThread = task.spawn(function()
        while true do
            local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
            if not hrp then continue end

            local chestsFolder = workspace:FindFirstChild("Chests")
            if not chestsFolder then
                ChestLabel.Text = "❌ Không tìm thấy Chests..."
                continue
            end

            -- Lấy tất cả chest còn PrimaryPart
            local chests = {}
            for _, c in ipairs(chestsFolder:GetChildren()) do
                if c:IsA("Model") and c.PrimaryPart then
                    table.insert(chests, c)
                end
            end

            -- Nếu không còn chest tạm thời, vẫn giữ loop
            if #chests == 0 then
                  HopServer()
                continue
            end

            -- Nhặt tất cả chest hiện tại
            for i = #chests, 1, -1 do
                local chest = chests[i]
                if chest and chest.PrimaryPart then
                    hrp.CFrame = chest.PrimaryPart.CFrame + Vector3.new(0, 0, 0)
                    task.wait(0.002)
                    -- update số chest còn trong server
                    local remaining = #chestsFolder:GetChildren()
                    ChestLabel.Text = " 💸 Chest còn: "..remaining
                end
            end
            --task.wait(0.001)  -- giảm lag
        end
    end)
end
local function getBeri()
    local success, userFolder = pcall(function()
        return Workspace:WaitForChild("UserData"):WaitForChild("User_"..LocalPlayer.UserId)
    end)
    if success and userFolder and userFolder:FindFirstChild("Data") then
        local dataFolder = userFolder.Data
        local beriValue = dataFolder:FindFirstChild("Beri")
        if beriValue then
            return beriValue
        end
    end
    return nil
end

-- Update GUI realtime
local beriValue = getBeri()
if beriValue then
    -- Update ban đầu
    BeriLabel.Text = "Beri: " .. beriValue.Value

    -- Kết nối sự kiện thay đổi
    beriValue.Changed:Connect(function(newVal)
        BeriLabel.Text = "Beri: " .. newVal
    end)
else
    warn("Không tìm thấy Beri")
end
-- Auto respawn
local function SetupAutoRespawn(char)
    char:WaitForChild("Humanoid").Died:Connect(function()
        StartAutoChestSystem()
    end)
end

if Player.Character then
    SetupAutoRespawn(Player.Character)
end
Player.CharacterAdded:Connect(SetupAutoRespawn)

-- Start system
StartAutoChestSystem()
