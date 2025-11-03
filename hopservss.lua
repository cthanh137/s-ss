--// SIMPLE SERVER HOP V7 - FILTERED VERSION
-- Chỉ giữ lại chức năng hop server, không scan, không webhook
-- Roblox TeleportService auto hop, không trùng server đã vào

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

local PLACE_ID     = game.PlaceId
local MAX_PAGES    = 50
local RETRY_DELAY  = 0.01      -- delay siêu nhỏ để hop nhanh
local HOP_COOLDOWN = 0.1      -- nghỉ chút trước teleport để an toàn

-- Lưu các server đã thử
local TriedServers = TeleportService:GetTeleportSetting("TriedServersList")
if typeof(TriedServers) ~= "table" then TriedServers = {} end
TriedServers[game.JobId] = true
TeleportService:SetTeleportSetting("TriedServersList", TriedServers)

-- Request GET với retry
local function safe_request_get(url)
    while true do
        local ok, res = pcall(function()
            return request and request({Url = url, Method = "GET"}) or (syn and syn.request and syn.request({Url = url, Method = "GET"}))
        end)
        if ok and res and res.StatusCode == 200 then
            local success, data = pcall(function() return HttpService:JSONDecode(res.Body) end)
            if success and data and data.data then
                return data
            end
        end
        task.wait(RETRY_DELAY)
    end
end

-- Tìm server chưa vào
local function FindServer()
    local cursor = ""
    for _ = 1, MAX_PAGES do
        local url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100&cursor=%s", PLACE_ID, cursor)
        local data = safe_request_get(url)
        for _, server in ipairs(data.data) do
            if not TriedServers[server.id] and server.playing < server.maxPlayers then
                return server.id
            end
        end
        cursor = data.nextPageCursor or ""
        if cursor == "" then break end
    end
    return nil
end

-- Vòng lặp hop server liên tục
while true do
    local targetJobId = FindServer()
    if targetJobId then
        TriedServers[targetJobId] = true
        TeleportService:SetTeleportSetting("TriedServersList", TriedServers)

        task.wait(HOP_COOLDOWN)
        local tpSuccess, tpErr = pcall(function()
            TeleportService:TeleportToPlaceInstance(PLACE_ID, targetJobId, LocalPlayer)
        end)
        if tpSuccess then
            break -- Teleport thành công, script sẽ chạy lại trong server mới
        else
            warn("Teleport error, retrying:", tpErr)
            task.wait(RETRY_DELAY)
        end
    else
        -- Không còn server nào → reset danh sách và lặp lại
        TriedServers = {}
        TriedServers[game.JobId] = true
        TeleportService:SetTeleportSetting("TriedServersList", TriedServers)
        task.wait(RETRY_DELAY)
    end
end
