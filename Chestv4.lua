-- Services
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local chestThread

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

-- States
local States = {Misc = {AutoChest = true}}

-- GUI
local ChestGui = Instance.new("ScreenGui")
ChestGui.Name = "ChestCounterGui"
ChestGui.ResetOnSpawn = false
ChestGui.Parent = Player:WaitForChild("PlayerGui")

local ChestLabel = Instance.new("TextLabel")
ChestLabel.Size = UDim2.new(0,300,0,50)
ChestLabel.Position = UDim2.new(0.5,-150,0,20)
ChestLabel.BackgroundTransparency = 0.3
ChestLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
ChestLabel.TextColor3 = Color3.fromRGB(0,255,0)
ChestLabel.TextScaled = true
ChestLabel.Font = Enum.Font.SourceSansBold
ChestLabel.Text = "Loading..."
ChestLabel.Parent = ChestGui

-- Server hop
local placeId, jobId = game.PlaceId, game.JobId
local ServersApi = "https://games.roblox.com/v1/games/"..placeId.."/servers/Public?sortOrder=Asc&limit=10"

local function ListServers()
    local success, result = pcall(function()
        local raw = game:HttpGet(ServersApi)
        return HttpService:JSONDecode(raw)
    end)
    if success and result and result.data then
        return result.data
    end
    return {}
end

local function HopServer()
    local servers = ListServers()
    local validServers = {}
    for _, s in ipairs(servers) do
        if s.id ~= jobId and s.playing < s.maxPlayers then
            table.insert(validServers, s)
        end
    end

    if #validServers > 0 then
        local target = validServers[math.random(1,#validServers)]
        States.Misc.AutoChest = false
        print("🚀 Hop server mới:", target.id)
        pcall(function()
            TeleportService:TeleportToPlaceInstance(placeId, target.id, Player)
        end)
    else
        print("⚠️ Không tìm thấy server trống")
    end
end

-- AutoChest system
local function StartAutoChestSystem()
    local CollectedChests = {}

    local function StartChestThread()
        if chestThread then chestThread:Cancel() end
        States.Misc.AutoChest = true
        chestThread = task.spawn(function()
            while States.Misc.AutoChest do
                local chestsFolder = workspace:FindFirstChild("Chests")
                local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")

                if not hrp then task.wait(0.1) continue end

                if not chestsFolder or #chestsFolder:GetChildren() == 0 then
                    ChestLabel.Text = "❌ Không có Chest, hop server..."
                 loadstring(game:HttpGet("https://raw.githubusercontent.com/cthanh137/s-ss/refs/heads/main/Find%20Fruit"))()
                    return
                end

                local chests = chestsFolder:GetChildren()
                ChestLabel.Text = "🌟 Chest: "..#chests

                for _, chest in ipairs(chests) do
                    if not States.Misc.AutoChest then return end
                    if chest:IsA("Model") and chest.PrimaryPart then
                        hrp.CFrame = chest.PrimaryPart.CFrame + Vector3.new(0,4,0)
                        CollectedChests[chest] = true
                        task.wait(0.01)
                    end
                end

                task.wait(0.05)
            end
        end)
    end

    -- Auto respawn
    local function SetupAutoRespawn(char)
        char:WaitForChild("Humanoid").Died:Connect(function()
            task.wait(0.1)
            CollectedChests = {}
            StartChestThread()
        end)
    end

    if Player.Character then
        SetupAutoRespawn(Player.Character)
    end
    Player.CharacterAdded:Connect(SetupAutoRespawn)
    StartChestThread()
end

-- Luôn chạy lại nếu bị ngắt
while true do
  StartAutoChestSystem()
    task.wait(1)
end
