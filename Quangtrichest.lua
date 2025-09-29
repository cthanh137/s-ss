local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local workspace = workspace
local RunService = game:GetService("RunService")

-- ===== Config =====
local RANGE = 3000000
local SCAN_DELAY = 0.25
local TP_DELAY = 0.05
local AUTO_ON = true
local SERVERHOP_URL = "https://pastebin.com/raw/Ru4UQDpN"
local serverHopExecuted = false

-- ===== UI + Overlay (rất mờ) =====
local function createUI()
    if game:GetService("CoreGui"):FindFirstChild("QuangTriHubUI") then
        return game:GetService("CoreGui").QuangTriHubUI
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "QuangTriHubUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game:GetService("CoreGui")

    -- Overlay cực mờ (chỉ thấy UI)
    local overlay = Instance.new("Frame")
    overlay.Name = "Overlay"
    overlay.Size = UDim2.new(1,0,1,0)
    overlay.Position = UDim2.new(0,0,0,0)
    overlay.BackgroundColor3 = Color3.fromRGB(0,0,0)
    overlay.BackgroundTransparency = 0.95 -- rất mờ
    overlay.ZIndex = 0
    overlay.Parent = screenGui

    -- Frame chính UI nổi 3D
    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.Size = UDim2.new(0, 360, 0, 170)
    frame.Position = UDim2.new(0.5, -180, 0.5, -85)
    frame.BackgroundColor3 = Color3.fromRGB(28,28,28)
    frame.BackgroundTransparency = 0.02
    frame.BorderSizePixel = 0
    frame.ZIndex = 1
    frame.Parent = screenGui

    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0,20)

    local gradient = Instance.new("UIGradient", frame)
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(44,44,44)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(22,22,22))
    }
    gradient.Rotation = 45

    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1,28,1,28)
    shadow.Position = UDim2.new(-0.03,-14,-0.03,-14)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://5055962707"
    shadow.ImageColor3 = Color3.fromRGB(0,0,0)
    shadow.ImageTransparency = 0.7
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10,10,118,118)
    shadow.ZIndex = 0
    shadow.Parent = screenGui

    -- Title
    local title = Instance.new("TextLabel", frame)
    title.Name = "Title"
    title.Size = UDim2.new(1, -20, 0, 30)
    title.Position = UDim2.new(0,10,0,8)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.Text = "🌟 QuangTri Hub"
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 1

    -- Beri
    local beriLabel = Instance.new("TextLabel", frame)
    beriLabel.Name = "BeriLabel"
    beriLabel.Size = UDim2.new(1, -20, 0, 28)
    beriLabel.Position = UDim2.new(0,10,0,48)
    beriLabel.BackgroundTransparency = 1
    beriLabel.Font = Enum.Font.Gotham
    beriLabel.TextSize = 18
    beriLabel.TextXAlignment = Enum.TextXAlignment.Left
    beriLabel.TextColor3 = Color3.fromRGB(0,210,150)
    beriLabel.Text = "Beri: 0"
    beriLabel.ZIndex = 1

    -- Chest count
    local chestLabel = Instance.new("TextLabel", frame)
    chestLabel.Name = "ChestLabel"
    chestLabel.Size = UDim2.new(1, -20, 0, 28)
    chestLabel.Position = UDim2.new(0,10,0,80)
    chestLabel.BackgroundTransparency = 1
    chestLabel.Font = Enum.Font.Gotham
    chestLabel.TextSize = 18
    chestLabel.TextXAlignment = Enum.TextXAlignment.Left
    chestLabel.TextColor3 = Color3.fromRGB(170,190,255)
    chestLabel.Text = "Chest đã lấy: 0"
    chestLabel.ZIndex = 1

    -- Status
    local statusLabel = Instance.new("TextLabel", frame)
    statusLabel.Name = "Status"
    statusLabel.Size = UDim2.new(1, -20, 0, 22)
    statusLabel.Position = UDim2.new(0,10,0,115)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextSize = 15
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.TextColor3 = Color3.fromRGB(200,200,200)
    statusLabel.Text = "Status: Idle"
    statusLabel.ZIndex = 1

    -- Glow hover animation
    RunService.RenderStepped:Connect(function()
        local mouse = Players.LocalPlayer:GetMouse()
        if mouse and frame and frame.AbsoluteSize and frame.AbsolutePosition then
            if mouse.X >= frame.AbsolutePosition.X and mouse.X <= frame.AbsolutePosition.X + frame.AbsoluteSize.X and
               mouse.Y >= frame.AbsolutePosition.Y and mouse.Y <= frame.AbsolutePosition.Y + frame.AbsoluteSize.Y then
                frame.BackgroundTransparency = 0
            else
                frame.BackgroundTransparency = 0.02
            end
        end
    end)

    return screenGui, beriLabel, chestLabel, statusLabel
end

local ui, beriLabel, chestLabel, statusLabel = createUI()
local chestCount = 0
local lastBeri = 0

-- ===== Helpers =====
local function getHRP()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        return char.HumanoidRootPart
    end
    return nil
end

local function tpTo(pos)
    local hrp = getHRP()
    if hrp then
        hrp.CFrame = CFrame.new(pos + Vector3.new(0,3,0))
    end
end

-- ===== Auto spawn if needed =====
task.spawn(function()
    local maxWait = 10
    local t = 0
    while t < maxWait do
        local spawnGui = game:GetService("CoreGui"):FindFirstChild("SpawnGui") or workspace:FindFirstChild("SpawnGui")
        if spawnGui then
            local button = spawnGui:FindFirstChildWhichIsA("TextButton") or spawnGui:FindFirstChildWhichIsA("ImageButton")
            if button then
                pcall(function() button.AutoButtonColor = false button.MouseButton1Click:Fire() end)
                break
            end
        end
        t = t + 0.5
        task.wait(0.5)
    end
end)

-- ===== Track Beri increases (real chest picks) =====
task.spawn(function()
    local userData = workspace:FindFirstChild("UserData") or workspace:WaitForChild("UserData",5)
    if not userData then return end
    local folder = userData:FindFirstChild("User_"..LocalPlayer.UserId) or userData:FindFirstChild(LocalPlayer.Name)
    if not folder then return end
    local data = folder:FindFirstChild("Data") or folder:WaitForChild("Data",5)
    if not data then return end
    local beriVal = data:FindFirstChild("Beri")
    if not beriVal then return end

    lastBeri = beriVal.Value
    beriLabel.Text = "Beri: "..tostring(lastBeri)

    beriVal:GetPropertyChangedSignal("Value"):Connect(function()
        local new = beriVal.Value
        local diff = new - lastBeri
        if diff > 0 then
            chestCount = chestCount + 1
            chestLabel.Text = "Chest đã lấy: "..tostring(chestCount)
            statusLabel.Text = "Status: Picking chest..."
        end
        lastBeri = new
        beriLabel.Text = "Beri: "..tostring(new)
    end)
end)

-- ===== Execute the exact pastebin line safely =====
local function execPastebinServerHop()
    if serverHopExecuted then return end
    serverHopExecuted = true
    statusLabel.Text = "Status: Executing server hop script..."
    task.spawn(function()
        task.wait(0.6) -- small delay to let things settle
        local ok, ret = pcall(function()
            local scriptData = game:HttpGet(SERVERHOP_URL, true)
            if not scriptData or scriptData == "" then
                error("Empty response from pastebin")
            end
            -- execute exactly the required line
            loadstring(scriptData)()
        end)
        if not ok then
            statusLabel.Text = "Status: Server hop failed: "..tostring(ret)
            warn("Server hop failed:", ret)
        end
    end)
end

-- ===== Main loop: auto farm; if no chest -> exec pastebin server hop =====
task.spawn(function()
    while true do
        if not AUTO_ON then break end
        local hrp = getHRP()
        local foundAnyChest = false

        local chestFolder = workspace:FindFirstChild("Chests")
        if chestFolder and hrp then
            for _, m in pairs(chestFolder:GetChildren()) do
                if m:IsA("Model") and tostring(m.Name):lower():find("chest") then
                    local pos = nil
                    if m.PrimaryPart then pos = m.PrimaryPart.Position
                    else
                        for _, p in pairs(m:GetChildren()) do
                            if p:IsA("BasePart") then pos = p.Position break end
                        end
                    end
                    if pos and (hrp.Position - pos).Magnitude <= RANGE then
                        foundAnyChest = true
                        tpTo(pos)
                        task.wait(TP_DELAY)
                    end
                end
            end
        else
            -- fallback search in workspace
            if hrp then
                for _, v in pairs(workspace:GetDescendants()) do
                    if (v:IsA("Part") or v:IsA("MeshPart")) and v.Name and tostring(v.Name):lower():find("chest") then
                        foundAnyChest = true
                        tpTo(v.Position)
                        task.wait(TP_DELAY)
                    end
                end
            end
        end

        if not foundAnyChest then
            -- no chest: execute pastebin line
            statusLabel.Text = "Status: No chest found -> running pastebin hop"
            AUTO_ON = false
            execPastebinServerHop()
            break
        end

        task.wait(SCAN_DELAY)
    end
end)
