-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local vim = game:GetService("VirtualInputManager")

-- Fluent UI
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- Player shortcut
local player = Players.LocalPlayer
local spawnRemote = nil
pcall(function() spawnRemote = ReplicatedStorage:WaitForChild("Connections"):WaitForChild("Spawn") end)

-- Window
local Window = Fluent:CreateWindow({
    Title = "Markiwi Script Hub" .. Fluent.Version,
    SubTitle = "",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Tabs
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "" }),
    Fruits = Window:AddTab({ Title = "Fruit", Icon = "" }),
    Map = Window:AddTab({ Title = "Map", Icon = "" }),
	Drink = Window:AddTab({ Title = "Drink", Icon = "" }),
    Players = Window:AddTab({ Title = "Player", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "" })
}

-- Options
local Options = Fluent.Options

-- =====================================================
-- States
-- =====================================================
local chestThread = nil
local autoClaimSamThread = nil
local fruitEspEnabled = false
local States = {
    Misc = { AutoChest = false },
    Fruit = { AutoClaimSam = false, SamDelay = 1, FruitESP = false },
    Player = { FlightEnabled = false, FlightSpeed = 200 }
}

-- =====================================================
-- Flight
-- =====================================================
local flyConnection = nil
local FlightToggle = Tabs.Players:AddToggle("Flight", { Title = "Nhân vật bay", Default = false })
local FlightSlider = Tabs.Players:AddSlider("FlightSpeed", { Title = "Tốc độ bay", Default = 200, Min = 100, Max = 500, Rounding = 0 })

FlightSlider:OnChanged(function(Value)
    States.Player.FlightSpeed = Value
end)

FlightToggle:OnChanged(function(Value)
    States.Player.FlightEnabled = Value
    if Value then
        if flyConnection then flyConnection:Disconnect() end
        flyConnection = RunService.RenderStepped:Connect(function()
            if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
            local hrp = player.Character.HumanoidRootPart
            local camCF = workspace.CurrentCamera.CFrame
            local moveDir = Vector3.new()
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir += camCF.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir -= camCF.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir -= camCF.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir += camCF.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir -= Vector3.new(0,1,0) end
            hrp.Velocity = moveDir.Magnitude > 0 and moveDir.Unit * States.Player.FlightSpeed or Vector3.new(0,0,0)
        end)
    else
        if flyConnection then flyConnection:Disconnect() flyConnection = nil end
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
        end
    end
end)



--// Biến lưu

States = States or {}
States.Drink = States.Drink or {}
local SelectedDrink = "Cider+"
local remote

--// Hàm tìm Remote
local function findRemote()
    local m = workspace:FindFirstChild("Merchants")
    local b = m and m:FindFirstChild("BetterDrinkMerchant")
    local c = b and b:FindFirstChild("Clickable")
    local s = c and c:FindFirstChild("ShopDrinksPlus")
    local clk = s and s:FindFirstChild("Clicked")
    return clk and clk:FindFirstChild("Retum")
end
task.spawn(function()
    while not remote do
        remote = findRemote()
        task.wait(1)
    end
end)

--// Input số lượng muốn mua
local BuyBox = Tabs.Drink:AddInput("BuyDrinkAmount", {
    Title = "Số lượng",
    Default = "1",
    Placeholder = "số lượng...",
    Numeric = true,
    Finished = true,
})

--// Dropdown chọn loại nước
local DrinkDropdown = Tabs.Drink:AddDropdown("DrinkType", {
    Title = "Loại nước",
    Values = {"Cider+", "Lemonade+", "Juice+", "Smoothie+"},
    Multi = false,
    Default = 1,
})

DrinkDropdown:OnChanged(function(Value)
    SelectedDrink = Value
end)

--// Toggle Auto Buy
local BuyToggle = Tabs.Drink:AddToggle("AutoBuyDrink", {
    Title = "Tự động Mua nước",
    Default = false
})
local VIM = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

States = States or {}
States.Drink = States.Drink or {}

-- Danh sách đồ uống được phép thả
local AllowedDrinks = {
    ["Cider+"] = true,
    ["Lemonade+"] = true,
    ["Juice+"] = true,
    ["Smoothie+"] = true,
}

local DropAmount = 1

--// Ô nhập số lượng thả
local DropBox = Tabs.Drink:AddInput("DropDrinkAmount", {
    Title = "Số lượng thả",
    Default = "1",
    Placeholder = "Nhập số lượng...",
    Numeric = true,
    Finished = true,
})

DropBox:OnChanged(function(Value)
    local num = tonumber(Value)
    if num and num > 0 then
        DropAmount = num
    else
        DropAmount = 1
    end
end)

--// Toggle Auto Drop
local DropToggle = Tabs.Drink:AddToggle("AutoDropDrink", {
    Title = "Thả Nước",
    Default = false
})

DropToggle:OnChanged(function(Value)
    States.Drink.AutoDrop = Value
    if Value then
        task.spawn(function()
            autoDropOnce()
            States.Drink.AutoDrop = false -- tắt toggle sau khi xong
        end)
    end
end)

--// Hàm thả đúng số lượng nước
function autoDropOnce()
    local backpack, char = LocalPlayer.Backpack, LocalPlayer.Character
    if not (backpack and char) then return end

    local dropped = 0
    for _, tool in ipairs(backpack:GetChildren()) do
        if dropped >= DropAmount then break end
        if tool:IsA("Tool") and AllowedDrinks[tool.Name] then
            char.Humanoid:EquipTool(tool)
            task.wait(0.05)
            if tool.Parent == char then
                VIM:SendKeyEvent(true, Enum.KeyCode.Backspace, false, game)
                task.wait(0.05)
                VIM:SendKeyEvent(false, Enum.KeyCode.Backspace, false, game)
                dropped += 1
                task.wait(0.2)
            end
        end
    end
end
States.Drink = States.Drink or {}
getgenv().DRINK_DELAY = 0.001

--// Toggle Auto Drink
local DrinkToggle = Tabs.Drink:AddToggle("AutoDrink", {
    Title = "Tự động uống nước",
    Default = false
})

DrinkToggle:OnChanged(function(Value)
    States.Drink.AutoDrink = Value
    if Value then
        task.spawn(autoDrinkLoop)
    end
end)

--// Hàm uống nước
function autoDrinkLoop()
    while States.Drink.AutoDrink do
        local backpack, char = LocalPlayer.Backpack, LocalPlayer.Character
        if backpack and char and char:FindFirstChild("Humanoid") then
            for _, tool in ipairs(backpack:GetChildren()) do
                if not States.Drink.AutoDrink then break end
                if tool:IsA("Tool") and AllowedDrinks[tool.Name] then
                    char.Humanoid:EquipTool(tool)
                    task.wait(0.001)
                    if tool.Parent == char then
                        tool:Activate()
                        task.wait(getgenv().DRINK_DELAY)
                    end
                end
            end
        end
        task.wait(0.001)
    end
end
BuyToggle:OnChanged(function(Value)
    States.Drink.AutoBuy = Value

    if Value and remote then
        task.spawn(function()
            -- đọc trực tiếp số trong ô input
            local num = tonumber(BuyBox.Value) or 1
            for i = 1, num do
                if not States.Drink.AutoBuy then break end
                pcall(function()
                    remote:FireServer(SelectedDrink)
                end)
                task.wait(0.05)
            end
            -- mua xong thì tự tắt
            States.Drink.AutoBuy = false
            BuyToggle:SetValue(false)
        end)
    end
end)

-- ========================================
-- Advanced Auto Pickup Fruit Script (Server-safe)
-- ========================================




-- =====================================================
-- Auto Bring từng loại Fruit riêng biệt
-- =====================================================

-- Danh sách fruit hiếm muốn làm toggle
-- Danh sách fruit hiếm muốn làm toggle
local RareFruitsList = {
    "Candy","Spring","Barrier","Spring","Phoenix","Quake","Magma","Gas","Rumble","Flare","Luck","Hot","Dark","Plasma",
    "Chilly Fruit","Spin","Smelt","Rare Box","Venom Fruit","UltraRare Box","Swim","Slip"
}

-- Lưu trạng thái toggle cho từng fruit
States.Fruit.AutoBringFruits = {}

-- Debounce tránh spam
local lastGrab = {}

-- Hàm bring + equip nhanh
local function BringAndEquip(fruitTool)
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")
    if not (char and hrp and hum) then return end

    -- Chống spam 0.1s
    if tick() - (lastGrab[fruitTool] or 0) < 0.01 then return end
    lastGrab[fruitTool] = tick()

    -- Bring tool về HRP
    local handle = fruitTool:FindFirstChild("Handle")
    if handle then
        handle.CFrame = hrp.CFrame * CFrame.new(0, -10, 0)
    end

    -- Equip ngay lập tức
    pcall(function() hum:EquipTool(fruitTool) end)
end

-- Loop quét fruit liên tục (Heartbeat)
local bringConn
local function StartBringThread()
    if bringConn then return end
    bringConn = game:GetService("RunService").Heartbeat:Connect(function()
        local active = false
        for _, enabled in pairs(States.Fruit.AutoBringFruits) do
            if enabled then active = true break end
        end
        if not active then return end

        for _, v in pairs(workspace:GetChildren()) do
            if v:IsA("Tool") and v:FindFirstChild("Handle") then
                for fruitName, enabled in pairs(States.Fruit.AutoBringFruits) do
                    if enabled and string.find(v.Name, fruitName) then
                        BringAndEquip(v)
                    end
                end
            end
        end
    end)
end

-- Tạo toggle cho từng fruit
for _, fruitName in ipairs(RareFruitsList) do
    States.Fruit.AutoBringFruits[fruitName] = false
    local tgl = Tabs.Fruits:AddToggle("Bring_"..fruitName, {
        Title = "Tự động nhận trái :"..fruitName,
        Default = false
    })
    tgl:OnChanged(function(Value)
        States.Fruit.AutoBringFruits[fruitName] = Value
        StartBringThread()
    end)
end

-- =====================================================
-- Fruit ESP
-- =====================================================
local function createFruitESP(fruit)
    if not fruit:IsDescendantOf(workspace) then return end
    if fruit:FindFirstChild("FruitESP") then return end
    local target = fruit:FindFirstChild("Handle") or fruit.PrimaryPart or (fruit:IsA("BasePart") and fruit)
    if not target then return end

    -- BillboardGui holder
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "FruitESP"
    billboard.Size = UDim2.new(0,200,0,50)
    billboard.AlwaysOnTop = true
    billboard.Adornee = target
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.Parent = fruit

    -- Frame nền (tự co theo chữ)
    local frame = Instance.new("Frame")
    frame.AutomaticSize = Enum.AutomaticSize.X  -- co khung theo text
    frame.Size = UDim2.new(0, 0, 0, 24)        -- chiều cao cố định
    frame.AnchorPoint = Vector2.new(0.5, 1)
    frame.Position = UDim2.new(0.5, 0, 1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(0, 40, 80) -- nền xanh đậm
    frame.BackgroundTransparency = 0.25
    frame.BorderSizePixel = 0
    frame.Parent = billboard

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame

    -- Tên fruit
    local nameText = Instance.new("TextLabel")
    nameText.Size = UDim2.new(1, -10, 1, 0) -- có padding để chữ không dính mép
    nameText.Position = UDim2.new(0, 5, 0, 0)
    nameText.BackgroundTransparency = 1
    nameText.TextStrokeTransparency = 0.2
    nameText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameText.TextSize = 16
    nameText.Font = Enum.Font.GothamBold -- font đẹp
    nameText.TextColor3 = Color3.fromRGB(50, 200, 255) -- xanh sáng
    nameText.Text = fruit.Name
    nameText.Parent = frame

    -- Line (Drawing API)
    local line = Drawing.new("Line")
    line.Thickness = 1.5
    line.Color = Color3.fromRGB(50, 200, 255)
    line.Visible = true



    task.spawn(function()
        while billboard.Parent and fruitEspEnabled do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and target then
                local dist = (target.Position - player.Character.HumanoidRootPart.Position).Magnitude
                label.Text = string.format("%s\n%.0f", fruit.Name, dist)
            end
            task.wait(0.3)
        end
        if billboard then billboard:Destroy() end
    end)
end

local function StartFruitESP()
    for _, fruit in ipairs(workspace:GetDescendants()) do
        if fruit:IsA("Model") and fruit.Name:match("Fruit") then
            createFruitESP(fruit)
        end
    end
    workspace.DescendantAdded:Connect(function(obj)
        if fruitEspEnabled and obj:IsA("Model") and obj.Name:match("Fruit") then
            createFruitESP(obj)
        end
    end)
end

local FruitESP_Toggle = Tabs.Fruits:AddToggle("FruitESP", { Title = "Devil Fruit Location", Default = false })
FruitESP_Toggle:OnChanged(function(Value)
    fruitEspEnabled = Value
    States.Fruit.FruitESP = Value
    if Value then StartFruitESP()
    else
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("BillboardGui") and v.Name == "FruitESP" then v:Destroy() end
        end
    end
end)







-- ========================================
-- Bring Fruit Script (Tele + Pickup Remote)
-- ========================================





-- =====================================================
-- Player Spy / TP / ESP
-- =====================================================
States.Player.FullSpy = {
    SelectedPlayer = nil,
    Spectate = false,
    TPToPlayer = false
}

-- Hàm lấy danh sách người chơi (ngoại trừ LocalPlayer)
local function GetPlayerNames()
    local names = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            table.insert(names, p.Name)
        end
    end
    return names
end

-- Dropdown chọn người chơi
local PlayerDropdown = Tabs.Players:AddDropdown("PlayerDropdown", {
    Title = "Chọn người chơi",
    Values = GetPlayerNames(),
    Multi = false,
    Default = 1
})

PlayerDropdown:OnChanged(function(Value)
    States.Player.FullSpy.SelectedPlayer = Players:FindFirstChild(Value)
end)

-- Toggle Spectate (camera theo người chơi)
local SpectateToggle = Tabs.Players:AddToggle("SpectateToggle", {
    Title = "Xem góc nhìn người chơi",
    Default = false
})

SpectateToggle:OnChanged(function(Value)
    States.Player.FullSpy.Spectate = Value
    local target = States.Player.FullSpy.SelectedPlayer
    if Value and target and target.Character and target.Character:FindFirstChild("Humanoid") then
        workspace.CurrentCamera.CameraSubject = target.Character.Humanoid
    else
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
        end
    end
end)

-- Toggle Teleport đến người chơi
local TPToggle = Tabs.Players:AddToggle("TPToggle", {
    Title = "Dịch chuyển đến người chơi",
    Default = false
})

TPToggle:OnChanged(function(Value)
    States.Player.FullSpy.TPToPlayer = Value
end)

-- Loop thực thi Teleport + Spectate
task.spawn(function()
    while true do
        local target = States.Player.FullSpy.SelectedPlayer
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = target.Character.HumanoidRootPart

            -- Teleport đến người chơi
            if States.Player.FullSpy.TPToPlayer then
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = hrp.CFrame + Vector3.new(0,3,0)
                end
                States.Player.FullSpy.TPToPlayer = false -- tự tắt
                TPToggle:SetValue(false)
            end

            -- Nếu Spectate tắt thì reset camera về chính bạn
            if not States.Player.FullSpy.Spectate and workspace.CurrentCamera.CameraSubject ~= LocalPlayer.Character.Humanoid then
                workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
            end
        end

        -- Cập nhật dropdown khi có người chơi join/leave
        local currentNames = GetPlayerNames()
        if #currentNames ~= #PlayerDropdown.Values then
            PlayerDropdown.Values = currentNames
        end

        task.wait(0.03)
    end
end)

-- Cập nhật camera khi người chơi join/leave
Players.PlayerRemoving:Connect(function(plr)
    if States.Player.FullSpy.SelectedPlayer == plr then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
        end
        States.Player.FullSpy.Spectate = false
        SpectateToggle:SetValue(false)
    end
end)


-- =====================================================
-- Auto Chest

-- =====================================================
local function StartChestThread()
    if chestThread then task.cancel(chestThread) end
    chestThread = task.spawn(function()
        while States.Misc.AutoChest do
            local chests = workspace:FindFirstChild("Chests")
            if chests and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                for _, chest in ipairs(chests:GetChildren()) do
                    if not States.Misc.AutoChest then break end
                    if chest:IsA("Model") and chest.PrimaryPart then
                        player.Character.HumanoidRootPart.CFrame = chest.PrimaryPart.CFrame + Vector3.new(-1,-1,0)
                        task.wait(0.5)
                    end
                end
            end
            task.wait(1)
        end
    end)
end

local ToggleChest = Tabs.Misc:AddToggle("AutoChest", { Title = "Tự động nhặt rương - bị ban", Default = false })
ToggleChest:OnChanged(function(Value)
    States.Misc.AutoChest = Value
    if Value then StartChestThread()
    else if chestThread then task.cancel(chestThread) chestThread = nil end end
end)

-- =====================================================
-- Auto Claim Sam
-- =====================================================
local function StartAutoClaimSam()
    if autoClaimSamThread then return end
    autoClaimSamThread = task.spawn(function()
        local RemoteContainer = ReplicatedStorage:FindFirstChild("Connections")
        if not RemoteContainer then return end
        local ClaimRemote = RemoteContainer:FindFirstChild("Claim_Sam")
        if not ClaimRemote then return end
        while States.Fruit.AutoClaimSam do
            pcall(function() ClaimRemote:FireServer("Claim1") end)
            task.wait(States.Fruit.SamDelay or 1)
        end
        autoClaimSamThread = nil
    end)
end

local SamToggle = Tabs.Main:AddToggle("AutoSam", { Title = "Nhận sam từ xa", Default = false })
SamToggle:OnChanged(function(Value)
    States.Fruit.AutoClaimSam = Value
    if Value then StartAutoClaimSam() end
end)




-- =====================================================
-- Teleport Locations
-- =====================================================

    
  local tpLocations = {
	
	["Admin tặng quà"] = CFrame.new(-32.60 ,200003,  195),
    ["Đảo Sam"] = CFrame.new(-1302,218,-1352),
    ["Đảo cát lâu đài"] = CFrame.new(1231,224,-3242),
    ["Nhân vật quay lucky "] = CFrame.new(120,278,4946),
    ["Nhiệm Vụ Box Fish"] = CFrame.new(-1693,216,-328),
    ["Đảo Tím"] = CFrame.new(-5282,534,-7762),
    ["Đảo tuyết to"] = CFrame.new(6313,541,-1330),
    ["Đảo tuyết (cửa hàng súng)"] = CFrame.new(-1843,222,3406),
    ["Của hàng Krizma"] = CFrame.new(-1074,361,1671),
    ["Đảo bán nước"] = CFrame.new(1502,260,2173),
    ["Đảo tôn ngộ không"] = CFrame.new(4572,217,5059),
    ["Đảo nhà có cây"] = CFrame.new(1120,217,3351),
    ["Mật vụ CP9"] = CFrame.new(898,270,1219),
    ["Đảo cây lớn"] = CFrame.new(-6029,402,-8.5),
}  

local locationNames = {}
for name, _ in pairs(tpLocations) do table.insert(locationNames, name) end

local TPDropdown = Tabs.Map:AddDropdown("TPDropdown", { Title = "Teleport Locations", Values = locationNames, Multi = false })
TPDropdown:OnChanged(function(Value)
    local target = tpLocations[Value]
    if target and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local noclipConnection
        noclipConnection = RunService.Stepped:Connect(function()
            if player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
        task.wait(0.1)
        player.Character.HumanoidRootPart.CFrame = target
        task.wait(0.2)
        if noclipConnection then noclipConnection:Disconnect() end
    end
end)



-- =====================================================
-- Save / Interface Manager
-- =====================================================
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
Window:SelectTab(1)
SaveManager:LoadAutoloadConfig()

Fluent:Notify({ Title = "Bật Script Thành Công", Content = "Thỏ cảm ơn vì dã sử dụng dịch vũ của thỏ ", Duration = 8 })
